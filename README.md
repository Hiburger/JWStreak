
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

## Project Layout

```
lib/
  main.dart              app entry point
  app_constants.dart     jw.org / wol.jw.org locale codes, defaults
  bible_data.dart        the 66 books and their chapter counts
  achievements_data.dart achievement definitions
  quiz/                  quiz content: quiz_data.dart (French source) plus
                         quiz_data_<lang>.dart aggregators and their
                         quiz_data_<lang>_c1..c8.dart chapter files
  l10n/                  .arb translations + generated AppLocalizations
  screens/  services/  widgets/  theme/
assets/                  only what ships in the app (icons, bundled font)
tool/icons/              icon pipeline, not shipped: process_icon.py turns the
                         source art into assets/icon.png, then
                         generate_launcher_icons.py writes the Android mipmaps
test/                    widget and content tests
docs/                    the privacy policy served by GitHub Pages
```

A language is only fully supported once it has both an `.arb` file and a
complete set of `quiz/` chapter files; any checkpoint a language does not
override falls back to the French source automatically.

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





# 🥖 Readme.md but in french 


# JW Streak

Salut ! 
JW Streak (JWS) est une application Flutter conviviale (Android, Material 3 Expressive) qui aide à maintenir une habitude de lecture quotidienne de la Bible, avec des quiz, un système de série, des succès et des notes personnelles. Tout cela **100% local, aucun compte ou serveur requis**. Bien que j'ai créé JWS pour les Témoins de Jéhovah, tout le monde peut l'utiliser et en profiter.

## Est-ce sûr pour ma foi ?

Absolument ! L'application fonctionne **en parfaite harmonie avec le contenu et le matériel de l'organisation**, donc le contenu ne peut être altéré ou modifié par personne d'autre que notre bien-aimée organisation, JW.org. Lors de l'ouverture de la Bible ou du texte du jour, l'application l'affiche directement dans JW Library ou sur jw.org/_____, selon les préférences de l'utilisateur et si JW Library est installé. La seule chose qui devrait être vérifiée concerne les quiz. Je les ai créés moi-même, et parce que je suis humain, j'ai pu faire quelques erreurs en les créant. Quoi qu'il en soit, si je reçois des retours ou un signalement, je serai plus qu'heureux de corriger mes erreurs :)

## Fonctionnalités

- **Lecture guidée** : Un chapitre à la fois, ouvert dans JW Library ou sur jw.org (choix dans les paramètres), avec suivi de la progression à travers toute la Bible.
- **Quiz interactifs** : Choix multiples, réponse saisie ou reconstruction de mots avec validation tolérante aux fautes de frappe (uniquement fr/en/es/it/pt/de ; ru/zh restent en choix multiples désolé).
- **Série & Matchs** : La série augmente chaque jour actif ; les « matchs » (gagnés en complétant les quiz) couvrent automatiquement les jours manqués.
- **Succès** : Jalons débloqués grâce à la lecture, aux quiz et aux séries.
- **Notes personnelles** : Liées à un passage, consultables et exportables depuis une bibliothèque dédiée.
- **Rappels quotidiens configurables** : Notifications simples.
- **Onboarding** : 4 étapes + un **guide de découverte** rejouable depuis les paramètres.
- **7 langues** : Français (langue de référence), Anglais, Allemand, Espagnol, Italien, Portugais, Russe, Chinois simplifié. D'autres à venir.
- **Thème** : Suit le système / clair / sombre / sombre OLED, avec couleur dynamique optionnelle (Material 3 E.). D'autres thèmes en route.

## Confidentialité

- Avant tout, vous pouvez trouver la politique de confidentialité de JWS à jws.olynthe.org
- Aucune donnée ne quitte l'appareil : aucun compte, aucun backend, aucun suivi ou analytique.
- Toutes les données (lectures, notes, paramètres, séries) sont stockées localement dans une mignonne base de données SQLite.
- Aucune police ou ressource n'est chargée depuis un serveur à l'exécution ; tout est intégré dans l'APK.

## Stack technique

- Flutter / Dart
- `sqflite` : lectures, notes, paramètres, succès, série
- `flutter_local_notifications` + `permission_handler` : rappels quotidiens et permissions
- `url_launcher` : lien profond JW Library, repli web jw.org
- `dynamic_color` : palette Material You optionnelle
- `flutter_markdown`, `pdf`, `share_plus` : partage de notes

## Organisation du projet

```
lib/
  main.dart              point d'entrée de l'app
  app_constants.dart     codes de langue jw.org / wol.jw.org, valeurs par défaut
  bible_data.dart        les 66 livres et leur nombre de chapitres
  achievements_data.dart définition des succès
  quiz/                  contenu des quiz : quiz_data.dart (source française),
                         les agrégateurs quiz_data_<langue>.dart et leurs
                         fichiers de chapitres quiz_data_<langue>_c1..c8.dart
  l10n/                  traductions .arb + AppLocalizations généré
  screens/  services/  widgets/  theme/
assets/                  uniquement ce qui est embarqué (icônes, police)
tool/icons/              chaîne de génération des icônes, non embarquée :
                         process_icon.py produit assets/icon.png à partir de
                         l'art source, puis generate_launcher_icons.py écrit
                         les mipmaps Android
test/                    tests de widgets et de contenu
docs/                    la politique de confidentialité servie par GitHub Pages
```

Une langue n'est pleinement prise en charge qu'une fois qu'elle possède à la
fois un fichier `.arb` et un jeu complet de fichiers de chapitres dans `quiz/` ;
tout point d'étape qu'une langue ne redéfinit pas retombe automatiquement sur
la source française.

## Exécution locale

> Prérequis : Flutter SDK installé + Android SDK configuré.

```bash
flutter pub get
flutter run


## Build de production

Un build `release` nécessite une clé de signature. Générez la vôtre une fois (elle n'est JAMAIS commitée, voir `.gitignore`) :

```bash
keytool -genkeypair -v -keystore android/app/keystore/upload-keystore.jks \
  -storetype PKCS12 -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

Ensuite, créez `android/key.properties` :

```properties
storePassword=<mot de passe du keystore>
keyPassword=<mot de passe de la clé>
keyAlias=upload
storeFile=keystore/upload-keystore.jks
```

**Sauvegardez le fichier `.jks` et les mots de passe en dehors du dépôt** (c.-à-d. dans un bon gestionnaire de mots de passe) : les perdre empêche de publier une mise à jour signée de la même manière. Quelque chose de mauvais pourrait arriver si vous ne sauvegardez pas cela quelque part.

```bash
flutter build appbundle --release   # pour Google Play
flutter build apk --release         # pour distribution directe / F-Droid
```

## Permissions Android

- `POST_NOTIFICATIONS` — rappels de lecture (Android 13+).
- `SCHEDULE_EXACT_ALARM` — rappels à l'heure exacte.
- `RECEIVE_BOOT_COMPLETED` — reprogramme les rappels après redémarrage.
- Requêtes Intent `VIEW` pour `jwlibrary://` et `https://` (ouverture de JW Library ou repli web).

## Licence

JW Streak est un logiciel libre sous licence **GNU GPLv3** (voir `LICENSE`).

La police [Plus Jakarta Sans](https://github.com/tokotype/PlusJakartaSans) est intégrée sous la licence SIL Open Font License (voir `assets/fonts/PlusJakartaSans-OFL.txt`).

## Contact

Hiiiii si vous avez quelque chose à dire, veuillez le faire à contact@olynthe.org
