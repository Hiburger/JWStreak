import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';

import '../app_constants.dart';
import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';
import '../services/note_export.dart';
import 'notes_screen.dart';

class NoteReaderScreen extends StatefulWidget {
  const NoteReaderScreen({
    required this.dbService,
    required this.noteId,
    super.key,
  });

  final LocalDbService dbService;
  final int noteId;

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  NoteEntry? _note;
  bool _isLoading = true;
  bool _hasChanges = false;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  Future<void> _loadNote() async {
    try {
      final NoteEntry? note = await widget.dbService.getNoteById(
        widget.noteId,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _note = note;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _isLoading = false;
      });
      _showError(error);
    }
  }

  Future<void> _editNote() async {
    final NoteEntry? note = _note;
    if (note == null) {
      return;
    }
    final bool? changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => NotesScreen(
          dbService: widget.dbService,
          noteId: note.id,
          book: note.book,
          chapter: note.chapter,
        ),
      ),
    );
    if (changed == true) {
      _hasChanges = true;
      await _loadNote();
    }
  }

  Future<void> _deleteNote() async {
    final NoteEntry? note = _note;
    if (note == null) {
      return;
    }
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        icon: const Icon(Icons.delete_outline),
        title: Text(AppLocalizations.of(context)!.noteReaderDeleteTitle),
        content: Text(
          AppLocalizations.of(
            context,
          )!.noteReaderDeleteContent(note.displayTitle(context)),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(AppLocalizations.of(context)!.noteReaderCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(AppLocalizations.of(context)!.noteReaderDelete),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) {
      return;
    }
    try {
      await widget.dbService.deleteNote(note.id);
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(true);
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
    }
  }

  Future<void> _share() async {
    final NoteEntry? note = _note;
    if (note == null) {
      return;
    }
    try {
      await shareNotesAsPdf(context, <NoteEntry>[note]);
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
    }
  }

  void _showError(Object error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)!.noteReaderError(error.toString()),
        ),
      ),
    );
  }

  // Matches the note editor's typography (bodyLarge + same heading deltas) so
  // a note looks the same while writing and while reading.
  MarkdownStyleSheet _readerMarkdownStyle(ThemeData theme) {
    final TextStyle base =
        theme.textTheme.bodyLarge ?? const TextStyle(fontSize: 16);
    final double size = base.fontSize ?? 16;
    return MarkdownStyleSheet.fromTheme(theme).copyWith(
      p: base,
      h1: base.copyWith(fontWeight: FontWeight.w800, fontSize: size + 6),
      h2: base.copyWith(fontWeight: FontWeight.w800, fontSize: size + 4),
      h3: base.copyWith(fontWeight: FontWeight.w800, fontSize: size + 2),
      strong: base.copyWith(fontWeight: FontWeight.bold),
      em: base.copyWith(fontStyle: FontStyle.italic),
      listBullet: base,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final NoteEntry? note = _note;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) {
          Navigator.of(context).pop(_hasChanges);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(note?.displayTitle(context) ?? AppLocalizations.of(context)!.noteReaderTitle),
          actions: <Widget>[
            IconButton(
              onPressed: note == null ? null : _share,
              icon: const Icon(Icons.ios_share),
              tooltip: AppLocalizations.of(context)!.noteReaderShare,
            ),
            IconButton(
              onPressed: note == null ? null : _editNote,
              icon: const Icon(Icons.edit_outlined),
              tooltip: AppLocalizations.of(context)!.noteReaderEdit,
            ),
            IconButton(
              onPressed: note == null ? null : _deleteNote,
              icon: const Icon(Icons.delete_outline),
              tooltip: AppLocalizations.of(context)!.noteReaderDelete,
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : note == null
            ? Center(
                child: Text(AppLocalizations.of(context)!.noteReaderNoteGone),
              )
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            displayReference(context, note.book, note.chapter),
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context)!.noteReaderUpdatedAt(
                            DateFormat('dd/MM/yyyy à HH:mm').format(note.updatedAt),
                          ),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Card.filled(
                        margin: EdgeInsets.zero,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: SizedBox(
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: note.content.trim().isEmpty
                                  ? Text(
                                      AppLocalizations.of(context)!.noteReaderEmpty,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            color:
                                                colorScheme.onSurfaceVariant,
                                          ),
                                    )
                                  : MarkdownBody(
                                      data: note.content,
                                      selectable: true,
                                      styleSheet: _readerMarkdownStyle(theme),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
