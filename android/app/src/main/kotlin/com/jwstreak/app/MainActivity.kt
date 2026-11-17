package com.jwstreak.app

import android.content.ComponentName
import android.content.pm.PackageManager
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
    private val iconChannel = "com.jwstreak.app/app_icon"

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
                "endReadingSession" -> {
                    // Nothing to undo here that the Dart side doesn't already
                    // cancel through flutter_local_notifications under the
                    // same id — this exists so one Dart call path serves both
                    // platforms, where iOS genuinely does need it.
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }

        enableIconChannel(flutterEngine)
    }

    // Alternate launcher icons live as activity-alias components (see
    // AndroidManifest.xml); switching means enabling the chosen alias and
    // disabling the others. The alias list comes from Dart, which owns the
    // icon catalog.
    private fun enableIconChannel(flutterEngine: FlutterEngine) {
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            iconChannel
        ).setMethodCallHandler { call, result ->
            val arguments = call.arguments as? Map<*, *> ?: emptyMap<Any?, Any?>()
            val aliases = (arguments["aliases"] as? List<*>)?.mapNotNull { it as? String }
                ?: emptyList()
            val components = aliases.map { ComponentName(packageName, "$packageName.$it") }
            when (call.method) {
                "getCurrent" -> {
                    val pm = packageManager
                    val current = components.firstOrNull {
                        pm.getComponentEnabledSetting(it) ==
                            PackageManager.COMPONENT_ENABLED_STATE_ENABLED
                    }?.shortClassName?.removePrefix(".")
                    result.success(current)
                }
                "set" -> {
                    val alias = arguments["alias"] as? String
                    if (alias == null || components.isEmpty()) {
                        result.error("bad_args", "missing alias or aliases", null)
                        return@setMethodCallHandler
                    }
                    val target = ComponentName(packageName, "$packageName.$alias")
                    // Enable before disable: for a moment both are on, which
                    // the drawer absorbs silently, while the reverse order
                    // could leave no launcher entry at all if the process is
                    // killed in between.
                    packageManager.setComponentEnabledSetting(
                        target,
                        PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                        PackageManager.DONT_KILL_APP,
                    )
                    for (other in components) {
                        if (other != target) {
                            packageManager.setComponentEnabledSetting(
                                other,
                                PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                                PackageManager.DONT_KILL_APP,
                            )
                        }
                    }
                    result.success(alias)
                }
                else -> result.notImplemented()
            }
        }
    }
}
