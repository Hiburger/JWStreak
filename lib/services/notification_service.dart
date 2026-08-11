import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

typedef NotificationTapHandler = Future<void> Function(ReminderPayload payload);
typedef NotificationErrorHandler =
    void Function(Object error, StackTrace stackTrace);

class ReminderPayload {
  const ReminderPayload({required this.book, required this.chapter});

  final String book;
  final int chapter;

  Map<String, Object> toJson() => <String, Object>{
    'book': book,
    'chapter': chapter,
  };

  factory ReminderPayload.fromJson(Map<String, Object?> json) {
    final Object? book = json['book'];
    final Object? chapter = json['chapter'];
    if (book is! String || chapter is! int) {
      throw const FormatException('Invalid reminder payload.');
    }
    return ReminderPayload(book: book, chapter: chapter);
  }
}

class NotificationService {
  NotificationService._internal();

  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  // Each reminder gets notification id = _reminderBaseId + reminder.id.
  static const int _reminderBaseId = 200;
  static const String _channelId = 'jwstreak_reminders';

  /// The ids that are *not* daily reminders, even though they sit above
  /// [_reminderBaseId]. [cancelAllReminders] has to skip these — see the
  /// note there for what taking them down by mistake broke.
  static const int _instantMessageId = 999;
  static const Set<int> _reservedIds = <int>{
    _streakRiskNotificationId,
    _dailyTextNotificationId,
    _sessionNotificationId,
    _instantMessageId,
  };

  /// Separate channel from [_channelId] so the always-present reading-session
  /// notification can be silenced (or turned off entirely) in Android's
  /// settings without also killing the daily reminders — they're different
  /// enough in kind that sharing one channel would make that impossible.
  ///
  /// `_v3`: channel importance is locked in by the OS the first time a
  /// channel is created and stays there even if the app later asks to
  /// recreate it at a different importance, so bumping this forces a fresh
  /// channel for every install that already saw an older one.
  ///
  /// The importance is [Importance.high] rather than something quieter
  /// because this notification is the only way back to the app mid-reading,
  /// and [AndroidNotificationDetails.silent] is what keeps it from peeking,
  /// buzzing or making a sound — that's a property of `silent`, not of the
  /// channel's tier, so "high" costs the user nothing here.
  static const String _sessionChannelId = 'jwstreak_reading_session_v3';
  static const int _sessionNotificationId = 700;

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// Matches the channel name registered in MainActivity.kt.
  static const MethodChannel _liveUpdateChannel = MethodChannel(
    'com.jwstreak.app/live_update',
  );

  NotificationTapHandler? _onTap;
  NotificationErrorHandler? _onError;
  bool _isInitialized = false;

  AndroidFlutterLocalNotificationsPlugin? get _androidPlugin => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  /// Non-null only on iOS/iPadOS, the same way [_androidPlugin] is non-null
  /// only on Android — every call site below picks whichever one exists.
  IOSFlutterLocalNotificationsPlugin? get _iosPlugin => _plugin
      .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin
      >();

  /// Every notification this app sends is a reminder, so they all share one
  /// presentation. Kept in a single constant so the Android and iOS sides
  /// can't quietly drift apart as reminders get added.
  static const NotificationDetails _reminderDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      _channelId,
      'JW Streak Reminders',
      channelDescription: 'Daily reminders for JW Streak reading flow.',
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  Future<void> initialize({
    required NotificationTapHandler onTap,
    required NotificationErrorHandler onError,
  }) async {
    _onTap = onTap;
    _onError = onError;
    if (_isInitialized) {
      return;
    }

    tz_data.initializeTimeZones();
    // `.identifier` is the IANA name ("Europe/Zurich") that tz.getLocation
    // expects; the other field on TimezoneInfo is a display name, which
    // wouldn't resolve.
    final String timezoneName =
        (await FlutterTimezone.getLocalTimezone()).identifier;
    tz.setLocalLocation(tz.getLocation(timezoneName));

    // The status bar only renders this icon's alpha channel (a plain white
    // silhouette), never its color — @mipmap/ic_launcher is the full-color
    // square app icon, which is why using it here used to show up as a
    // solid dark blob. ic_stat_notify (tool/icons/generate_notification_icon.py)
    // is the isolated glyph, already prepared for that.
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('ic_stat_notify');
    // iOS has no notification-channel concept and uses the app icon in the
    // banner, so there's nothing to point at here. Permissions are all left
    // false so initialize() stays silent: requestNotificationPermission()
    // below owns the prompt, on both platforms.
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        await _safelyHandlePayload(response.payload);
      },
    );

    await _createNotificationChannel();
    // A reading-session notification outlives the process that posted it, so
    // one can survive Android killing us mid-session. Nothing can legitimately
    // be in progress at app start, so clear any leftover.
    await endReadingSession();
    await requestNotificationPermission();

    if (kDebugMode) {
      debugPrint('NotificationService: Initialized successfully');
    }
    _isInitialized = true;
  }

  Future<void> _createNotificationChannel() async {
    if (kDebugMode) {
      debugPrint('NotificationService: Creating notification channel');
    }
    await _androidPlugin?.createNotificationChannel(
      AndroidNotificationChannel(
        _channelId,
        'JW Streak Reminders',
        description: 'Daily reminders for JW Streak reading flow.',
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
        showBadge: true,
      ),
    );
    // High: see the comment on [_sessionChannelId] for why. `silent` below
    // still keeps it from buzzing or peeking — that property doesn't depend
    // on the channel's importance tier.
    await _androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        _sessionChannelId,
        'Reading session',
        description:
            'Shown while a chapter is open in JW Library or on jw.org.',
        importance: Importance.high,
        playSound: false,
        enableVibration: false,
        showBadge: false,
      ),
    );
    if (kDebugMode) {
      debugPrint('NotificationService: Notification channel created');
    }
  }

  Future<void> handleAppLaunchNotification() async {
    final NotificationAppLaunchDetails? details = await _plugin
        .getNotificationAppLaunchDetails();
    if (details?.didNotificationLaunchApp ?? false) {
      await _safelyHandlePayload(details?.notificationResponse?.payload);
    }
  }

  /// Schedules one daily reminder that repeats at [time]. Each reminder uses a
  /// stable notification id derived from its database id.
  Future<void> scheduleReminder({
    required int id,
    required TimeOfDay time,
    required String title,
    required String body,
  }) async {
    final tz.TZDateTime firstTrigger = _nextInstanceFor(time);
    final AndroidScheduleMode scheduleMode = await _resolveScheduleMode();

    await _plugin.zonedSchedule(
      id: _reminderBaseId + id,
      title: title,
      body: body,
      scheduledDate: firstTrigger,
      notificationDetails: _reminderDetails,
      androidScheduleMode: scheduleMode,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    if (kDebugMode) {
      debugPrint(
        'NotificationService: Reminder $id scheduled for '
        '${firstTrigger.hour}:${firstTrigger.minute} (mode: $scheduleMode)',
      );
    }
  }

  Future<void> cancelReminder(int id) async {
    await _plugin.cancel(id: _reminderBaseId + id);
  }

  /// Shows an immediate one-off local notification (used for small in-app
  /// surprises like the settings heart easter egg).
  Future<void> showInstantMessage({
    required String title,
    required String body,
  }) async {
    await _plugin.show(
      id: _instantMessageId,
      title: title,
      body: body,
      notificationDetails: _reminderDetails,
    );
  }

  /// Puts up the "you're reading, come back when you're done" indicator, with
  /// a timer counting up from now.
  ///
  /// Three outcomes, in order of preference. Android 16 promotes it to a Live
  /// Update — a status bar chip with the timer inside. iOS 16.2+ shows a Live
  /// Activity on the lock screen and in the Dynamic Island. Neither is
  /// reachable through flutter_local_notifications (the first needs a
  /// promotion flag it doesn't expose, the second isn't a notification at
  /// all), so both go through one native channel. Older Android falls back to
  /// a plain ongoing notification; older iOS gets nothing, since a one-off
  /// banner would behave nothing like the thing it's standing in for.
  Future<void> startReadingSession({
    required String title,
    required String body,
  }) async {
    if (await _tryShowLiveUpdate(title: title, body: body)) {
      if (kDebugMode) {
        debugPrint(
          'NotificationService: reading session posted as Live Update',
        );
      }
      return;
    }
    // The fallback below is a notification, and only Android's is shaped like
    // what this is standing in for.
    if (defaultTargetPlatform != TargetPlatform.android) {
      return;
    }
    await _plugin.show(
      id: _sessionNotificationId,
      title: title,
      body: body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _sessionChannelId,
          'Reading session',
          channelDescription:
              'Shown while a chapter is open in JW Library or on jw.org.',
          importance: Importance.high,
          priority: Priority.high,
          // The pair that turns the timestamp into a live "12:34" counter
          // ticking upward, rendered by the system — no polling from us.
          usesChronometer: true,
          when: DateTime.now().millisecondsSinceEpoch,
          ongoing: true,
          autoCancel: false,
          silent: true,
          // Safety net for the case that actually matters here: Android is
          // free to kill this process while the user reads in another app,
          // and a posted notification outlives its process. Without a
          // timeout, an `ongoing` (so undismissable) notification could
          // strand the user with no way to clear it short of force-stopping
          // the app. Four hours is far past any real reading session.
          timeoutAfter: const Duration(hours: 4).inMilliseconds,
        ),
      ),
    );
    if (kDebugMode) {
      debugPrint('NotificationService: reading session notification shown');
    }
  }

  /// Asks the platform to post the session notification as an Android 16
  /// Live Update. Returns false — leaving the caller to fall back — on older
  /// releases, and on any platform-side refusal.
  Future<bool> _tryShowLiveUpdate({
    required String title,
    required String body,
  }) async {
    try {
      final bool? posted = await _liveUpdateChannel
          .invokeMethod<bool>('showReadingSession', <String, Object>{
            'channelId': _sessionChannelId,
            'notificationId': _sessionNotificationId,
            'title': title,
            'body': body,
            'startedAtMillis': DateTime.now().millisecondsSinceEpoch,
          });
      return posted ?? false;
    } catch (_) {
      // MissingPluginException on a build without the native side, or
      // anything the platform throws — either way, fall back.
      return false;
    }
  }

  /// Takes the session indicator down, whichever form it went up in.
  ///
  /// iOS needs the native call — a Live Activity isn't a notification and
  /// nothing else ends it. Android's promoted notification is posted under
  /// the same id through the same NotificationManager as the fallback, so
  /// the plugin cancel below covers both of its paths.
  Future<void> endReadingSession() async {
    try {
      await _liveUpdateChannel.invokeMethod<void>('endReadingSession');
    } catch (_) {
      // No native side on this build — nothing to end.
    }
    if (defaultTargetPlatform != TargetPlatform.android) {
      return;
    }
    if (kDebugMode) {
      debugPrint('NotificationService: reading session notification cancelled');
    }
    await _plugin.cancel(id: _sessionNotificationId);
  }

  static const int _dailyTextNotificationId = 600;

  /// Schedules the single optional daily-text reminder, replacing whatever
  /// was scheduled for it before (there is only ever one — no id to pass in,
  /// unlike the book-reading reminders list).
  Future<void> scheduleDailyTextReminder({
    required TimeOfDay time,
    required String title,
    required String body,
  }) async {
    final tz.TZDateTime firstTrigger = _nextInstanceFor(time);
    final AndroidScheduleMode scheduleMode = await _resolveScheduleMode();
    await _plugin.zonedSchedule(
      id: _dailyTextNotificationId,
      title: title,
      body: body,
      scheduledDate: firstTrigger,
      notificationDetails: _reminderDetails,
      androidScheduleMode: scheduleMode,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelDailyTextReminder() async {
    await _plugin.cancel(id: _dailyTextNotificationId);
  }

  static const int _streakRiskNotificationId = 500;

  /// Schedules a one-off evening warning if the streak is still inactive
  /// today. Call [cancelStreakRiskCheck] as soon as the user is active again.
  Future<void> scheduleStreakRiskCheck({
    required String title,
    required String body,
  }) async {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final tz.TZDateTime target = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      20,
    );
    if (!target.isAfter(now)) {
      return; // Too late today — the in-app banner already covers this.
    }
    final AndroidScheduleMode mode = await _resolveScheduleMode();
    await _plugin.zonedSchedule(
      id: _streakRiskNotificationId,
      title: title,
      body: body,
      scheduledDate: target,
      notificationDetails: _reminderDetails,
      androidScheduleMode: mode,
    );
  }

  Future<void> cancelStreakRiskCheck() async {
    await _plugin.cancel(id: _streakRiskNotificationId);
  }

  /// Cancels the scheduled daily reminders — and only those. Used before a
  /// full resync, so reminders the user has since deleted don't linger.
  ///
  /// This deliberately isn't `cancelAll()`. `cancelAll()` takes down every
  /// notification this app owns, including the ones with their own separate
  /// lifecycles ([_reservedIds]), and the resync it precedes runs on every
  /// dashboard refresh — which is to say after essentially every action.
  /// Two things that cost us:
  ///
  ///  - the reading-session notification was posted and then wiped by the
  ///    refresh a few milliseconds later, so it never survived long enough
  ///    to be seen. It looked exactly like the OS silently dropping it.
  ///  - the daily-text reminder is only ever scheduled from the reminder
  ///    setup screen, so once unscheduled here it stayed gone until the
  ///    user went back in and saved it again.
  ///
  /// Reminders are the pending notifications at or above [_reminderBaseId]
  /// that aren't one of the reserved singletons.
  Future<void> cancelAllReminders() async {
    final List<PendingNotificationRequest> pending = await _plugin
        .pendingNotificationRequests();
    for (final PendingNotificationRequest request in pending) {
      if (request.id >= _reminderBaseId && !_reservedIds.contains(request.id)) {
        await _plugin.cancel(id: request.id);
      }
    }
  }

  Future<AndroidScheduleMode> _resolveScheduleMode() async {
    // Prefer exact alarms; fall back to inexact if the permission is missing.
    try {
      final bool? canExact = await _androidPlugin
          ?.canScheduleExactNotifications();
      if (canExact == true) {
        return AndroidScheduleMode.exactAllowWhileIdle;
      }
    } catch (_) {
      // Fall back below.
    }
    return AndroidScheduleMode.inexactAllowWhileIdle;
  }

  Future<bool> requestNotificationPermission() async {
    final IOSFlutterLocalNotificationsPlugin? ios = _iosPlugin;
    if (ios != null) {
      final bool? granted = await ios.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }
    final bool? granted = await _androidPlugin
        ?.requestNotificationsPermission();
    return granted ?? true;
  }

  /// Opens the app's system settings page. Android only shows its own
  /// notification-permission dialog once per install — if the user declined
  /// it, [requestNotificationPermission] silently resolves without prompting
  /// again, so this is the only way left to let them grant it.
  Future<void> openNotificationSettings() async {
    await openAppSettings();
  }

  Future<bool> areNotificationsEnabled() async {
    final IOSFlutterLocalNotificationsPlugin? ios = _iosPlugin;
    if (ios != null) {
      final NotificationsEnabledOptions? options = await ios.checkPermissions();
      // Provisional authorisation still delivers reminders (quietly, straight
      // to the notification centre), so it counts as enabled here.
      return options == null ||
          options.isEnabled ||
          options.isProvisionalEnabled;
    }
    final bool? enabled = await _androidPlugin?.areNotificationsEnabled();
    return enabled ?? true;
  }

  /// Whether the OS currently allows this app to schedule exact alarms.
  /// On Android 12+ this can be revoked by the user; older versions always
  /// return `true`.
  Future<bool> canScheduleExactAlarms() async {
    try {
      final bool? canExact = await _androidPlugin
          ?.canScheduleExactNotifications();
      return canExact ?? true;
    } catch (_) {
      return true;
    }
  }

  /// Opens system settings so the user can grant the exact-alarm permission.
  /// Returns `true` if exact alarms are permitted after the request.
  Future<bool> requestExactAlarmPermission() async {
    try {
      await _androidPlugin?.requestExactAlarmsPermission();
      final bool? canExact = await _androidPlugin
          ?.canScheduleExactNotifications();
      return canExact ?? false;
    } catch (_) {
      return false;
    }
  }

  Future<void> _safelyHandlePayload(String? rawPayload) async {
    try {
      // Reminder notifications carry no payload — tapping simply opens the app
      // (the home screen already shows the next chapter to read).
      if (rawPayload == null || rawPayload.isEmpty) {
        return;
      }
      final Object? decoded = jsonDecode(rawPayload);
      if (decoded is! Map<String, Object?>) {
        throw const FormatException(
          'Notification payload is not a JSON object.',
        );
      }
      final ReminderPayload payload = ReminderPayload.fromJson(decoded);
      final NotificationTapHandler? onTap = _onTap;
      if (onTap == null) {
        throw StateError('Notification tap handler is not configured.');
      }
      await onTap(payload);
    } catch (error, stackTrace) {
      final NotificationErrorHandler? onError = _onError;
      if (onError == null) {
        rethrow;
      }
      onError(error, stackTrace);
    }
  }

  tz.TZDateTime _nextInstanceFor(TimeOfDay time) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime schedule = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (schedule.isBefore(now)) {
      schedule = schedule.add(const Duration(days: 1));
    } else if (schedule.isAtSameMomentAs(now)) {
      schedule = schedule.add(const Duration(minutes: 1));
    }
    if (kDebugMode) {
      debugPrint(
        'NotificationService: Next trigger at ${schedule.year}-${schedule.month}-${schedule.day} ${schedule.hour}:${schedule.minute}',
      );
    }
    return schedule;
  }
}
