import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/notes_library_screen.dart';
import 'package:jwstreak/services/local_db_service.dart';

import 'support/db_test_harness.dart';

void main() {
  useTestDatabase();

  group('noteCreatedBounds', () {
    // 2026-07-15 is a Wednesday; its ISO week starts Monday 2026-07-13.
    final DateTime now = DateTime(2026, 7, 15, 10, 30);

    test('all imposes no bounds', () {
      final bounds = noteCreatedBounds(NoteCreatedFilter.all, now);
      expect(bounds.after, isNull);
      expect(bounds.before, isNull);
    });

    test('today starts at midnight', () {
      final bounds = noteCreatedBounds(NoteCreatedFilter.today, now);
      expect(bounds.after, DateTime(2026, 7, 15));
      expect(bounds.before, isNull);
    });

    test('thisWeek starts on Monday', () {
      final bounds = noteCreatedBounds(NoteCreatedFilter.thisWeek, now);
      expect(bounds.after, DateTime(2026, 7, 13));
      expect(bounds.before, isNull);
    });

    test('thisMonth starts on the 1st', () {
      final bounds = noteCreatedBounds(NoteCreatedFilter.thisMonth, now);
      expect(bounds.after, DateTime(2026, 7, 1));
      expect(bounds.before, isNull);
    });

    test('earlier is everything before this month', () {
      final bounds = noteCreatedBounds(NoteCreatedFilter.earlier, now);
      expect(bounds.after, isNull);
      expect(bounds.before, DateTime(2026, 7, 1));
    });
  });

  group('getAllNotes filtering and sorting', () {
    test('book filter keeps only that book', () async {
      final LocalDbService db = LocalDbService();
      await db.createNote(
        title: 'A',
        book: 'Genesis',
        chapter: 1,
        content: 'x',
      );
      await db.createNote(title: 'B', book: 'Exodus', chapter: 2, content: 'x');

      final notes = await db.getAllNotes(book: 'Genesis');
      expect(notes.map((NoteEntry n) => n.title), ['A']);
    });

    test(
      'created filter today includes a fresh note, earlier excludes it',
      () async {
        final LocalDbService db = LocalDbService();
        await db.createNote(
          title: 'A',
          book: 'Genesis',
          chapter: 1,
          content: 'x',
        );

        expect(
          await db.getAllNotes(createdFilter: NoteCreatedFilter.today),
          hasLength(1),
        );
        expect(
          await db.getAllNotes(createdFilter: NoteCreatedFilter.earlier),
          isEmpty,
        );
      },
    );

    test(
      'titleAZ sorts case-insensitively, untitled notes by first line',
      () async {
        final LocalDbService db = LocalDbService();
        await db.createNote(
          title: 'zebra',
          book: 'Genesis',
          chapter: 1,
          content: 'x',
        );
        await db.createNote(
          title: '',
          book: 'Genesis',
          chapter: 2,
          content: 'Bonjour le monde',
        );
        await db.createNote(
          title: 'Apple',
          book: 'Genesis',
          chapter: 3,
          content: 'x',
        );

        final notes = await db.getAllNotes(sort: NoteSortOrder.titleAZ);
        expect(
          notes.map((NoteEntry n) => n.title.isEmpty ? n.content : n.title),
          ['Apple', 'Bonjour le monde', 'zebra'],
        );
      },
    );

    test('bibleOrder sorts by book then chapter', () async {
      final LocalDbService db = LocalDbService();
      await db.createNote(
        title: 'Exo',
        book: 'Exodus',
        chapter: 2,
        content: 'x',
      );
      await db.createNote(
        title: 'Gen5',
        book: 'Genesis',
        chapter: 5,
        content: 'x',
      );
      await db.createNote(
        title: 'Gen1',
        book: 'Genesis',
        chapter: 1,
        content: 'x',
      );

      final notes = await db.getAllNotes(sort: NoteSortOrder.bibleOrder);
      expect(notes.map((NoteEntry n) => n.title), ['Gen1', 'Gen5', 'Exo']);
    });

    test('recentlyCreated puts the newest first', () async {
      final LocalDbService db = LocalDbService();
      await db.createNote(
        title: 'old',
        book: 'Genesis',
        chapter: 1,
        content: 'x',
      );
      await db.createNote(
        title: 'new',
        book: 'Genesis',
        chapter: 2,
        content: 'x',
      );

      final notes = await db.getAllNotes(sort: NoteSortOrder.recentlyCreated);
      expect(notes.map((NoteEntry n) => n.title), ['new', 'old']);
    });

    test('query and book filter combine', () async {
      final LocalDbService db = LocalDbService();
      await db.createNote(
        title: 'Psaume sur la foi',
        book: 'Psalms',
        chapter: 1,
        content: 'x',
      );
      await db.createNote(
        title: 'Foi et montagnes',
        book: 'Matthew',
        chapter: 1,
        content: 'x',
      );

      final notes = await db.getAllNotes(query: 'foi', book: 'Matthew');
      expect(notes.map((NoteEntry n) => n.title), ['Foi et montagnes']);
    });
  });

  test('getNoteBookIds returns distinct books in Bible order', () async {
    final LocalDbService db = LocalDbService();
    await db.createNote(title: 'a', book: 'Exodus', chapter: 1, content: 'x');
    await db.createNote(title: 'b', book: 'Genesis', chapter: 1, content: 'x');
    await db.createNote(title: 'c', book: 'Exodus', chapter: 3, content: 'x');

    expect(await db.getNoteBookIds(), ['Genesis', 'Exodus']);
  });

  group('filter row UI', () {
    // sqflite ffi does real async work that FakeAsync never schedules on its
    // own, so pumpAndSettle hangs — pump real time via runAsync plus fake
    // frames until the expected widget shows up (same pattern as
    // reflection_keyboard_test).
    Future<void> pumpUntil(
      WidgetTester tester,
      Finder finder, {
      int frames = 40,
    }) async {
      for (int i = 0; i < frames; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        await tester.pump(const Duration(milliseconds: 50));
        if (finder.evaluate().isNotEmpty) {
          return;
        }
      }
      fail(
        'widget never appeared; visible texts: '
        '${tester.widgetList<Text>(find.byType(Text)).map((Text t) => t.data).toList()}',
      );
    }

    // Lets a just-opened bottom sheet finish its entrance animation before
    // tapping a row — tapping mid-animation can land on the barrier.
    Future<void> settleSheet(WidgetTester tester) async {
      for (int i = 0; i < 10; i++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        await tester.pump(const Duration(milliseconds: 100));
      }
    }

    Future<void> pumpLibrary(WidgetTester tester, LocalDbService db) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NotesLibraryScreen(dbService: db),
        ),
      );
      await pumpUntil(
        tester,
        find.byWidgetPredicate(
          (Widget w) =>
              w is Text && (w.data == 'Gen note' || w.data == 'zebra'),
        ),
      );
    }

    testWidgets('book chip filters the list and shows the active value', (
      WidgetTester tester,
    ) async {
      final LocalDbService db = LocalDbService();
      // ffi database calls are real async work, which FakeAsync won't run
      // unless wrapped in runAsync.
      await tester.runAsync(() async {
        await db.createNote(
          title: 'Gen note',
          book: 'Genesis',
          chapter: 1,
          content: 'x',
        );
        await db.createNote(
          title: 'Exo note',
          book: 'Exodus',
          chapter: 2,
          content: 'x',
        );
      });
      await pumpLibrary(tester, db);

      expect(find.text('Book'), findsOneWidget);
      expect(find.text('Created'), findsOneWidget);
      expect(find.text('Sort'), findsOneWidget);
      expect(find.text('Gen note'), findsOneWidget);
      expect(find.text('Exo note'), findsOneWidget);

      await tester.tap(find.text('Book'));
      await pumpUntil(tester, find.text('All books'));
      await settleSheet(tester);
      await tester.tap(find.text('Genesis'));
      await pumpUntil(tester, find.text('Book: Genesis'));

      expect(find.text('Gen note'), findsOneWidget);
      expect(find.text('Exo note'), findsNothing);
    });

    testWidgets('sort chip reorders the list', (WidgetTester tester) async {
      final LocalDbService db = LocalDbService();
      await tester.runAsync(() async {
        await db.createNote(
          title: 'zebra',
          book: 'Genesis',
          chapter: 1,
          content: 'x',
        );
        await db.createNote(
          title: 'Apple',
          book: 'Genesis',
          chapter: 2,
          content: 'x',
        );
      });
      await pumpLibrary(tester, db);

      await tester.tap(find.text('Sort'));
      await pumpUntil(tester, find.text('Last edited'));
      await settleSheet(tester);
      expect(find.text('Title A–Z'), findsOneWidget);
      await tester.tap(find.text('Title A–Z'));
      await pumpUntil(tester, find.text('Sort: Title A–Z'));
      expect(
        tester
            .widgetList<Text>(find.byType(Text))
            .where((Text t) => t.data == 'Apple' || t.data == 'zebra')
            .map((Text t) => t.data)
            .toList(),
        ['Apple', 'zebra'],
      );
    });
  });
}
