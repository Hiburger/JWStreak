import ActivityKit
import SwiftUI
import WidgetKit

/// The reading-session Live Activity: what the user sees on the lock screen
/// and in the Dynamic Island while a chapter is open in JW Library or on
/// jw.org.
///
/// Every timer here is `Text(_:style: .timer)`, which SwiftUI ticks by
/// itself from the start date — the app never pushes an update, exactly like
/// the chronometer on the Android side.
@available(iOS 16.2, *)
struct ReadingSessionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ReadingSessionAttributes.self) { context in
            lockScreen(context: context)
                // Matches the app's own surface rather than leaving the
                // system default, so the activity doesn't read as a
                // different app's.
                .activityBackgroundTint(Color.black.opacity(0.55))
                .activitySystemActionForegroundColor(.white)
        } dynamicIsland: { context in
            DynamicIsland {
                DynamicIslandExpandedRegion(.leading) {
                    Image(systemName: "book.fill")
                        .foregroundStyle(.tint)
                        .padding(.leading, 4)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text(context.state.startedAt, style: .timer)
                        .monospacedDigit()
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: 64)
                        .padding(.trailing, 4)
                }
                DynamicIslandExpandedRegion(.bottom) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(context.attributes.title)
                            .font(.headline)
                        Text(context.attributes.body)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            } compactLeading: {
                Image(systemName: "book.fill")
                    .foregroundStyle(.tint)
            } compactTrailing: {
                Text(context.state.startedAt, style: .timer)
                    .monospacedDigit()
                    // Without a cap the ticking timer keeps resizing the
                    // compact island as digits are added.
                    .frame(maxWidth: 44)
            } minimal: {
                Image(systemName: "book.fill")
                    .foregroundStyle(.tint)
            }
        }
    }

    @ViewBuilder
    private func lockScreen(
        context: ActivityViewContext<ReadingSessionAttributes>
    ) -> some View {
        HStack(spacing: 14) {
            Image(systemName: "book.fill")
                .font(.title2)
                .foregroundStyle(.tint)
            VStack(alignment: .leading, spacing: 3) {
                Text(context.attributes.title)
                    .font(.headline)
                    .lineLimit(1)
                Text(context.attributes.body)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            Spacer(minLength: 8)
            Text(context.state.startedAt, style: .timer)
                .font(.title3)
                .monospacedDigit()
                .frame(maxWidth: 72, alignment: .trailing)
        }
        .padding(16)
    }
}
