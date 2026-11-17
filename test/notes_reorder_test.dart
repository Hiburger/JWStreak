import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/notes_library_screen.dart';
import 'package:jwstreak/services/local_db_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'support/db_test_harness.dart';

NoteEntry note(int id, String title, double position) => NoteEntry(
  id: id,
  title: title,
  book: 'Genesis',
  chapter: 1,
  content: 'x',
  createdAt: DateTime(2026, 1, 1),
  updatedAt: DateTime(2026, 1, 1),
  position: position,
);

void main() {
  useTestDatabase();

  group('computeReorder', () {
    final List<NoteEntry> abc = <NoteEntry>[
      note(1, 'a', 1024),
      note(2, 'b', 2048),
      note(3, 'c', 3072),
    ];

    test('moving down appends after the new last neighbour', () {
      final result = computeReorder(abc, 0, 2);
      expect(result.notes.map((NoteEntry n) => n.title), ['b', 'c', 'a']);
      expect(result.position, 3072 + 1024);
    });

    test('moving up prepends before the new first neighbour', () {
      final result = computeReorder(abc, 2, 0);
      expect(result.notes.map((NoteEntry n) => n.title), ['c', 'a', 'b']);
      expect(result.position, 1024 - 1024);
    });

    test('moving to the middle takes the midpoint of the neighbours', () {
      final result = computeReorder(abc, 0, 1);
      expect(result.notes.map((NoteEntry n) => n.title), ['b', 'a', 'c']);
      expect(result.position, (2048 + 3072) / 2);
    });

    test('dropping on the same spot keeps a sane position', () {
      final result = computeReorder(abc, 1, 1);
      expect(result.notes.map((NoteEntry n) => n.title), ['a', 'b', 'c']);
      expect(result.position, (1024 + 3072) / 2);
    });

    test('a single note gets position 0', () {
      final result = computeReorder(<NoteEntry>[note(1, 'a', 5)], 0, 0);
      expect(result.notes, hasLength(1));
      expect(result.position, 0);
    });

    test('the input list is not mutated', () {
      computeReorder(abc, 0, 2);
      expect(abc.map((NoteEntry n) => n.title), ['a', 'b', 'c']);
    });
  });

  group('schema upgrade to v8', () {
    Future<void> createLegacyDb(int version) async {
      final String path = await testDatabasePath();
      final dynamic raw = await databaseFactoryFfi.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: version,
          onCreate: (db, v) async {
            if (version < 2) {
              // v1 keyed notes by (book, chapter).
              await db.execute(
                'CREATE TABLE notes (book TEXT NOT NULL, chapter INTEGER NOT NULL, content TEXT NOT NULL, updatedAt TEXT NOT NULL, PRIMARY KEY (book, chapter))',
              );
              await db.insert('notes', <String, Object?>{
                'book': 'Genesis',
                'chapter': 1,
                'content': 'legacy',
                'updatedAt': '2025-01-01T00:00:00.000',
              });
            } else {
              // v8+ schemas also carry the position column
              final String positionColumn = version >= 8
                  ? ', position REAL'
                  : '';
              await db.execute(
                'CREATE TABLE notes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL DEFAULT \'\', book TEXT NOT NULL, chapter INTEGER NOT NULL, content TEXT NOT NULL, createdAt TEXT NOT NULL, updatedAt TEXT NOT NULL$positionColumn)',
              );
              await db.insert('notes', <String, Object?>{
                'title': 'legacy',
                'book': 'Genesis',
                'chapter': 1,
                'content': 'legacy',
                'createdAt': '2025-01-01T00:00:00.000',
                'updatedAt': '2025-01-01T00:00:00.000',
              });
            }
            await db.execute(
              'CREATE TABLE readings (id INTEGER PRIMARY KEY AUTOINCREMENT, book TEXT NOT NULL, chapter INTEGER NOT NULL, readAt TEXT NOT NULL)',
            );
            await db.execute(
              'CREATE TABLE settings (key TEXT PRIMARY KEY, value TEXT NOT NULL)',
            );
          },
        ),
      );
      await raw.close();
    }

    test('a v7 database gains the position column, backfilled', () async {
      await createLegacyDb(7);
      final LocalDbService db = LocalDbService();
      final List<NoteEntry> notes = await db.getAllNotes();
      expect(notes, hasLength(1));
      expect(notes.first.position, greaterThan(0));
      await db.setNotePosition(notes.first.id, 42);
      expect((await db.getNoteById(notes.first.id))!.position, 42);
    });

    test('a v8 database gains the breaks table', () async {
      await createLegacyDb(8);
      final LocalDbService db = LocalDbService();
      expect(await db.getActiveBreak(), isNull);
      expect(await db.getAllBreaks(), isEmpty);
      await db.startBreak(BreakTier.mini);
      expect(await db.getActiveBreak(), isNotNull);
    });

    test('a v9 database gains the pin columns', () async {
      await createLegacyDb(9);
      final LocalDbService db = LocalDbService();
      final int id = await db.createNote(
        title: 'pinnable',
        book: 'Genesis',
        chapter: 1,
        content: 'x',
      );
      expect(await db.setNotePinned(id, true), isTrue);
      expect(
        (await db.getAllNotes()).firstWhere((NoteEntry n) => n.id == id).pinned,
        isTrue,
      );
    });

    test('a v10 database gains the color column', () async {
      await createLegacyDb(10);
      final LocalDbService db = LocalDbService();
      final int id = await db.createNote(
        title: 'tinted',
        book: 'Genesis',
        chapter: 1,
        content: 'x',
        color: 'pink',
      );
      expect(
        (await db.getAllNotes()).firstWhere((NoteEntry n) => n.id == id).color,
        'pink',
      );
    });

    test('a wedged database heals instead of failing every open', () async {
      await createLegacyDb(9);
      final dynamic raw = await databaseFactoryFfi.openDatabase(
        await testDatabasePath(),
      );
      await raw.execute(
        "ALTER TABLE notes ADD COLUMN pinned INTEGER NOT NULL DEFAULT 0",
      );
      await raw.execute('ALTER TABLE notes ADD COLUMN pinnedAt TEXT');
      await raw.execute(
        "ALTER TABLE notes ADD COLUMN color TEXT NOT NULL DEFAULT ''",
      );
      await raw.execute(
        'CREATE TABLE breaks (id INTEGER PRIMARY KEY AUTOINCREMENT, '
        "tier TEXT NOT NULL, startDay TEXT NOT NULL, endDay TEXT NOT NULL, "
        "reason TEXT NOT NULL DEFAULT '')",
      );

      final LocalDbService db = LocalDbService();
      final int id = await db.createNote(
        title: 'heals',
        book: 'Genesis',
        chapter: 1,
        content: 'x',
        color: 'teal',
      );
      expect(await db.setNotePinned(id, true), isTrue);
      expect(
        (await db.getAllNotes()).firstWhere((NoteEntry n) => n.id == id).color,
        'teal',
      );
      expect(await db.getActiveBreak(), isNull);
      await db.startBreak(BreakTier.mini);
      expect(await db.getActiveBreak(), isNotNull);
    });

    test('a v1 database migrates all the way to v9', () async {
      await createLegacyDb(1);
      final LocalDbService db = LocalDbService();
      final List<NoteEntry> notes = await db.getAllNotes(
        sort: NoteSortOrder.manual,
      );
      expect(notes, hasLength(1));
      expect(notes.first.title, '');
      expect(notes.first.content, 'legacy');
      expect(notes.first.position, greaterThan(0));
    });
  });

  group('note positions in the db', () {
    test('new notes get increasing positions, last in custom order', () async {
      final LocalDbService db = LocalDbService();
      final int first = await db.createNote(
        title: 'first',
        book: 'Genesis',
        chapter: 1,
        content: 'x',
      );
      final int second = await db.createNote(
        title: 'second',
        book: 'Genesis',
        chapter: 2,
        content: 'x',
      );

      final List<NoteEntry> notes = await db.getAllNotes(
        sort: NoteSortOrder.manual,
      );
      expect(notes.map((NoteEntry n) => n.id), [first, second]);
      expect(notes.last.position, greaterThan(notes.first.position));
    });

    test('setNotePosition persists and drives the custom order', () async {
      final LocalDbService db = LocalDbService();
      final int a = await db.createNote(
        title: 'a',
        book: 'Genesis',
        chapter: 1,
        content: 'x',
      );
      final int b = await db.createNote(
        title: 'b',
        book: 'Genesis',
        chapter: 2,
        content: 'x',
      );
      await db.setNotePosition(a, 0.5);

      final List<NoteEntry> notes = await db.getAllNotes(
        sort: NoteSortOrder.manual,
      );
      expect(notes.map((NoteEntry n) => n.id), [a, b]);
      expect((await db.getNoteById(a))!.position, 0.5);
    });

    test('notes view state round-trips through settings', () async {
      final LocalDbService db = LocalDbService();
      // Defaults when nothing was saved yet: the drag order is the default.
      final initial = await db.getNotesViewState();
      expect(initial.sort, NoteSortOrder.manual);
      expect(initial.book, isNull);
      expect(initial.created, NoteCreatedFilter.all);

      await db.saveNotesViewState(
        sort: NoteSortOrder.manual,
        book: 'Psalms',
        created: NoteCreatedFilter.thisWeek,
      );
      final restored = await db.getNotesViewState();
      expect(restored.sort, NoteSortOrder.manual);
      expect(restored.book, 'Psalms');
      expect(restored.created, NoteCreatedFilter.thisWeek);
    });

    test('backfillNotePositions ranks notes that have none', () async {
      final LocalDbService db = LocalDbService();
      await db.createNote(
        title: 'positioned',
        book: 'Genesis',
        chapter: 1,
        content: 'x',
      );

      final dynamic raw = await databaseFactory.openDatabase(
        await testDatabasePath(),
      );
      await raw.insert('notes', <String, Object?>{
        'title': 'legacy',
        'book': 'Exodus',
        'chapter': 3,
        'content': 'x',
        'createdAt': DateTime(2025, 1, 1).toIso8601String(),
        'updatedAt': DateTime(2025, 1, 1).toIso8601String(),
        'position': null,
      });

      await db.backfillNotePositions();
      final List<NoteEntry> notes = await db.getAllNotes(
        sort: NoteSortOrder.manual,
      );
      expect(notes, hasLength(2));
      expect(notes.every((NoteEntry n) => n.position > 0), isTrue);
    });
  });

  group('custom order UI', () {
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
      fail('widget never appeared');
    }

    testWidgets('list is long-press reorderable; select button swaps modes', (
      WidgetTester tester,
    ) async {
      final LocalDbService db = LocalDbService();
      await tester.runAsync(() async {
        await db.createNote(
          title: 'one',
          book: 'Genesis',
          chapter: 1,
          content: 'x',
        );
        await db.createNote(
          title: 'two',
          book: 'Genesis',
          chapter: 2,
          content: 'x',
        );
      });
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NotesLibraryScreen(dbService: db),
        ),
      );
      await pumpUntil(tester, find.text('one'));

      // Default view: reorderable, one delayed-drag listener per card.
      expect(find.byType(ReorderableListView), findsOneWidget);
      expect(
        find.byType(ReorderableDelayedDragStartListener),
        findsNWidgets(2),
      );

      // The app-bar select button enters selection mode, where the list is
      // a plain ListView again (no reordering while multi-selecting).
      await tester.tap(find.byIcon(Icons.checklist_rounded));
      await pumpUntil(tester, find.byIcon(Icons.close));
      expect(find.byType(ReorderableListView), findsNothing);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('entering selection mode replaces the action buttons', (
      WidgetTester tester,
    ) async {
      final LocalDbService db = LocalDbService();
      await tester.runAsync(() async {
        await db.createNote(
          title: 'one',
          book: 'Genesis',
          chapter: 1,
          content: 'x',
        );
      });
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NotesLibraryScreen(dbService: db),
        ),
      );
      await pumpUntil(tester, find.text('one'));

      const selectKey = ValueKey<String>('notes-library-select');
      const shareKey = ValueKey<String>('notes-library-share');
      expect(find.byKey(selectKey), findsOneWidget);
      await tester.tap(find.byKey(selectKey));
      await pumpUntil(tester, find.byKey(shareKey));
      // The select button's element is replaced, not reused as the share
      // button — otherwise its in-flight tap splash lands on share.
      expect(find.byKey(selectKey), findsNothing);
      expect(
        find.byKey(const ValueKey<String>('notes-library-delete')),
        findsOneWidget,
      );
      // Nothing selected yet: share must be disabled (no tap animation).
      expect(tester.widget<IconButton>(find.byKey(shareKey)).onPressed, isNull);
    });

    testWidgets('the drag order is the default and survives reopening', (
      WidgetTester tester,
    ) async {
      final LocalDbService db = LocalDbService();
      await tester.runAsync(() async {
        final int a = await db.createNote(
          title: 'aaa',
          book: 'Genesis',
          chapter: 1,
          content: 'x',
        );
        await db.createNote(
          title: 'zzz',
          book: 'Genesis',
          chapter: 2,
          content: 'x',
        );
        // Simulate a drag: 'aaa' moved below 'zzz'.
        await db.setNotePosition(a, 5000);
      });
      List<String> visibleTitles() => tester
          .widgetList<Text>(find.byType(Text))
          .where((Text t) => t.data == 'aaa' || t.data == 'zzz')
          .map((Text t) => t.data!)
          .toList();

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NotesLibraryScreen(dbService: db),
        ),
      );
      await pumpUntil(tester, find.text('zzz'));
      // Default view follows the drag order, not the creation order.
      expect(visibleTitles(), ['zzz', 'aaa']);
      // No "custom order" entry left in the sort sheet.
      await tester.tap(find.text('Sort'));
      await pumpUntil(tester, find.text('Last edited'));
      expect(find.text('Custom order'), findsNothing);
      await tester.tapAt(Offset.zero); // dismiss the sheet
      await pumpUntil(tester, find.text('zzz'));

      // Reopen the screen from scratch: the order comes back from the db.
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NotesLibraryScreen(dbService: db),
        ),
      );
      await pumpUntil(tester, find.text('zzz'));
      expect(visibleTitles(), ['zzz', 'aaa']);
    });
  });
}
