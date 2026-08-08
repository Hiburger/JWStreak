import ActivityKit
import Foundation

/// The shape of the reading-session Live Activity, shared by the two sides
/// that have to agree on it: the app target starts and ends the activity,
/// the widget extension draws it. Both compile this same file.
///
/// Marked available from 16.1 because ActivityKit is — the app target itself
/// still deploys to iOS 15, so every use of this has to be behind a check.
@available(iOS 16.1, *)
struct ReadingSessionAttributes: ActivityAttributes {
    /// The parts that could change while the activity is live. Nothing here
    /// actually changes for us: the timer counts up from [startedAt] and
    /// SwiftUI ticks it on its own, so the app never has to push an update.
    struct ContentState: Codable, Hashable {
        var startedAt: Date
    }

    /// Chapter being read, already localized and formatted by the Dart side
    /// ("Reading Genesis 11") — the extension has no access to the app's
    /// translations, so it only ever renders strings handed to it.
    var title: String
    /// The "tap to come back" line.
    var body: String
}
