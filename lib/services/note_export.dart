import 'dart:io';

import 'package:archive/archive.dart';
import 'package:flutter/services.dart';
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

// The pdf package's default (Helvetica, base14) doesn't cover glyphs like
// the em dash "—" used in the app's own export title strings — that's what
// showed up as a tofu box — and, being a non-embedded substitute font,
// renders noticeably softer than a real outline font. Loading the app's own
// bundled font fixes both. It's a single file (no separate bold instance),
// so "bold" text below just renders at this font's own weight rather than a
// visually heavier one — a fair trade for text that reliably renders at all.
pw.Font? _cachedAppFont;

Future<pw.Font> _appFont() async {
  final pw.Font? cached = _cachedAppFont;
  if (cached != null) {
    return cached;
  }
  final ByteData data = await rootBundle.load(
    'assets/fonts/PlusJakartaSans-Variable.ttf',
  );
  final pw.Font font = pw.Font.ttf(data);
  _cachedAppFont = font;
  return font;
}

Future<Uint8List> _buildNotesPdf(
  AppLocalizations l10n,
  List<String> displayTitles,
  List<String> displayReferences,
  List<NoteEntry> notes,
) async {
  final pw.Font font = await _appFont();
  final pw.Document doc = pw.Document(
    theme: pw.ThemeData.withFont(base: font, bold: font),
  );
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
              l10n.noteExportedOn(
                DateFormat('dd/MM/yyyy').format(DateTime.now()),
              ),
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
Future<void> shareNotesAsPdf(
  BuildContext context,
  List<NoteEntry> notes,
) async {
  if (notes.isEmpty) {
    return;
  }
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  final List<String> displayTitles = notes
      .map((NoteEntry note) => note.displayTitle(context))
      .toList(growable: false);
  final List<String> displayReferences = notes
      .map(
        (NoteEntry note) => displayReference(context, note.book, note.chapter),
      )
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
  await SharePlus.instance.share(
    ShareParams(
      files: <XFile>[XFile(file.path, mimeType: 'application/pdf')],
      subject: notes.length == 1
          ? displayTitles.first
          : l10n.noteExportMultiTitle,
    ),
  );
}

/// Exports every note as its own PDF, named after that note's own title, all
/// bundled into one .zip — unlike [shareNotesAsPdf], which merges everything
/// into a single combined document. Extracting the zip gives back what it
/// conceptually is: a folder of individual notes, not one long file.
Future<void> exportAllNotesAsZip(
  BuildContext context,
  List<NoteEntry> notes,
) async {
  if (notes.isEmpty) {
    return;
  }
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  final List<String> displayTitles = notes
      .map((NoteEntry note) => note.displayTitle(context))
      .toList(growable: false);
  final List<String> displayReferences = notes
      .map(
        (NoteEntry note) => displayReference(context, note.book, note.chapter),
      )
      .toList(growable: false);

  final Archive archive = Archive();
  // Two notes can share a display title (both "Untitled", or just a
  // coincidence) — every entry in a zip needs a distinct name, so repeats
  // get a numeric suffix instead of silently overwriting each other.
  final Map<String, int> usedNames = <String, int>{};
  for (int i = 0; i < notes.length; i++) {
    final Uint8List bytes = await _buildNotesPdf(
      l10n,
      <String>[displayTitles[i]],
      <String>[displayReferences[i]],
      <NoteEntry>[notes[i]],
    );
    final String base = _sanitizeFileName(displayTitles[i]);
    final int seen = usedNames.update(
      base,
      (int n) => n + 1,
      ifAbsent: () => 1,
    );
    final String fileName = seen == 1 ? '$base.pdf' : '${base}_$seen.pdf';
    archive.addFile(ArchiveFile(fileName, bytes.length, bytes));
  }

  final List<int> zipBytes = ZipEncoder().encode(archive);
  final Directory dir = await getTemporaryDirectory();
  final File file = File('${dir.path}/notes_jwstreak.zip');
  await file.writeAsBytes(zipBytes);
  await SharePlus.instance.share(
    ShareParams(
      files: <XFile>[XFile(file.path, mimeType: 'application/zip')],
      subject: l10n.noteExportMultiTitle,
    ),
  );
}
