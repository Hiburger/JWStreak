# JW Streak (prototype)

JW Streak est un prototype Flutter (Android-first, Material 3 + couleur dynamique système) pour valider un flux simple de lecture quotidienne orienté **Genèse 1**:

1. choisir un rappel quotidien,
2. recevoir une notification locale,
3. cliquer la notification pour tenter l’ouverture de JW Library (deep link),
4. fallback web jw.org si JW Library n’est pas disponible,
5. revenir dans l’app pour marquer le chapitre comme lu et ajouter une note locale.

## Vision produit

- Prototype MVP: architecture propre mais légère (pas de sur-engineering).
- Confidentialité par défaut: pas de tracking, pas d’analytics, pas de backend.
- Données 100% locales sur l’appareil (SQLite).

## Stack

- Flutter / Dart
- `sqflite` (état lecture, notes, réglages)
- `flutter_local_notifications` (rappels)
- `url_launcher` (deep links + fallback web)

## Exécution locale

> Prérequis: SDK Flutter installé + Android SDK configuré.

```bash
flutter pub get
flutter run
```

## Permissions Android / notifications

Le prototype déclare:

- `POST_NOTIFICATIONS` (Android 13+)
- Queries d’intents `VIEW` pour `jwlibrary://` et `https://` afin d’ouvrir app/web externe.

Le rappel quotidien est planifié en notification locale avec payload JSON (`book`, `chapter`).

## Flux implémenté

- Setup rappel: heure configurable + passage prérempli Genèse 1.
- Notification quotidienne:
  - titre/texte rappel lecture.
  - payload `{"book":"Genesis","chapter":1}`.
- Tap notification:
  - tentative deep link `jwlibrary:///finder?bible=01001001`.
  - fallback web `https://www.jw.org/finder?wtlocale=F&srcid=share`.
- Home:
  - rappel configuré,
  - progression lecture + streak simple + mini-calendrier (14 jours),
  - action “Marquer Genèse 1 comme lu”.
- Notes:
  - édition locale liée à `(book, chapter)`,
  - bibliothèque de notes (lecture, recherche, organisation par date de mise à jour).
- Paramètres:
  - thème `système / clair / sombre / sombre OLED`,
  - vérification permissions notifications,
  - version app + lien GitHub + contact support.

## Stockage local (SQLite)

Tables utilisées:

- `readings(book, chapter, readAt)` pour l’historique de lecture,
- `notes(book, chapter, content, updatedAt)` pour les notes,
- `settings(key, value)` pour les réglages de rappel.

Streak: nombre de jours consécutifs avec au moins un chapitre marqué.

## Limites connues (deep links JW Library)

- Les deep links JW Library peuvent varier selon versions/appareil.
- Le comportement peut dépendre de l’installation JW Library et du système Android.
- Le fallback web jw.org est conservé pour garantir une ouverture utilisable.

## Pourquoi pas de scraping jw.org

Le prototype **ne scrape pas** jw.org volontairement:

- robustesse technique (le scraping casse facilement),
- simplicité MVP,
- prudence juridique et maintenance.

Le “texte du jour” est traité via entrée/consultation manuelle + bouton d’ouverture web.

## Licence

Ce prototype est prévu sous **GNU GPLv3**.
