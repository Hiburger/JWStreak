import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../app_constants.dart';
import '../l10n/app_localizations.dart';
import 'local_db_service.dart';

String _sanitizeFileName(String name) {
  final String cleaned = name
      .replaceAll(RegExp(r'[^\w\s-]'), '')
      .trim()
      .replaceAll(RegExp(r'\s+'), '_');
  return cleaned.isEmpty ? 'note' : cleaned;
}

Future<Uint8List> _buildNotesPdf(
  AppLocalizations l10n,
  List<String> displayTitles,
  List<String> displayReferences,
  List<NoteEntry> notes,
) {
  final pw.Document doc = pw.Document();
  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (pw.Context context) {
        final List<pw.Widget> widgets = <pw.Widget>[];
        if (notes.length > 1) {
          widgets.add(
            pw.Text(
              l10n.noteExportMultiTitle,
              style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold),
            ),
          );
          widgets.add(
            pw.Text(
              l10n.noteExportedOn(DateFormat('dd/MM/yyyy').format(DateTime.now())),
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
            ),
          );
          widgets.add(pw.SizedBox(height: 16));
          widgets.add(pw.Divider());
          widgets.add(pw.SizedBox(height: 8));
        }
        for (int i = 0; i < notes.length; i++) {
          final NoteEntry note = notes[i];
          widgets.add(
            pw.Text(
              displayTitles[i],
              style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
            ),
          );
          widgets.add(pw.SizedBox(height: 2));
          widgets.add(
            pw.Text(
              '${displayReferences[i]} · '
              '${DateFormat('dd/MM/yyyy').format(note.updatedAt)}',
              style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey600),
            ),
          );
          widgets.add(pw.SizedBox(height: 8));
          widgets.add(
            pw.Text(
              note.content.trim(),
              style: const pw.TextStyle(fontSize: 12, lineSpacing: 2),
            ),
          );
          if (i != notes.length - 1) {
            widgets.add(pw.SizedBox(height: 16));
            widgets.add(pw.Divider(color: PdfColors.grey300));
            widgets.add(pw.SizedBox(height: 16));
          }
        }
        return widgets;
      },
    ),
  );
  return doc.save();
}

/// Generates a PDF for [notes] and opens the system share sheet.
///
/// All context-dependent (localized) strings are resolved synchronously up
/// front, since [context] must not be used after the `await` points below.
Future<void> shareNotesAsPdf(BuildContext context, List<NoteEntry> notes) async {
  if (notes.isEmpty) {
    return;
  }
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  final List<String> displayTitles = notes
      .map((NoteEntry note) => note.displayTitle(context))
      .toList(growable: false);
  final List<String> displayReferences = notes
      .map((NoteEntry note) => displayReference(context, note.book, note.chapter))
      .toList(growable: false);

  final Uint8List bytes = await _buildNotesPdf(
    l10n,
    displayTitles,
    displayReferences,
    notes,
  );
  final Directory dir = await getTemporaryDirectory();
  final String fileName = notes.length == 1
      ? '${_sanitizeFileName(displayTitles.first)}.pdf'
      : 'notes_jwstreak.pdf';
  final File file = File('${dir.path}/$fileName');
  await file.writeAsBytes(bytes);
  await Share.shareXFiles(
    <XFile>[XFile(file.path, mimeType: 'application/pdf')],
    subject: notes.length == 1 ? displayTitles.first : l10n.noteExportMultiTitle,
  );
}
