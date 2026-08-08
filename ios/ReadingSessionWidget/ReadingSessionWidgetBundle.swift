import SwiftUI
import WidgetKit

/// Entry point of the widget extension. The bundle holds only the reading
/// session Live Activity — JW Streak ships no home screen widgets, so there
/// is nothing else to register here.
@main
struct ReadingSessionWidgetBundle: WidgetBundle {
    var body: some Widget {
        // 16.2 rather than 16.1: `ActivityConfiguration` reached its current
        // shape there, and the extension deploys to 16.2 anyway, so this is
        // the floor for the whole bundle.
        if #available(iOS 16.2, *) {
            ReadingSessionLiveActivity()
        }
    }
}
