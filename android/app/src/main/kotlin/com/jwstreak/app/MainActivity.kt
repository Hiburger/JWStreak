package com.jwstreak.app

import io.flutter.embedding.android.FlutterFragmentActivity

// FlutterFragmentActivity rather than FlutterActivity: the local_auth plugin
// shows AndroidX's BiometricPrompt, which is a Fragment and so needs a
// FragmentActivity to host it. Drives the optional app lock in settings.
class MainActivity : FlutterFragmentActivity()
