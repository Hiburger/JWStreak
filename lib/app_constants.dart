import 'package:flutter/widgets.dart';

import 'bible_data.dart';

const String kDefaultBook = 'Genesis';
const int kDefaultChapter = 1;
const int kDefaultReminderHour = 8;
const int kDefaultReminderMinute = 0;

const String kWebFallbackUrl =
    'https://www.jw.org/finder?wtlocale=F&srcid=share';
const String kJwLibraryGenesis1DeepLink = 'jwlibrary:///finder?bible=01001001';
// Already-resolved wol.jw.org daily text page (French). We deliberately use
// this instead of the jw.org/finder?alias=daily-text link: that one issues a
// server-side redirect to this same wol.jw.org URL, and since JW Library
// registers wol.jw.org as an Android App Link, a plain external ACTION_VIEW
// intent gets handed to JW Library instead of a browser. Using the final URL
// directly, opened in a Chrome Custom Tab (see DeepLinkService.openDailyText),
// avoids that hand-off while still opening in a real browser (never embedded
// in-app — jw.org's Terms of Use prohibit framing their content).
const String kDailyTextUrl = 'https://wol.jw.org/fr/wol/h/r30/lp-f';
const String kGithubRepoUrl = 'https://github.com/Hiburger/JWStreak';
const String kSupportEmail = 'contact@olynthe.org';

String displayReference(BuildContext context, String book, int chapter) {
  final BibleBook? bibleBook = bibleBookById(book);
  if (bibleBook != null) {
    return '${localizedBookName(context, bibleBook)} $chapter';
  }
  return '$book $chapter';
}
