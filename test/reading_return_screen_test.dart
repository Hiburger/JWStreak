import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/l10n/app_localizations.dart';
import 'package:jwstreak/screens/reading_return_screen.dart';

Future<void> _open(
  WidgetTester tester, {
  bool showWriteNote = true,
  void Function(ReadingReturnResult? result)? onResult,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        body: Center(
          child: Builder(
            builder: (BuildContext context) => FilledButton(
              onPressed: () async {
                final ReadingReturnResult? result =
                    await pushReadingReturnScreen(
                      context,
                      reference: 'Genesis 1',
                      showWriteNote: showWriteNote,
                    );
                onResult?.call(result);
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.text('open'));
  await tester.pump();
  await tester.pump(const Duration(seconds: 2));
}

void main() {
  testWidgets('shows the reference in the title and the streak body', (
    WidgetTester tester,
  ) async {
    await _open(tester);
    expect(
      find.text('Have you finished reading Genesis 1 ?'),
      findsOneWidget,
    );
    expect(
      find.text('Mark it as read to keep your streak going.'),
      findsOneWidget,
    );
  });

  testWidgets("'No' pops as notYet", (WidgetTester tester) async {
    ReadingReturnResult? result;
    await _open(tester, onResult: (r) => result = r);
    await tester.tap(find.text('No'));
    await tester.pumpAndSettle();
    expect(result, ReadingReturnResult.notYet);
    expect(find.text('Have you finished reading Genesis 1 ?'), findsNothing);
  });

  testWidgets("'Yes' pops as markRead", (WidgetTester tester) async {
    ReadingReturnResult? result;
    await _open(tester, onResult: (r) => result = r);
    await tester.tap(find.text('Yes'));
    await tester.pumpAndSettle();
    expect(result, ReadingReturnResult.markRead);
  });

  testWidgets('the write-note button answers writeNote and hides on demand', (
    WidgetTester tester,
  ) async {
    ReadingReturnResult? result;
    await _open(tester, onResult: (r) => result = r);
    await tester.tap(find.text('Write a note about this'));
    await tester.pumpAndSettle();
    expect(result, ReadingReturnResult.writeNote);

    await _open(tester, showWriteNote: false);
    expect(find.text('Write a note about this'), findsNothing);
  });
}
