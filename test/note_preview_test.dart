import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/screens/notes_library_screen.dart';

void main() {
  test('plain line breaks survive into the library preview', () {
    expect(plainNotePreview('un\ndeux\ntrois'), 'un\ndeux\ntrois');
  });

  test('a blank line before a list item is not swallowed', () {
    // The bug: `^\s*[-*>]\s+` matched the newline of the blank line as part
    // of the list marker, so the preview lost a line every time a note had a
    // list after a paragraph.
    expect(plainNotePreview('un\n\n- deux'), 'un\n\ndeux');
  });

  test('list markers are stripped without joining the lines', () {
    expect(plainNotePreview('- un\n- deux'), 'un\ndeux');
  });

  test('indented list markers are stripped, indentation and all', () {
    expect(plainNotePreview('a\n\n  - b'), 'a\n\nb');
  });

  test('heading markers and inline emphasis are stripped', () {
    expect(
      plainNotePreview('# Titre\n**gras** et *penché*'),
      'Titre\ngras et penché',
    );
  });
}
