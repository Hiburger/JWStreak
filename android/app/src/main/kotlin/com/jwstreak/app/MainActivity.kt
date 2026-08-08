package com.jwstreak.app

import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

// FlutterFragmentActivity rather than FlutterActivity: the local_auth plugin
// shows AndroidX's BiometricPrompt, which is a Fragment and so needs a
// FragmentActivity to host it. Drives the optional app lock in settings.
class MainActivity : FlutterFragmentActivity() {
    // Only the reading-session Live Update goes over this channel; everything
    // else the app notifies about is reachable through
    // flutter_local_notifications. See ReadingSessionLiveUpdate for why this
    // one can't be.
    private val liveUpdateChannel = "com.jwstreak.app/live_update"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            liveUpdateChannel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "showReadingSession" -> {
                    val posted = ReadingSessionLiveUpdate.show(
                        context = applicationContext,
                        channelId = call.argument<String>("channelId")!!,
                        notificationId = call.argument<Int>("notificationId")!!,
                        title = call.argument<String>("title") ?: "",
                        body = call.argument<String>("body") ?: "",
                        startedAtMillis = call.argument<Long>("startedAtMillis")
                            ?: System.currentTimeMillis()
                    )
                    // The Dart side falls back to the plugin's ordinary
                    // ongoing notification when this is false.
                    result.success(posted)
                }
                else -> result.notImplemented()
            }
        }
    }
}
