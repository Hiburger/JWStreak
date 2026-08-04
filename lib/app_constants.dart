import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'bible_data.dart';

const String kDefaultBook = 'Genesis';
const int kDefaultChapter = 1;
const int kDefaultReminderHour = 8;
const int kDefaultReminderMinute = 0;

/// A streak freeze is awarded every time this many *distinct* quizzes have
/// been completed for the first time (replaying an already-completed quiz
/// never counts again).
const int kQuizzesPerFreeze = 3;

// jw.org's own language code (`wtlocale`) for each of the app's UI languages.
// These are jw.org's internal symbols, which don't always match the ISO code
// (e.g. Spanish is `S`, Italian `I`, Portuguese `T`, Russian `U`, Chinese
// Simplified `CHS`). French `F` is the fallback for any unmapped locale.
const Map<String, String> _kWtLocaleByLanguage = <String, String>{
  'fr': 'F',
  'en': 'E',
  'de': 'X',
  'pl': 'P',
  'es': 'S',
  'it': 'I',
  'pt': 'T',
  'ru': 'U',
  'zh': 'CHS',
};

/// jw.org's `wtlocale` code for [languageCode], used both for the web fallback
/// URL and for the JW Library deep link (so the app opens content in the same
/// language as JW Streak). Falls back to French for unknown codes.
String wtLocaleFor(String? languageCode) =>
    _kWtLocaleByLanguage[languageCode] ?? 'F';

// wol.jw.org's per-language URL segments. `path` is the language folder,
// `r`/`lp` are jw.org's internal library identifiers. These build both the
// daily-text page (`/wol/h/{r}/{lp}`) and Bible chapters
// (`/wol/b/{r}/{lp}/nwtsty/{book}/{chapter}`). We use these final wol.jw.org
// URLs (rather than the jw.org/finder aliases) and open them in a Chrome Custom
// Tab: jw.org registers wol.jw.org as an Android App Link for JW Library, so a
// plain external ACTION_VIEW intent would be handed to that app instead of a
// browser. A Custom Tab is still a real browser (jw.org's Terms of Use prohibit
// embedding their content in-app) but isn't subject to that hand-off. French is
// the fallback for any unmapped locale.
class _WolLanguage {
  const _WolLanguage(this.path, this.r, this.lp);
  final String path;
  final String r;
  final String lp;
}

const Map<String, _WolLanguage> _kWolByLanguage = <String, _WolLanguage>{
  'fr': _WolLanguage('fr', 'r30', 'lp-f'),
  'en': _WolLanguage('en', 'r1', 'lp-e'),
  'de': _WolLanguage('de', 'r10', 'lp-x'),
  'pl': _WolLanguage('pl', 'r12', 'lp-p'),
  'es': _WolLanguage('es', 'r4', 'lp-s'),
  'it': _WolLanguage('it', 'r6', 'lp-i'),
  'pt': _WolLanguage('pt', 'r5', 'lp-t'),
  'ru': _WolLanguage('ru', 'r2', 'lp-u'),
  'zh': _WolLanguage('cmn-Hans', 'r23', 'lp-chs'),
};

_WolLanguage _wolFor(String? languageCode) =>
    _kWolByLanguage[languageCode] ?? _kWolByLanguage['fr']!;

/// The jw.org homepage fallback URL for [languageCode], opened when the JW
/// Library deep link can't be handled. Falls back to French for unknown codes.
String webFallbackUrlFor(String? languageCode) {
  return 'https://www.jw.org/finder?wtlocale=${wtLocaleFor(languageCode)}&srcid=share';
}

/// The daily-text URL for [languageCode]. Falls back to French for unknown
/// codes.
String dailyTextUrlFor(String? languageCode) {
  final _WolLanguage wol = _wolFor(languageCode);
  return 'https://wol.jw.org/${wol.path}/wol/h/${wol.r}/${wol.lp}';
}

/// The wol.jw.org web URL for a specific Bible chapter, used when the user has
/// chosen to read on jw.org instead of the JW Library app. [bookNumber] is the
/// 1-based Bible book number. Falls back to French for unknown codes.
String jwOrgChapterUrlFor(int bookNumber, int chapter, String? languageCode) {
  final _WolLanguage wol = _wolFor(languageCode);
  return 'https://wol.jw.org/${wol.path}/wol/b/${wol.r}/${wol.lp}'
      '/nwtsty/$bookNumber/$chapter';
}

const String kGithubRepoUrl = 'https://github.com/Hiburger/JWStreak';
const String kSupportEmail = 'contact@olynthe.org';

/// Store listing for the JW Library app, offered when the user picks JW
/// Library as their Bible target but the app isn't installed. The two stores
/// don't share an id — JW Library is `org.jw.jwlibrary.mobile` on Google Play
/// and `id672417831` on the App Store — so the right one has to be picked at
/// runtime. The App Store link is deliberately storefront-less: Apple
/// redirects it to the viewer's own country.
String get jwLibraryStoreUrl => defaultTargetPlatform == TargetPlatform.iOS
    ? 'https://apps.apple.com/app/id672417831'
    : 'https://play.google.com/store/apps/details?id=org.jw.jwlibrary.mobile';

/// A `jwlibrary://` probe URI used to detect whether the JW Library app is
/// installed (via `canLaunchUrl`). The manifest's `<queries>` block whitelists
/// this scheme so the check works on Android 11+.
const String kJwLibraryProbeUri = 'jwlibrary:///finder?bible=01001000';

String displayReference(BuildContext context, String book, int chapter) {
  final BibleBook? bibleBook = bibleBookById(book);
  if (bibleBook != null) {
    return '${localizedBookName(context, bibleBook)} $chapter';
  }
  return '$book $chapter';
}
