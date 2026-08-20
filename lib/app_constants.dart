import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'bible_data.dart';

const String kDefaultBook = 'Genesis';
const int kDefaultChapter = 1;
const int kDefaultReminderHour = 8;
const int kDefaultReminderMinute = 0;
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
// (`/wol/b/{r}/{lp}/nwtsty/{book}/{chapter}`), used as the web fallback and
// opened in a Chrome Custom Tab — still a real browser (jw.org's Terms of
// Use prohibit embedding their content in-app), just nicer than a full
// external browser hop. wol.jw.org is *not* one of JW Library's registered
// App Link domains (checked against the app's own installed manifest —
// only `https://www.jw.org/finder` is, autoVerify=true), so this URL never
// gets handed off to the app regardless of launch mode; reaching the app on
// purpose goes through jwLibraryChapterDeepLink/jwLibraryDailyTextDeepLink's
// `jwlibrary://` scheme instead. French is the fallback for any unmapped
// locale.
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

/// The JW Library `jwlibrary://` deep link for [date]'s daily text. Mirrors
/// the link JW Library's own in-app Share button produces for the daily
/// text — `https://www.jw.org/finder?srcid=jwlshare&wtlocale=E&prefer=lang
/// &alias=daily-text&date=YYYYMMDD` — just over the custom scheme instead of
/// that https App Link, for the same reason [jwLibraryChapterDeepLink] does:
/// it only needs the app installed, not a verified App Link.
String jwLibraryDailyTextDeepLink(DateTime date, {String? languageCode}) {
  final String yyyymmdd =
      '${date.year.toString().padLeft(4, '0')}'
      '${date.month.toString().padLeft(2, '0')}'
      '${date.day.toString().padLeft(2, '0')}';
  return 'jwlibrary:///finder?srcid=jwlshare'
      '&wtlocale=${wtLocaleFor(languageCode)}'
      '&prefer=lang&alias=daily-text&date=$yyyymmdd';
}

const int kStreakRiskHour = 20;
const String kGithubRepoUrl = 'https://github.com/Hiburger/JWStreak';

/// Where someone can sponsor the project, if they want to! ;)
/// Must always be opened with `LaunchMode.externalApplication` (see
/// [openExternalUri]) rather than an in-app browser view. Apple's guideline
/// 3.2.2(iv) lets a free app raise money only "outside of the app, such as
/// via Safari"; collecting inside the app would need in-app purchase. The
/// same rule is why sponsoring must never unlock anything here: both stores
/// require in-app purchase for any gift "connected to or associated at any
/// point in time with receiving digital content".
const String kGithubSponsorsUrl = 'https://github.com/sponsors/Hiburger';
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
