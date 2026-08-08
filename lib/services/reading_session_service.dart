import 'package:flutter/widgets.dart';

import 'notification_service.dart';

/// The chapter a reading session was started for, handed back to the caller
/// when the user returns so it can offer to mark that chapter as read.
class ReadingSession {
  const ReadingSession({required this.book, required this.chapter});

  final String book;
  final int chapter;
}

/// Tracks the window between "the user tapped Open" and "the user came back",
/// showing an ongoing notification with a running timer for the duration.
///
/// The reading itself happens in JW Library or a browser, so there is no
/// callback telling us when it ends — the only signal available is our own
/// app being resumed, which is why this listens to the app lifecycle rather
/// than awaiting anything from the launch.
class ReadingSessionService with WidgetsBindingObserver {
  ReadingSessionService._internal();

  static final ReadingSessionService _instance =
      ReadingSessionService._internal();
  factory ReadingSessionService() => _instance;

  final NotificationService _notifications = NotificationService();

  /// How long the user has to have actually been away before a return counts
  /// as "back from reading" and prompts to mark the chapter read. Below
  /// this, the pause/resume was too quick to have been real reading — a
  /// stray tap, the launcher animation bouncing straight back, or someone
  /// just checking what "Open" does — so the session quietly ends instead of
  /// asking "finished already?" over something that lasted five seconds.
  static const Duration _minimumAwayDuration = Duration(seconds: 10);

  ReadingSession? _active;
  void Function(ReadingSession session)? _onReturn;
  bool _leftApp = false;
  DateTime? _leftAppAt;

  /// Whether a chapter is currently open elsewhere.
  bool get isActive => _active != null;

  /// Posts the ongoing notification and starts watching for the user's
  /// return. [onReturn] fires once, on the first resume after the app
  /// actually went to the background.
  ///
  /// Call this *before* launching the deep link: once the other app is in
  /// front, this one may not get scheduled again for a while.
  Future<void> start({
    required String book,
    required int chapter,
    required String title,
    required String body,
    required void Function(ReadingSession session) onReturn,
  }) async {
    // A second Open without coming back in between (tapping through several
    // chapters) replaces the session rather than stacking a new observer.
    if (_active == null) {
      WidgetsBinding.instance.addObserver(this);
    }
    _active = ReadingSession(book: book, chapter: chapter);
    _onReturn = onReturn;
    _leftApp = false;
    _leftAppAt = null;
    await _notifications.startReadingSession(title: title, body: body);
  }

  /// Clears the notification and stops watching, without notifying the
  /// caller. Used when the session ends some other way than coming back.
  Future<void> cancel() async {
    if (_active == null) {
      return;
    }
    WidgetsBinding.instance.removeObserver(this);
    _active = null;
    _onReturn = null;
    _leftApp = false;
    _leftAppAt = null;
    await _notifications.endReadingSession();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final ReadingSession? session = _active;
    if (session == null) {
      return;
    }

    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.hidden) {
      // The launch itself is what puts us here. Until it happens, a resume
      // is just this app regaining focus (a permission dialog closing, say)
      // and must not be read as the user having finished reading.
      _leftApp = true;
      // paused then hidden (or vice versa) can both fire for the same trip
      // out — keep the first timestamp so a second event doesn't shrink how
      // long they were actually away.
      _leftAppAt ??= DateTime.now();
      return;
    }

    if (state != AppLifecycleState.resumed || !_leftApp) {
      return;
    }

    final DateTime? leftAppAt = _leftAppAt;
    final bool wasAwayLongEnough =
        leftAppAt != null &&
        DateTime.now().difference(leftAppAt) >= _minimumAwayDuration;

    final void Function(ReadingSession session)? onReturn = _onReturn;
    WidgetsBinding.instance.removeObserver(this);
    _active = null;
    _onReturn = null;
    _leftApp = false;
    _leftAppAt = null;
    // Fire-and-forget: the notification is gone either way, and the caller's
    // prompt shouldn't wait on the platform channel.
    _notifications.endReadingSession();
    // A round trip shorter than this can't have been real reading — a stray
    // tap, or the OS bouncing straight back — so it ends quietly instead of
    // asking "finished already?" about something that lasted a few seconds.
    if (wasAwayLongEnough) {
      onReturn?.call(session);
    }
  }
}
