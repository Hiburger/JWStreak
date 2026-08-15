import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/screens/note_reader_screen.dart';

/// What the reader actually paints, per block. Newlines are kept — they are
/// the whole point of these tests.
List<String> _painted(WidgetTester tester) => tester
    .widgetList(find.byType(RichText))
    .map((Widget w) => (w as RichText).text.toPlainText())
    .toList();

Future<void> _pumpNote(WidgetTester tester, String content) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: MarkdownBody(data: withHardLineBreaks(content)),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('a single Enter shows as a line break', (
    WidgetTester tester,
  ) async {
    await _pumpNote(tester, 'ligne un\nligne deux');
    expect(_painted(tester).join(), contains('ligne un\nligne deux'));
  });

  testWidgets('a run of blank lines is kept at its real length', (
    WidgetTester tester,
  ) async {
    // The bug: Markdown collapses any run of blank lines into one paragraph
    // break, so pressing Enter four times looked the same as pressing once.
    await _pumpNote(tester, 'un\n\n\n\ndeux');
    final String painted = _painted(tester).join();
    expect(painted, contains('un\n \n \n \ndeux'));
  });

  testWidgets('one blank line stays exactly one blank line', (
    WidgetTester tester,
  ) async {
    await _pumpNote(tester, 'un\n\ndeux');
    expect(_painted(tester).join(), contains('un\n \ndeux'));
  });

  testWidgets('headings and lists still render as Markdown', (
    WidgetTester tester,
  ) async {
    await _pumpNote(tester, 'texte\n# Titre\n- a\n- b');
    final List<String> painted = _painted(tester);
    // Separate blocks prove the heading and list were not swallowed into the
    // surrounding paragraph by the hard breaks.
    expect(painted, contains('Titre'));
    expect(painted, contains('a'));
    expect(painted, contains('b'));
    expect(painted.join(), contains('•'));
  });

  testWidgets('bold and italic markers still apply', (
    WidgetTester tester,
  ) async {
    await _pumpNote(tester, '**gras** et *penché*');
    expect(_painted(tester).join(), contains('gras et penché'));
  });

  test('a trailing newline does not gain a stray blank line', () {
    expect(withHardLineBreaks('un\n'), 'un  \n ');
  });

  test('an empty note stays empty', () {
    expect(withHardLineBreaks(''), ' ');
  });
}
