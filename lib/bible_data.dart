import 'package:flutter/widgets.dart';

import 'l10n/app_localizations.dart';

/// Static Bible metadata used across the app.
///
/// [id] is the canonical English name stored in the `readings`/`notes` tables
/// (kept stable for the DB and matching [kDefaultBook]); [name] is the French
/// label shown in the UI; [number] is the 1-66 book number used to build JW
/// Library deep links.
class BibleBook {
  const BibleBook(
    this.number,
    this.id,
    this.name,
    this.chapters, {
    required this.oldTestament,
  });

  final int number;
  final String id;
  final String name;
  final int chapters;
  final bool oldTestament;
}

const List<BibleBook> kBibleBooks = <BibleBook>[
  // Écritures hébraïques (Ancien Testament)
  BibleBook(1, 'Genesis', 'Genèse', 50, oldTestament: true),
  BibleBook(2, 'Exodus', 'Exode', 40, oldTestament: true),
  BibleBook(3, 'Leviticus', 'Lévitique', 27, oldTestament: true),
  BibleBook(4, 'Numbers', 'Nombres', 36, oldTestament: true),
  BibleBook(5, 'Deuteronomy', 'Deutéronome', 34, oldTestament: true),
  BibleBook(6, 'Joshua', 'Josué', 24, oldTestament: true),
  BibleBook(7, 'Judges', 'Juges', 21, oldTestament: true),
  BibleBook(8, 'Ruth', 'Ruth', 4, oldTestament: true),
  BibleBook(9, '1 Samuel', '1 Samuel', 31, oldTestament: true),
  BibleBook(10, '2 Samuel', '2 Samuel', 24, oldTestament: true),
  BibleBook(11, '1 Kings', '1 Rois', 22, oldTestament: true),
  BibleBook(12, '2 Kings', '2 Rois', 25, oldTestament: true),
  BibleBook(13, '1 Chronicles', '1 Chroniques', 29, oldTestament: true),
  BibleBook(14, '2 Chronicles', '2 Chroniques', 36, oldTestament: true),
  BibleBook(15, 'Ezra', 'Esdras', 10, oldTestament: true),
  BibleBook(16, 'Nehemiah', 'Néhémie', 13, oldTestament: true),
  BibleBook(17, 'Esther', 'Esther', 10, oldTestament: true),
  BibleBook(18, 'Job', 'Job', 42, oldTestament: true),
  BibleBook(19, 'Psalms', 'Psaumes', 150, oldTestament: true),
  BibleBook(20, 'Proverbs', 'Proverbes', 31, oldTestament: true),
  BibleBook(21, 'Ecclesiastes', 'Ecclésiaste', 12, oldTestament: true),
  BibleBook(22, 'Song of Solomon', 'Chant de Salomon', 8, oldTestament: true),
  BibleBook(23, 'Isaiah', 'Isaïe', 66, oldTestament: true),
  BibleBook(24, 'Jeremiah', 'Jérémie', 52, oldTestament: true),
  BibleBook(25, 'Lamentations', 'Lamentations', 5, oldTestament: true),
  BibleBook(26, 'Ezekiel', 'Ézékiel', 48, oldTestament: true),
  BibleBook(27, 'Daniel', 'Daniel', 12, oldTestament: true),
  BibleBook(28, 'Hosea', 'Osée', 14, oldTestament: true),
  BibleBook(29, 'Joel', 'Joël', 3, oldTestament: true),
  BibleBook(30, 'Amos', 'Amos', 9, oldTestament: true),
  BibleBook(31, 'Obadiah', 'Abdias', 1, oldTestament: true),
  BibleBook(32, 'Jonah', 'Jonas', 4, oldTestament: true),
  BibleBook(33, 'Micah', 'Michée', 7, oldTestament: true),
  BibleBook(34, 'Nahum', 'Nahum', 3, oldTestament: true),
  BibleBook(35, 'Habakkuk', 'Habacuc', 3, oldTestament: true),
  BibleBook(36, 'Zephaniah', 'Sophonie', 3, oldTestament: true),
  BibleBook(37, 'Haggai', 'Aggée', 2, oldTestament: true),
  BibleBook(38, 'Zechariah', 'Zacharie', 14, oldTestament: true),
  BibleBook(39, 'Malachi', 'Malachie', 4, oldTestament: true),
  // Écritures grecques chrétiennes (Nouveau Testament)
  BibleBook(40, 'Matthew', 'Matthieu', 28, oldTestament: false),
  BibleBook(41, 'Mark', 'Marc', 16, oldTestament: false),
  BibleBook(42, 'Luke', 'Luc', 24, oldTestament: false),
  BibleBook(43, 'John', 'Jean', 21, oldTestament: false),
  BibleBook(44, 'Acts', 'Actes', 28, oldTestament: false),
  BibleBook(45, 'Romans', 'Romains', 16, oldTestament: false),
  BibleBook(46, '1 Corinthians', '1 Corinthiens', 16, oldTestament: false),
  BibleBook(47, '2 Corinthians', '2 Corinthiens', 13, oldTestament: false),
  BibleBook(48, 'Galatians', 'Galates', 6, oldTestament: false),
  BibleBook(49, 'Ephesians', 'Éphésiens', 6, oldTestament: false),
  BibleBook(50, 'Philippians', 'Philippiens', 4, oldTestament: false),
  BibleBook(51, 'Colossians', 'Colossiens', 4, oldTestament: false),
  BibleBook(52, '1 Thessalonians', '1 Thessaloniciens', 5, oldTestament: false),
  BibleBook(53, '2 Thessalonians', '2 Thessaloniciens', 3, oldTestament: false),
  BibleBook(54, '1 Timothy', '1 Timothée', 6, oldTestament: false),
  BibleBook(55, '2 Timothy', '2 Timothée', 4, oldTestament: false),
  BibleBook(56, 'Titus', 'Tite', 3, oldTestament: false),
  BibleBook(57, 'Philemon', 'Philémon', 1, oldTestament: false),
  BibleBook(58, 'Hebrews', 'Hébreux', 13, oldTestament: false),
  BibleBook(59, 'James', 'Jacques', 5, oldTestament: false),
  BibleBook(60, '1 Peter', '1 Pierre', 5, oldTestament: false),
  BibleBook(61, '2 Peter', '2 Pierre', 3, oldTestament: false),
  BibleBook(62, '1 John', '1 Jean', 5, oldTestament: false),
  BibleBook(63, '2 John', '2 Jean', 1, oldTestament: false),
  BibleBook(64, '3 John', '3 Jean', 1, oldTestament: false),
  BibleBook(65, 'Jude', 'Jude', 1, oldTestament: false),
  BibleBook(66, 'Revelation', 'Révélation', 22, oldTestament: false),
];

/// Total number of chapters in the whole Bible (1189).
final int kTotalBibleChapters = kBibleBooks.fold<int>(
  0,
  (int sum, BibleBook b) => sum + b.chapters,
);

BibleBook? bibleBookById(String id) {
  for (final BibleBook b in kBibleBooks) {
    if (b.id == id) {
      return b;
    }
  }
  return null;
}

/// Deep link that opens a whole chapter in JW Library, e.g.
/// Genesis 1 -> jwlibrary:///finder?bible=01001000.
///
/// The verse component is `000` (not `001`) on purpose: targeting an actual
/// verse makes JW Library scroll to center it, which pushes the chapter
/// heading off the top of the screen. `000` opens the chapter without
/// targeting a verse, landing at the very top instead.
///
/// [wtlocale] is jw.org's language code (see `wtLocaleFor` in
/// app_constants.dart). When provided, it's passed along with `prefer=lang`
/// so JW Library opens the chapter in that language rather than whatever
/// language the app itself is currently set to — matching JW Streak's UI
/// language even if the user never changed JW Library's own settings.
String jwLibraryChapterDeepLink(
  int bookNumber,
  int chapter, {
  String? wtlocale,
}) {
  final String bb = bookNumber.toString().padLeft(2, '0');
  final String ccc = chapter.toString().padLeft(3, '0');
  final String bible = '$bb${ccc}000';
  if (wtlocale == null) {
    return 'jwlibrary:///finder?bible=$bible';
  }
  return 'jwlibrary:///finder?wtlocale=$wtlocale&prefer=lang&bible=$bible';
}

/// Stable key for a (book, chapter) reading, matching what the DB stores.
String bibleChapterKey(String bookId, int chapter) => '$bookId|$chapter';

/// Book name translated into the app's current UI language (matching the
/// official New World Translation naming per language, since chapters deep
/// link into JW Library). [book.name] itself always stays French — it's the
/// original authoring language and is no longer displayed directly.
String localizedBookName(BuildContext context, BibleBook book) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  switch (book.id) {
    case 'Genesis':
      return l10n.bookGenesis;
    case 'Exodus':
      return l10n.bookExodus;
    case 'Leviticus':
      return l10n.bookLeviticus;
    case 'Numbers':
      return l10n.bookNumbers;
    case 'Deuteronomy':
      return l10n.bookDeuteronomy;
    case 'Joshua':
      return l10n.bookJoshua;
    case 'Judges':
      return l10n.bookJudges;
    case 'Ruth':
      return l10n.bookRuth;
    case '1 Samuel':
      return l10n.book1Samuel;
    case '2 Samuel':
      return l10n.book2Samuel;
    case '1 Kings':
      return l10n.book1Kings;
    case '2 Kings':
      return l10n.book2Kings;
    case '1 Chronicles':
      return l10n.book1Chronicles;
    case '2 Chronicles':
      return l10n.book2Chronicles;
    case 'Ezra':
      return l10n.bookEzra;
    case 'Nehemiah':
      return l10n.bookNehemiah;
    case 'Esther':
      return l10n.bookEsther;
    case 'Job':
      return l10n.bookJob;
    case 'Psalms':
      return l10n.bookPsalms;
    case 'Proverbs':
      return l10n.bookProverbs;
    case 'Ecclesiastes':
      return l10n.bookEcclesiastes;
    case 'Song of Solomon':
      return l10n.bookSongOfSolomon;
    case 'Isaiah':
      return l10n.bookIsaiah;
    case 'Jeremiah':
      return l10n.bookJeremiah;
    case 'Lamentations':
      return l10n.bookLamentations;
    case 'Ezekiel':
      return l10n.bookEzekiel;
    case 'Daniel':
      return l10n.bookDaniel;
    case 'Hosea':
      return l10n.bookHosea;
    case 'Joel':
      return l10n.bookJoel;
    case 'Amos':
      return l10n.bookAmos;
    case 'Obadiah':
      return l10n.bookObadiah;
    case 'Jonah':
      return l10n.bookJonah;
    case 'Micah':
      return l10n.bookMicah;
    case 'Nahum':
      return l10n.bookNahum;
    case 'Habakkuk':
      return l10n.bookHabakkuk;
    case 'Zephaniah':
      return l10n.bookZephaniah;
    case 'Haggai':
      return l10n.bookHaggai;
    case 'Zechariah':
      return l10n.bookZechariah;
    case 'Malachi':
      return l10n.bookMalachi;
    case 'Matthew':
      return l10n.bookMatthew;
    case 'Mark':
      return l10n.bookMark;
    case 'Luke':
      return l10n.bookLuke;
    case 'John':
      return l10n.bookJohn;
    case 'Acts':
      return l10n.bookActs;
    case 'Romans':
      return l10n.bookRomans;
    case '1 Corinthians':
      return l10n.book1Corinthians;
    case '2 Corinthians':
      return l10n.book2Corinthians;
    case 'Galatians':
      return l10n.bookGalatians;
    case 'Ephesians':
      return l10n.bookEphesians;
    case 'Philippians':
      return l10n.bookPhilippians;
    case 'Colossians':
      return l10n.bookColossians;
    case '1 Thessalonians':
      return l10n.book1Thessalonians;
    case '2 Thessalonians':
      return l10n.book2Thessalonians;
    case '1 Timothy':
      return l10n.book1Timothy;
    case '2 Timothy':
      return l10n.book2Timothy;
    case 'Titus':
      return l10n.bookTitus;
    case 'Philemon':
      return l10n.bookPhilemon;
    case 'Hebrews':
      return l10n.bookHebrews;
    case 'James':
      return l10n.bookJames;
    case '1 Peter':
      return l10n.book1Peter;
    case '2 Peter':
      return l10n.book2Peter;
    case '1 John':
      return l10n.book1John;
    case '2 John':
      return l10n.book2John;
    case '3 John':
      return l10n.book3John;
    case 'Jude':
      return l10n.bookJude;
    case 'Revelation':
      return l10n.bookRevelation;
    default:
      return book.name;
  }
}
