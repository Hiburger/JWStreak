
# JW Streak 🫶

Hi! 
JW Streak (JWS) is a friendly Flutter application (Android, Material 3 Expressive) that helps maintain a daily Bible reading habit, with quizzes, a streak system, achievements, and personal notes. All of this **100% local, no account or server required**. While I made JWS for Jehovah’s Witnesses, anyone can use and enjoy it.

## Is it safe for my faith?

Absolutely! The app works **hand in hand with the organisation's content and material**, so the content cannot be altered or changed by anyone other than our beloved organisation, JW.org. When opening the Bible or the daily text, the app shows it directly in JW Library or jw.org/_____, based on the user's preferences and if JW Library is installed. The only thing that should be verified is the quizzes. I made them myself, and because I'm human, I may have made some mistakes creating them. Regardless, if I receive feedback or a report, I'd be more than happy to fix my mistakes :)

## Features

- **Guided Reading**: One chapter at a time, opened in JW Library or on jw.org (choice in settings), with progress tracking across the entire Bible.
- **Interactive Quizzes**: Multiple choice, typed answer, or word reconstruction with typo-tolerant validation (only fr/en/es/it/pt/de; ru/zh remain multiple choice soory).
- **Streak & Matches**: The streak grows each active day; "matches" (earned by completing quizzes) automatically cover missed days
- **Achievements**: Milestones unlocked through reading, quizzes, and streaks
- **Personal Notes**: Linked to a passage, viewable and exportable from a dedicated library
- **Configurable Daily Reminders**: Simple notifications
- **Onboarding**: 4 steps + a **guided tour** replayable from settings
- **7 Languages**: French (reference language), English, German, Spanish, Italian, Portuguese, Russian, Simplified Chinese. More to come
- **Theme**: Follow system / light / dark / dark OLED, with optional dynamic color (Material 3 E.). More themes on the way

## Privacy

- First things first, you can find JWS's privacy policy at jws.olynthe.org
- No data leaves the device: no account, no backend, no tracking or analytics.
- All data (readings, notes, settings, streaks) is stored locally in a cute SQLite db.
- No fonts or resources are loaded from a server at runtime ; everything is embedded in the APK.

## Technical Stack

- Flutter / Dart
- `sqflite` : readings, notes, settings, achievements, streak
- `flutter_local_notifications` + `permission_handler` : daily reminders and permissions
- `url_launcher` : JW Library deep link, web fallback jw.org
- `dynamic_color` : optional Material You palette
- `flutter_markdown`, `pdf`, `share_plus` : note sharing 

## Local Execution

> Prerequisites: Flutter SDK installed + Android SDK configured.

```bash
flutter pub get
flutter run
```

## Production Build

A `release` build requires a signing key. Generate yours once (it is NEVER committed, see `.gitignore`):

```bash
keytool -genkeypair -v -keystore android/app/keystore/upload-keystore.jks \
  -storetype PKCS12 -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Then create `android/key.properties`:

```properties
storePassword=<keystore password>
keyPassword=<key password>
keyAlias=upload
storeFile=keystore/upload-keystore.jks
```

**Save the `.jks` file and passwords outside the repository** (i.e. good password manager): losing them prevents publishing a signed update the same way. Something bad coulp happen if you don't backup that somewhere. 

```bash
flutter build appbundle --release   # for Google Play
flutter build apk --release         # for direct distribution / F-Droid
```

## Android Permissions

- `POST_NOTIFICATIONS` — reading reminders (Android 13+).
- `SCHEDULE_EXACT_ALARM` — reminders at exact time.
- `RECEIVE_BOOT_COMPLETED` — reschedules reminders after reboot.
- Intent queries `VIEW` for `jwlibrary://` and `https://` (opening JW Library or web fallback).

## License

JW Streak is free software under the **GNU GPLv3** license (see `LICENSE`).

The [Plus Jakarta Sans](https://github.com/tokotype/PlusJakartaSans) font is embedded under the SIL Open Font License (see `assets/fonts/PlusJakartaSans-OFL.txt`).

## Contact

Hiiiii if you have something to say please do at contact@olynthe.org
