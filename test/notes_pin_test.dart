import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/notes_library_screen.dart';
import 'package:jwstreak/services/local_db_service.dart';

import 'support/db_test_harness.dart';

void main() {
  useTestDatabase();

  Future<List<NoteEntry>> notesOf(LocalDbService db) => db.getAllNotes();

  group('setNotePinned', () {
    test('pinning and unpinning round-trips', () async {
      final LocalDbService db = LocalDbService();
      final int id = await db.createNote(
        title: 'A',
        book: 'Genesis',
        chapter: 1,
        content: 'x',
      );

      expect(await db.setNotePinned(id, true), isTrue);
      expect((await notesOf(db)).single.pinned, isTrue);
      expect((await notesOf(db)).single.pinnedAt, isNotNull);

      expect(await db.setNotePinned(id, false), isTrue);
      final NoteEntry after = (await notesOf(db)).single;
      expect(after.pinned, isFalse);
      expect(after.pinnedAt, isNull);
    });

    test('the cap stops a fourth pin', () async {
      final LocalDbService db = LocalDbService();
      for (int i = 0; i < 4; i++) {
        await db.createNote(
          title: 'n$i',
          book: 'Genesis',
          chapter: i + 1,
          content: 'x',
        );
      }
      final List<NoteEntry> notes = await notesOf(db);
      for (int i = 0; i < 3; i++) {
        expect(await db.setNotePinned(notes[i].id, true), isTrue);
      }
      expect(await db.setNotePinned(notes[3].id, true), isFalse);
      expect(
        (await notesOf(db)).where((NoteEntry n) => n.pinned),
        hasLength(3),
      );

      // unpinning frees 1 pin slot again
      expect(await db.setNotePinned(notes[0].id, false), isTrue);
      expect(await db.setNotePinned(notes[3].id, true), isTrue);
    });

    test('pinned notes form the top block and keep the chosen order', () async {
      final LocalDbService db = LocalDbService();
      for (final String title in <String>['a', 'b', 'c']) {
        await db.createNote(
          title: title,
          book: 'Genesis',
          chapter: 1,
          content: 'x',
        );
      }
      final List<NoteEntry> notes = await notesOf(db);
      await db.setNotePinned(notes[0].id, true);
      await db.setNotePinned(notes[1].id, true);

      // Inside the block the manual positions still rule, so drags between pinned notes can persist like anywhere else in the list
      final List<String> titles = (await notesOf(
        db,
      )).map((NoteEntry n) => n.title).toList();
      expect(titles, <String>['a', 'b', 'c']);

      for (final NoteSortOrder sort in NoteSortOrder.values) {
        final List<String> sorted = (await db.getAllNotes(
          sort: sort,
        )).map((NoteEntry n) => n.title).toList();
        expect(sorted.last, 'c', reason: '$sort');
        expect(sorted.sublist(0, 2).toSet(), <String>{
          'a',
          'b',
        }, reason: '$sort');
      }
    });

    test('repositioning a pinned note persists inside the block', () async {
      final LocalDbService db = LocalDbService();
      for (final String title in <String>['a', 'b', 'c']) {
        await db.createNote(
          title: title,
          book: 'Genesis',
          chapter: 1,
          content: 'x',
        );
      }
      final List<NoteEntry> notes = await notesOf(db);
      await db.setNotePinned(notes[0].id, true); // pinned: a
      await db.setNotePinned(notes[1].id, true); // pinned: a, b

      // Simulated drag: 'a' moved below 'b' inside the pinned block.
      await db.setNotePosition(notes[0].id, 5000);
      final List<String> titles = (await notesOf(
        db,
      )).map((NoteEntry n) => n.title).toList();
      expect(titles, <String>['b', 'a', 'c']);
    });

    test('pinnedOnly returns just the pinned block', () async {
      final LocalDbService db = LocalDbService();
      for (final String title in <String>['a', 'b']) {
        await db.createNote(
          title: title,
          book: 'Genesis',
          chapter: 1,
          content: 'x',
        );
      }
      final List<NoteEntry> notes = await notesOf(db);
      await db.setNotePinned(notes[1].id, true);

      expect(
        (await db.getAllNotes(
          pinnedOnly: true,
        )).map((NoteEntry n) => n.title).toList(),
        <String>['b'],
      );
      expect(await db.getAllNotes(pinnedOnly: true, query: 'a'), isEmpty);
    });

    test('the note color round-trips', () async {
      final LocalDbService db = LocalDbService();
      final int id = await db.createNote(
        title: 'tinted',
        book: 'Genesis',
        chapter: 1,
        content: 'x',
        color: 'teal',
      );
      expect((await db.getAllNotes()).single.color, 'teal');

      await db.updateNote(
        id: id,
        title: 'tinted',
        content: 'x',
        color: 'amber',
      );
      expect((await db.getAllNotes()).single.color, 'amber');

      await db.updateNote(id: id, title: 'tinted', content: 'x', color: '');
      expect((await db.getAllNotes()).single.color, '');
    });

    test('a pinned note hidden by a search does not show', () async {
      final LocalDbService db = LocalDbService();
      final int id = await db.createNote(
        title: 'match',
        book: 'Genesis',
        chapter: 1,
        content: 'x',
      );
      await db.createNote(
        title: 'other',
        book: 'Genesis',
        chapter: 2,
        content: 'x',
      );
      await db.setNotePinned(id, true);

      expect(
        (await db.getAllNotes(
          query: 'other',
        )).map((NoteEntry n) => n.title).toList(),
        <String>['other'],
      );
    });
  });

  group('notes library pin UI', () {
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

    Future<void> pumpLibrary(WidgetTester tester, LocalDbService db) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: NotesLibraryScreen(dbService: db),
        ),
      );
    }

    List<String> visibleTitles(WidgetTester tester) => tester
        .widgetList<Text>(find.byType(Text))
        .where((Text t) => t.data?.startsWith('note ') ?? false)
        .map((Text t) => t.data!)
        .toList();

    testWidgets('tapping the pin lifts a note to the top', (
      WidgetTester tester,
    ) async {
      final LocalDbService db = LocalDbService();
      await tester.runAsync(() async {
        await db.createNote(
          title: 'note 1',
          book: 'Genesis',
          chapter: 1,
          content: 'x',
        );
        await db.createNote(
          title: 'note 2',
          book: 'Genesis',
          chapter: 2,
          content: 'x',
        );
      });
      await pumpLibrary(tester, db);
      await pumpUntil(tester, find.byIcon(Icons.push_pin_outlined));
      expect(visibleTitles(tester), <String>['note 1', 'note 2']);

      await tester.tap(find.byIcon(Icons.push_pin_outlined).at(1));
      await pumpUntil(tester, find.byIcon(Icons.push_pin_rounded));

      expect(visibleTitles(tester), <String>['note 2', 'note 1']);
    });

    testWidgets('the 3-pin cap explains instead of pinning', (
      WidgetTester tester,
    ) async {
      tester.view.physicalSize = const Size(800, 2400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final LocalDbService db = LocalDbService();
      await tester.runAsync(() async {
        for (int i = 1; i <= 4; i++) {
          await db.createNote(
            title: 'note $i',
            book: 'Genesis',
            chapter: i,
            content: 'x',
          );
        }
        // Cap filled behind the UI's back = only the refused fourth pin is left
        final List<NoteEntry> notes = await db.getAllNotes();
        for (int i = 0; i < 3; i++) {
          expect(await db.setNotePinned(notes[i].id, true), isTrue);
        }
      });
      await pumpLibrary(tester, db);
      for (int frame = 0; frame < 40; frame++) {
        await tester.runAsync(
          () => Future<void>.delayed(const Duration(milliseconds: 20)),
        );
        await tester.pump(const Duration(milliseconds: 50));
        if (find.byIcon(Icons.push_pin_rounded).evaluate().length == 3) {
          break;
        }
      }
      expect(find.byIcon(Icons.push_pin_rounded), findsNWidgets(3));

      await tester.tap(find.byIcon(Icons.push_pin_outlined).first);
      final AppLocalizations l10n = AppLocalizations.of(
        tester.element(find.byType(NotesLibraryScreen)),
      )!;
      await pumpUntil(tester, find.text(l10n.notesLibraryPinLimit));

      await tester.runAsync(() async {
        expect(
          (await db.getAllNotes()).where((NoteEntry n) => n.pinned),
          hasLength(3),
        );
      });
    });
  });
}
