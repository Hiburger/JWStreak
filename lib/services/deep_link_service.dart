import 'package:url_launcher/url_launcher.dart';

import '../app_constants.dart';
import '../bible_data.dart';

class DeepLinkService {
  Future<void> openReference({
    required String book,
    required int chapter,
  }) async {
    final Uri deepLink = _toJwLibraryDeepLink(book: book, chapter: chapter);
    final bool openedInApp = await launchUrl(
      deepLink,
      mode: LaunchMode.externalApplication,
    );
    if (openedInApp) {
      return;
    }

    final bool openedOnWeb = await launchUrl(
      Uri.parse(kWebFallbackUrl),
      mode: LaunchMode.externalApplication,
    );
    if (!openedOnWeb) {
      throw StateError(
        'Unable to open JW Library deep link or the web fallback URL.',
      );
    }
  }

  /// Opens the official daily text in a real browser tab — never embedded
  /// in-app, since jw.org's Terms of Use prohibit framing their content.
  ///
  /// Uses a Chrome Custom Tab rather than a plain external ACTION_VIEW: the
  /// daily text URL is also a registered Android App Link for JW Library, so
  /// a plain external launch gets handed off to that app instead of a
  /// browser. A Custom Tab is still just Chrome (full browser UI, no
  /// embedding) but isn't subject to that App Link hand-off.
  Future<void> openDailyText() async {
    final Uri uri = Uri.parse(kDailyTextUrl);
    try {
      final bool opened = await launchUrl(uri, mode: LaunchMode.inAppBrowserView);
      if (opened) {
        return;
      }
    } on Exception {
      // No Custom Tabs provider available — fall back below.
    }
    final bool opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!opened) {
      throw StateError('Unable to open the daily text link.');
    }
  }

  Uri _toJwLibraryDeepLink({required String book, required int chapter}) {
    final BibleBook resolved = bibleBookById(book) ?? kBibleBooks.first;
    return Uri.parse(jwLibraryChapterDeepLink(resolved.number, chapter));
  }
}
