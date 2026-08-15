import 'package:url_launcher/url_launcher.dart';

import '../app_constants.dart';
import '../bible_data.dart';
import 'local_db_service.dart';

class DeepLinkService {
  /// Whether the JW Library app is installed and can handle its deep links.
  /// Relies on the `<queries>` entry for the `jwlibrary` scheme in the
  /// Android manifest so the check works on Android 11+.
  Future<bool> isJwLibraryInstalled() async {
    return canLaunchUrl(Uri.parse(kJwLibraryProbeUri));
  }

  Future<void> openReference({
    required String book,
    required int chapter,
    String? languageCode,
  }) async {
    // User preference: read the chapter on jw.org (web) rather than in the app.
    final bool openOnWeb = await LocalDbService().getOpenBibleOnWeb();
    if (openOnWeb) {
      await _openChapterOnWeb(
        book: book,
        chapter: chapter,
        languageCode: languageCode,
      );
      return;
    }

    final Uri deepLink = _toJwLibraryDeepLink(
      book: book,
      chapter: chapter,
      languageCode: languageCode,
    );
    final bool openedInApp = await launchUrl(
      deepLink,
      mode: LaunchMode.externalApplication,
    );
    if (openedInApp) {
      return;
    }

    // JW Library isn't installed (or refused the link) — land on the actual
    // chapter on wol.jw.org rather than jw.org's generic homepage/finder, so
    // the fallback still takes the user to what they asked to read.
    await _openChapterOnWeb(
      book: book,
      chapter: chapter,
      languageCode: languageCode,
    );
  }

  /// Opens a Bible chapter on jw.org in a Chrome Custom Tab, falling back to
  /// an external browser launch if no Custom Tabs provider is available.
  Future<void> _openChapterOnWeb({
    required String book,
    required int chapter,
    String? languageCode,
  }) async {
    final BibleBook resolved = bibleBookById(book) ?? kBibleBooks.first;
    final Uri uri = Uri.parse(
      jwOrgChapterUrlFor(resolved.number, chapter, languageCode),
    );
    try {
      final bool opened = await launchUrl(
        uri,
        mode: LaunchMode.inAppBrowserView,
      );
      if (opened) {
        return;
      }
    } on Exception {
      // No Custom Tabs provider available — fall back below.
    }
    final bool opened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!opened) {
      throw StateError('Unable to open the Bible chapter on the web.');
    }
  }

  /// Opens the official daily text — in the JW Library app when the reader
  /// prefers it (see [openReference]'s same toggle), falling back to a real
  /// browser tab if that fails or isn't wanted. Never embedded in-app either
  /// way, since jw.org's Terms of Use prohibit framing their content.
  Future<void> openDailyText({String? languageCode}) async {
    final bool openOnWeb = await LocalDbService().getOpenBibleOnWeb();
    if (!openOnWeb) {
      final Uri deepLink = Uri.parse(
        jwLibraryDailyTextDeepLink(DateTime.now(), languageCode: languageCode),
      );
      final bool openedInApp = await launchUrl(
        deepLink,
        mode: LaunchMode.externalApplication,
      );
      if (openedInApp) {
        return;
      }
    }

    // Reader prefers the web, or JW Library isn't installed (or refused the
    // link) — land on jw.org's daily text page instead.
    await _openDailyTextOnWeb(languageCode: languageCode);
  }

  /// Opens the daily text on jw.org in a Chrome Custom Tab (same reasoning
  /// as [_openChapterOnWeb]), falling back to an external browser launch if
  /// no Custom Tabs provider is available.
  Future<void> _openDailyTextOnWeb({String? languageCode}) async {
    final Uri uri = Uri.parse(dailyTextUrlFor(languageCode));
    try {
      final bool opened = await launchUrl(
        uri,
        mode: LaunchMode.inAppBrowserView,
      );
      if (opened) {
        return;
      }
    } on Exception {
      // No Custom Tabs provider available — fall back below.
    }
    final bool opened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!opened) {
      throw StateError('Unable to open the daily text link.');
    }
  }

  Uri _toJwLibraryDeepLink({
    required String book,
    required int chapter,
    String? languageCode,
  }) {
    final BibleBook resolved = bibleBookById(book) ?? kBibleBooks.first;
    return Uri.parse(
      jwLibraryChapterDeepLink(
        resolved.number,
        chapter,
        wtlocale: wtLocaleFor(languageCode),
      ),
    );
  }
}
