import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../app_constants.dart';

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

@visibleForTesting
tz.TZDateTime nextReminderInstance({
  required tz.TZDateTime now,
  required TimeOfDay time,
  bool skipToday = false,
}) {
  tz.TZDateTime schedule = tz.TZDateTime(
    now.location,
    now.year,
    now.month,
    now.day,
    time.hour,
    time.minute,
  );
  if (schedule.isBefore(now)) {
    schedule = tz.TZDateTime(
      now.location,
      now.year,
      now.month,
      now.day + 1,
      time.hour,
      time.minute,
    );
  } else if (schedule.isAtSameMomentAs(now)) {
    schedule = schedule.add(const Duration(minutes: 1));
  }
  if (skipToday &&
      schedule.year == now.year &&
      schedule.month == now.month &&
      schedule.day == now.day) {
    schedule = tz.TZDateTime(
      now.location,
      now.year,
      now.month,
      now.day + 1,
      time.hour,
      time.minute,
    );
  }
  return schedule;
}

@visibleForTesting
tz.TZDateTime followingDayInstance(tz.TZDateTime date) => tz.TZDateTime(
  date.location,
  date.year,
  date.month,
  date.day + 1,
  date.hour,
  date.minute,
);

class NotificationService {
  NotificationService._internal();

  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;

  // Each reminder gets notification id = _reminderBaseId + reminder.id.
  static const int _reminderBaseId = 200;
  static const String _channelId = 'jwstreak_reminders';
  static const int _skipCompanionOffset = 10000;

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

  IOSFlutterLocalNotificationsPlugin? get _iosPlugin => _plugin
      .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin
      >();

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

  /// The device time zone this service last scheduled against, so a change
  /// can be noticed rather than assumed.
  String? _timeZoneName;

  Future<bool> refreshTimeZone() async {
    try {
      final String name = (await FlutterTimezone.getLocalTimezone()).identifier;
      if (name == _timeZoneName) {
        return false;
      }
      final tz.Location location = tz.getLocation(name);
      final bool isChange = _timeZoneName != null;
      _timeZoneName = name;
      tz.setLocalLocation(location);
      return isChange;
    } catch (_) {
      return false;
    }
  }

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
    await refreshTimeZone();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('ic_stat_notify');
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

  Future<void> scheduleReminder({
    required int id,
    required TimeOfDay time,
    required String title,
    required String body,
    bool skipToday = false,
  }) async {
    final tz.TZDateTime firstTrigger = _nextInstanceFor(
      time,
      skipToday: skipToday,
    );
    final AndroidScheduleMode scheduleMode = await _resolveScheduleMode();

    if (skipToday) {
      await _plugin.zonedSchedule(
        id: _reminderBaseId + id,
        title: title,
        body: body,
        scheduledDate: firstTrigger,
        notificationDetails: _reminderDetails,
        androidScheduleMode: scheduleMode,
      );
      await _plugin.zonedSchedule(
        id: _reminderBaseId + id + _skipCompanionOffset,
        title: title,
        body: body,
        scheduledDate: followingDayInstance(firstTrigger),
        notificationDetails: _reminderDetails,
        androidScheduleMode: scheduleMode,
      );
      if (kDebugMode) {
        debugPrint(
          'NotificationService: Reminder $id scheduled as two one-shots '
          'at ${firstTrigger.hour}:${firstTrigger.minute} (mode: $scheduleMode)',
        );
      }
      return;
    }

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
    // skipped-day companion (see scheduleReminder).
    await _plugin.cancel(id: _reminderBaseId + id + _skipCompanionOffset);
  }

  /// Shows an immediate one-off local notification (surpise!)
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
          // Safety net: Android is free to kill this process while the user reads in another app, and a posted notification outlives its process
          timeoutAfter: const Duration(hours: 4).inMilliseconds,
        ),
      ),
    );
    if (kDebugMode) {
      debugPrint('NotificationService: reading session notification shown');
    }
  }

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
      kStreakRiskHour,
    );
    if (!target.isAfter(now)) {
      return; // Too late today — the in-app banner already covers this.
    }
    // Midnight is the actual deadline the streak is measured against. Built
    // from the calendar (day + 1) rather than by adding 24 hours so it lands
    // on the next local midnight even across a daylight-saving change.
    final tz.TZDateTime deadline = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day + 1,
    );
    final AndroidScheduleMode mode = await _resolveScheduleMode();
    await _plugin.zonedSchedule(
      id: _streakRiskNotificationId,
      title: title,
      body: body,
      scheduledDate: target,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'JW Streak Reminders',
          channelDescription: 'Daily reminders for JW Streak reading flow.',
          importance: Importance.high,
          priority: Priority.high,
          // Turns the timestamp into a live "3:59:12" ticking *down* to
          // midnight, drawn by the system — "you have until midnight" as a
          // number that visibly shrinks rather than a sentence to work out.
          // Android only: iOS notifications have no equivalent, so there the
          // body text carries the whole message.
          usesChronometer: true,
          chronometerCountDown: true,
          when: deadline.millisecondsSinceEpoch,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
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
    try {
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
    } catch (_) {
      return false;
    }
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

  tz.TZDateTime _nextInstanceFor(TimeOfDay time, {bool skipToday = false}) {
    final tz.TZDateTime schedule = nextReminderInstance(
      now: tz.TZDateTime.now(tz.local),
      time: time,
      skipToday: skipToday,
    );
    if (kDebugMode) {
      debugPrint(
        'NotificationService: Next trigger at ${schedule.year}-${schedule.month}-${schedule.day} ${schedule.hour}:${schedule.minute}',
      );
    }
    return schedule;
  }
}
