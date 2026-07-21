import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
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

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  NotificationTapHandler? _onTap;
  NotificationErrorHandler? _onError;
  bool _isInitialized = false;

  AndroidFlutterLocalNotificationsPlugin? get _androidPlugin => _plugin
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

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
    final String timezoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timezoneName));

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    await _plugin.initialize(
      const InitializationSettings(android: androidSettings),
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        await _safelyHandlePayload(response.payload);
      },
    );

    await _createNotificationChannel();
    await requestNotificationPermission();

    debugPrint('NotificationService: Initialized successfully');
    _isInitialized = true;
  }

  Future<void> _createNotificationChannel() async {
    debugPrint('NotificationService: Creating notification channel');
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
    debugPrint('NotificationService: Notification channel created');
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
  }) async {
    final tz.TZDateTime firstTrigger = _nextInstanceFor(time);
    final AndroidScheduleMode scheduleMode = await _resolveScheduleMode();

    await _plugin.zonedSchedule(
      _reminderBaseId + id,
      'JW Streak · Lecture biblique',
      'C’est l’heure de ta lecture. Touche pour continuer 📖',
      firstTrigger,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'JW Streak Reminders',
          channelDescription: 'Daily reminders for JW Streak reading flow.',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: scheduleMode,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    debugPrint(
      'NotificationService: Reminder $id scheduled for '
      '${firstTrigger.hour}:${firstTrigger.minute} (mode: $scheduleMode)',
    );
  }

  Future<void> cancelReminder(int id) async {
    await _plugin.cancel(_reminderBaseId + id);
  }

  /// Shows an immediate one-off local notification (used for small in-app
  /// surprises like the settings heart easter egg).
  Future<void> showInstantMessage({
    required String title,
    required String body,
  }) async {
    await _plugin.show(
      999,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'JW Streak Reminders',
          channelDescription: 'Daily reminders for JW Streak reading flow.',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  }

  static const int _streakRiskNotificationId = 500;

  /// Schedules a one-off evening warning if the streak is still inactive
  /// today. Call [cancelStreakRiskCheck] as soon as the user is active again.
  Future<void> scheduleStreakRiskCheck() async {
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
      _streakRiskNotificationId,
      'Ta série est en danger 🔥',
      'Tu n’as pas encore été actif aujourd’hui — lis un chapitre ou fais '
          'un quiz pour la garder.',
      target,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          _channelId,
          'JW Streak Reminders',
          channelDescription: 'Daily reminders for JW Streak reading flow.',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: mode,
    );
  }

  Future<void> cancelStreakRiskCheck() async {
    await _plugin.cancel(_streakRiskNotificationId);
  }

  /// Cancels every scheduled reminder (used before a full resync).
  Future<void> cancelAllReminders() async {
    await _plugin.cancelAll();
  }

  Future<AndroidScheduleMode> _resolveScheduleMode() async {
    // Prefer exact alarms; fall back to inexact if the permission is missing.
    try {
      final bool? canExact =
          await _androidPlugin?.canScheduleExactNotifications();
      if (canExact == true) {
        return AndroidScheduleMode.exactAllowWhileIdle;
      }
    } catch (_) {
      // Fall back below.
    }
    return AndroidScheduleMode.inexactAllowWhileIdle;
  }

  Future<bool> requestNotificationPermission() async {
    final bool? granted = await _androidPlugin
        ?.requestNotificationsPermission();
    return granted ?? true;
  }

  Future<bool> areNotificationsEnabled() async {
    final bool? enabled = await _androidPlugin?.areNotificationsEnabled();
    return enabled ?? true;
  }

  /// Whether the OS currently allows this app to schedule exact alarms.
  /// On Android 12+ this can be revoked by the user; older versions always
  /// return `true`.
  Future<bool> canScheduleExactAlarms() async {
    try {
      final bool? canExact =
          await _androidPlugin?.canScheduleExactNotifications();
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
      final bool? canExact =
          await _androidPlugin?.canScheduleExactNotifications();
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
    debugPrint('NotificationService: Next trigger at ${schedule.year}-${schedule.month}-${schedule.day} ${schedule.hour}:${schedule.minute}');
    return schedule;
  }
}
