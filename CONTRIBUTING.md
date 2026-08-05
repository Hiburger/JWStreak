# Contributing to JW Streak

Thanks for considering it! JWS is a small, mostly-solo FLOSS project, so this doc is short on purpose! Just enough to keep things consistent :D

## Getting set up

```bash
flutter pub get
flutter run
```

That's it for day-to-day work. A signed **release** build (Android or iOS) needs its own signing setup, kindly see the "Build de production" section of the [README](README.md) for Android, and Xcode's Signing & Capabilities for iOS (a free Apple ID works for local device testing; a paid Apple Developer account is only needed for TestFlight/App Store distribution).

## Before opening a PR

```bash
dart format .
dart analyze
flutter test
```

All three should be clean. `flutter_lints` (see `analysis_options.yaml`) is the baseline — please don't disable a rule project-wide to work around a one-off warning; suppress it inline with `// ignore: rule_name` instead, with a comment explaining why

If you touched anything under `lib/screens/`, `lib/widgets/`, or notification/deep-link code, please actually run the app (Android and, if you can, iOS) rather than relying on `flutter test` alone since a lot of what JWS does (reminders, deep links, the app lock, tablet layouts) only really shows itself on a real build

## Code style

- Comments should explain **why**, not what and the code itself should make the *what* obvious. If you find yourself writing "this creates a list of chapters," ask yourself some questions; if you're writing "this has to run *before* the DB read because X," keep it! 
- No comments (or at least avoid) referencing a specific bug, issue number, or PR as those (often) rot as the code moves on. Explain the constraint itself instead.
- Prefer small, focused commits over one giant one. The existing commit history is a decent style guide: a one-line summary, then (when it's not obvious) a short paragraph on *why*, not a bullet list of *what changed* (that's what `git diff` is for).

## Adding or fixing quiz content

Quiz questions live in `lib/quiz/`: `quiz_data.dart` is the French source of truth, and `quiz_data_<lang>.dart` (aggregating `quiz_data_<lang>_c1.dart` … `_c8.dart`) holds each language's translations, keyed by checkpoint id (`bookId#index`). Anything a translated file doesn't cover automatically falls back to the French original... so a partial translation is fine, it just won't be "complete" for that language yet.

If you spot a wrong answer, a typo, or an ambiguous question (I wrote these myself and I'm human), either open an issue or a PR, whichever's easier for you. When doing so, please make sure your edits are accurate and true, we want to avoid misinformation.

## Adding a new language

A language needs **both** of these before it counts as supported:
1. A `lib/l10n/app_<code>.arb` file (the UI strings).
2. A full set of `lib/quiz/quiz_data_<code>_c1.dart` … `_c8.dart` files (the quiz content) plus the `quiz_data_<code>.dart` aggregator.

Missing either one means the app will silently mix languages (UI in your new language, quizzes still in French, or vice versa) therefore please don't ship half of one.

## Reporting bugs / privacy

This app is offline-first and stores everything locally, if you're reporting a bug, you don't have to paste your personal notes or reading history into a public issue. A description of what you tapped and what happened is almost always enough; screenshots of the UI are fine, screenshots of your notes generally aren't necessary. But that's up to you.

For anything sensitive, email **contact@olynthe.org** instead of opening a public issue.

## License

JW Streak is GPLv3 (see `LICENSE`).  
By contributing, you agree your contribution is licensed under the same terms.  
Thank you A LOT for everything you're doing!!!

---

# Contribuer à JW Streak

Merci d'y penser ! JWS est un petit projet FLOSS, plutôt solo, donc ce document reste volontairement court, juste de quoi garder une cohérence :D

## Installation

```bash
flutter pub get
flutter run
```

C'est suffisant pour le développement au quotidien. Un build **release** signé (Android ou iOS) nécessite sa propre configuration de signature, voir la section « Build de production » du [README](README.md) pour Android, et l'onglet Signing & Capabilities d'Xcode pour iOS (un Apple ID gratuit suffit pour tester sur son propre appareil ; un compte développeur payant n'est nécessaire que pour TestFlight/l'App Store).

## Avant d'ouvrir une PR

```bash
dart format .
dart analyze
flutter test
```

Les trois doivent être propres. `flutter_lints` (voir `analysis_options.yaml`) est la base, merci de ne pas désactiver une règle pour tout le projet à cause d'un avertissement ponctuel ; utilisez plutôt `// ignore: nom_de_la_regle` en ligne avec un commentaire expliquant pourquoi

Si vous avez touché à `lib/screens/`, `lib/widgets/`, ou au code des rappels/deep links, merci de vraiment lancer l'appli (Android et, si possible, iOS) plutôt que de vous fier uniquement à `flutter test`, car une bonne partie de ce que fait JWS (rappels, deep links, verrouillage de l'app, mises en page tablette) ne se révèle vraiment que sur un vrai build

## Style de code

- Les commentaires doivent expliquer le **pourquoi**, pas le quoi — le code lui-même doit rendre le *quoi* évident. Si vous écrivez « ceci crée une liste de chapitres », supprimez-le ; si vous écrivez « ceci doit s'exécuter *avant* la lecture de la DB à cause de X », gardez-le.
- Pas de commentaires (ou au moins évitez) faisant référence à un bug, un numéro d'issue ou de PR précis car ça devient souvent obsolète avec le temps. Expliquez plutôt la contrainte elle-même.
- Préférez des commits petits et ciblés à un seul énorme commit. L'historique existant est un bon guide de style : un résumé en une ligne, puis (quand ce n'est pas évident) un court paragraphe sur le *pourquoi*, pas une liste à puces du *quoi* (c'est à ça que sert `git diff`)

## Ajouter ou corriger du contenu de quiz

Les questions de quiz vivent dans `lib/quiz/` : `quiz_data.dart` est la source de vérité en français, et `quiz_data_<langue>.dart` (qui agrège `quiz_data_<langue>_c1.dart` … `_c8.dart`) contient les traductions de chaque langue, indexées par identifiant de point d'étape (`idLivre#index`). Tout ce qu'un fichier traduit ne couvre pas retombe automatiquement sur l'original français; une traduction partielle n'est donc pas un problème, elle ne sera juste pas « complète » pour cette langue.

Si vous repérez une mauvaise réponse, une coquille, ou une question ambiguë (je les ai écrites moi-même et je suis humain), ouvrez une issue ou une PR, selon ce qui vous arrange. Veuillez s'il vous plaît faire attention à vos modifications! Assurez-vous qu'elles sont sûres et vraies; nous ne voulons aucune forme de désinformation dans JWS

## Ajouter une nouvelle langue

Une langue a besoin des **deux** éléments suivants avant d'être considérée comme prise en charge :
1. Un fichier `lib/l10n/app_<code>.arb` (les textes de l'interface).
2. Un jeu complet de fichiers `lib/quiz/quiz_data_<code>_c1.dart` … `_c8.dart` (le contenu des quiz) plus l'agrégateur `quiz_data_<code>.dart`.

L'absence de l'un des deux fait que l'app mélangera silencieusement les langues (interface dans la nouvelle langue, quiz toujours en français, ou l'inverse) donc merci de ne pas livrer la moitié d'une langue

## Signaler un bug / vie privée

Cette app est locale et hors-ligne par nature, tout est stocké sur l'appareil. Si vous signalez un bug, pas besoin de coller vos notes personnelles ou votre historique de lecture dans une issue publique. Une description de ce que vous avez fait et de ce qui s'est passé suffit presque toujours; des captures d'écran de l'interface sont bienvenues, celles de vos notes ne sont généralement pas nécessaires. Mais ça, c'est vous qui voyez.

Pour tout ce qui est sensible, écrivez à **contact@olynthe.org** plutôt que d'ouvrir une issue publique :)

## Licence

JW Streak est sous licence GPLv3 (voir `LICENSE`). En contribuant, vous acceptez que votre contribution soit sous la même licence. Merci beacoup pour tout ce que vous faite!!!
