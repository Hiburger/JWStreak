import java.io.FileInputStream
import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// Upload-key signing config, loaded from android/key.properties (gitignored —
// see that file's comment, and android/app/keystore/upload-keystore.jks, for
// where the actual key lives). Falls back to debug signing when the
// properties file is absent, e.g. on a fresh checkout that hasn't generated
// its own key yet, so `flutter run` still works out of the box.
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
val hasReleaseSigning = keystorePropertiesFile.exists()
if (hasReleaseSigning) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.jwstreak.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    defaultConfig {
        applicationId = "com.jwstreak.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    signingConfigs {
        if (hasReleaseSigning) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (hasReleaseSigning) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

// AGP 9's public Variant API dropped VariantOutput.outputFileName, and even
// on older AGP versions it wouldn't have mattered: Flutter's own Gradle
// plugin (FlutterPlugin.kt) always copies the built APK into
// build/app/outputs/flutter-apk/ and force-renames that copy to the generic
// "app-<buildmode>.apk", via its own doLast on this same assemble task —
// registered earlier (the plugin applies before this block runs), so it
// always executes first. This doLast picks up right after it: copies that
// file under a name that actually identifies the build, and clears out this
// build type's previous custom-named copies first (matched by buildmode, so
// a release build never deletes a debug one or vice versa) instead of
// letting them pile up run after run. app-<buildmode>.apk itself is left in
// place alongside the copy — `flutter build` checks for that exact file
// right after Gradle exits and reports the build as failed if it's gone.
androidComponents {
    onVariants { variant ->
        val buildTypeName = variant.buildType ?: variant.name
        val assembleTaskName = "assemble${variant.name.replaceFirstChar(Char::uppercase)}"
        // onVariants fires during configuration, before AGP is guaranteed to
        // have registered its own assemble<Variant> task yet — tasks.named
        // would fail outright ("task not found") if it hasn't. afterEvaluate
        // waits until the whole project is configured, when it always has.
        project.afterEvaluate {
            tasks.named(assembleTaskName).configure {
                doLast {
                    val outputDir =
                        rootProject.projectDir.parentFile.resolve("build/app/outputs/flutter-apk")
                    val defaultApk = outputDir.resolve("app-$buildTypeName.apk")
                    if (!defaultApk.exists()) {
                        return@doLast
                    }
                    outputDir
                        .listFiles { f ->
                            f.extension == "apk" &&
                                f.name.startsWith("JWStreak-") &&
                                f.name.endsWith("-$buildTypeName.apk")
                        }
                        ?.forEach { it.delete() }
                    val renamed = outputDir.resolve(
                        "JWStreak-${flutter.versionName}+${flutter.versionCode}-$buildTypeName.apk"
                    )
                    // Leaves app-<buildmode>.apk in place rather than deleting
                    // it: the `flutter` command checks for that exact file
                    // right after Gradle exits and reports the build as
                    // failed if it's gone, even though this renamed copy
                    // built successfully right next to it.
                    defaultApk.copyTo(renamed, overwrite = true)
                }
            }
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.5")
    // NotificationCompat.setRequestPromotedOngoing — the Android 16 Live
    // Update opt-in used by ReadingSessionLiveUpdate.kt — only exists from
    // core 1.18 on, and the version the Flutter plugins pull in transitively
    // is older than that. Gradle resolves to the highest requested version,
    // so asking for it here is what puts the symbol on the classpath.
    implementation("androidx.core:core:1.18.0")
}
