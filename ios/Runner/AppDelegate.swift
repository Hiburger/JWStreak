import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  /// Same channel name as the Android side registers in MainActivity.kt —
  /// one Dart call site drives whichever native implementation exists.
  private static let liveUpdateChannel = "com.jwstreak.app/live_update"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  func didInitializeImplicitFlutterEngine(_ engineBridge: FlutterImplicitEngineBridge) {
    GeneratedPluginRegistrant.register(with: engineBridge.pluginRegistry)
    // applicationRegistrar rather than a per-plugin registrar: this is an
    // app-level channel, not a plugin, which is exactly what the engine
    // bridge documents this registrar for.
    registerLiveUpdateChannel(with: engineBridge.applicationRegistrar.messenger())
  }

  private func registerLiveUpdateChannel(with messenger: FlutterBinaryMessenger) {
    let channel = FlutterMethodChannel(
      name: AppDelegate.liveUpdateChannel,
      binaryMessenger: messenger
    )
    channel.setMethodCallHandler { call, result in
      switch call.method {
      case "showReadingSession":
        let arguments = call.arguments as? [String: Any] ?? [:]
        let title = arguments["title"] as? String ?? ""
        let body = arguments["body"] as? String ?? ""
        // Sent as milliseconds to keep one shape for both platforms;
        // Android's Notification.when wants exactly that.
        let startedAtMillis = arguments["startedAtMillis"] as? Double
        let startedAt = startedAtMillis.map {
          Date(timeIntervalSince1970: $0 / 1000)
        } ?? Date()
        // false tells Dart the Live Activity didn't happen. Unlike Android
        // there is nothing to fall back to — a plain local notification
        // behaves nothing like this — so Dart simply does without.
        result(
          ReadingSessionController.start(
            title: title, body: body, startedAt: startedAt
          )
        )
      case "endReadingSession":
        ReadingSessionController.end()
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
  }
}
