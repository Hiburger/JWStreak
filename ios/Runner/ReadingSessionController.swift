import ActivityKit
import Foundation
import os

/// Starts and ends the reading-session Live Activity — the iOS counterpart
/// of Android's promoted ongoing notification.
///
/// This lives in the app target; the widget extension only draws what these
/// calls put on screen (see ReadingSessionAttributes / the extension's
/// ReadingSessionLiveActivity).
enum ReadingSessionController {
    /// Held so [end] can finish the one activity this app ever starts. There
    /// is at most one reading session at a time by construction: opening a
    /// second chapter replaces the first.
    private static var activityID: String?

    private static let log = Logger(
        subsystem: "com.jwstreak.app", category: "ReadingSession"
    )

    static func start(title: String, body: String, startedAt: Date) -> Bool {
        guard #available(iOS 16.2, *) else {
            log.info("Live Activity unavailable: needs iOS 16.2")
            return false
        }
        // The user can turn Live Activities off per app in Settings, and the
        // system refuses them outright in some states — either way the Dart
        // side just gets `false` and stops asking.
        guard ActivityAuthorizationInfo().areActivitiesEnabled else {
            log.info("Live Activity refused: activities disabled for this app")
            return false
        }
        // Starting a second one without ending the first would stack two
        // activities for the same session.
        end()
        do {
            let activity = try Activity.request(
                attributes: ReadingSessionAttributes(title: title, body: body),
                content: ActivityContent(
                    state: ReadingSessionAttributes.ContentState(
                        startedAt: startedAt
                    ),
                    // The timer counts up with no natural end, so nothing here
                    // ever goes stale — the app ends the activity explicitly.
                    staleDate: nil
                ),
                pushType: nil
            )
            activityID = activity.id
            log.info("Live Activity started: \(activity.id, privacy: .public)")
            return true
        } catch {
            log.error(
                "Live Activity request failed: \(error.localizedDescription, privacy: .public)"
            )
            return false
        }
    }

    static func end() {
        guard #available(iOS 16.2, *) else {
            return
        }
        // Ends every activity of this type rather than only the tracked id:
        // one can outlive the process that started it (the app being killed
        // mid-session), in which case `activityID` is nil but the activity
        // is still on the user's lock screen.
        Task {
            for activity in Activity<ReadingSessionAttributes>.activities {
                await activity.end(nil, dismissalPolicy: .immediate)
            }
        }
        activityID = nil
    }
}
