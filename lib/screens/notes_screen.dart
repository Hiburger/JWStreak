import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_constants.dart';
import '../bible_data.dart';
import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';
import '../widgets/circular_back_button.dart';
import '../widgets/markdown_editing_controller.dart';
import '../widgets/message_dialog.dart';
import '../widgets/picker_field.dart';
import '../widgets/responsive_body.dart';

/// Note editor. With [noteId] it edits an existing note; without it,
/// it creates a new note linked to [book]/[chapter].
class NotesScreen extends StatefulWidget {
  const NotesScreen({
    required this.dbService,
    this.noteId,
    this.book = kDefaultBook,
    this.chapter = kDefaultChapter,
    super.key,
  });

  final LocalDbService dbService;
  final int? noteId;
  final String book;
  final int chapter;

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final TextEditingController _titleController = TextEditingController();
  final MarkdownEditingController _contentController =
      MarkdownEditingController();

  bool _isLoading = true;
  bool _isSaving = false;
  String? _titleError;

  /// Which chapter this note hangs off. Starts at whatever the caller passed
  /// (the reader's current chapter for a new note, the note's own reference
  /// when editing) and can be re-pointed from the app bar chip.
  late String _book = widget.book;
  late int _chapter = widget.chapter;

  bool get _isNew => widget.noteId == null;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  Future<void> _pickChapter() async {
    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext sheetContext) => _ChapterLinkSheet(
        book: kBibleBooks.firstWhere(
          (BibleBook b) => b.id == _book,
          orElse: () => kBibleBooks.first,
        ),
        chapter: _chapter,
        onChanged: (String book, int chapter) => setState(() {
          _book = book;
          _chapter = chapter;
        }),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Future<void> _loadNote() async {
    final int? noteId = widget.noteId;
    if (noteId == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      final NoteEntry? note = await widget.dbService.getNoteById(noteId);
      if (!mounted) {
        return;
      }
      setState(() {
        _titleController.text = note?.title ?? '';
        _contentController.text = note?.content ?? '';
        if (note != null) {
          _book = note.book;
          _chapter = note.chapter;
        }
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

  Future<void> _save() async {
    final String title = _titleController.text.trim();
    final String content = _contentController.text.trim();

    if (_isNew && title.isEmpty && content.isEmpty) {
      // Nothing to save; leave without creating an empty note.
      Navigator.of(context).pop(false);
      return;
    }

    if (title.isEmpty) {
      // The inline errorText below already surfaces this; no need to also
      // interrupt with a dialog.
      setState(
        () => _titleError = AppLocalizations.of(
          context,
        )!.noteEditorTitleErrorHint,
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });
    try {
      final int? noteId = widget.noteId;
      if (noteId == null) {
        await widget.dbService.createNote(
          title: title,
          book: _book,
          chapter: _chapter,
          content: content,
        );
      } else {
        await widget.dbService.updateNote(
          id: noteId,
          title: title,
          content: content,
          book: _book,
          chapter: _chapter,
        );
      }
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop(true);
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _showError(Object error) {
    showMessageDialog(
      context,
      message: AppLocalizations.of(
        context,
      )!.noteEditorErrorSnackbar(error.toString()),
      isError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        // Flat bar: no Material 'scrolled under' tint or shadow when
        // content passes beneath it.
        scrolledUnderElevation: 0,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: theme.scaffoldBackgroundColor,
        leading: const CircularBackButton(),
        title: Text(
          _isNew
              ? AppLocalizations.of(context)!.noteEditorTitleNew
              : AppLocalizations.of(context)!.noteEditorTitleEdit,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              // Tappable: re-points the note at another chapter. The chevron
              // is what tells the reader it opens rather than just labels.
              child: ActionChip(
                onPressed: _pickChapter,
                tooltip: AppLocalizations.of(context)!.noteEditorLinkedChapter,
                avatar: Icon(
                  Icons.auto_stories_outlined,
                  size: 20,
                  color: colorScheme.onSecondaryContainer,
                ),
                label: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(displayReference(context, _book, _chapter)),
                    const SizedBox(width: 2),
                    Icon(
                      Icons.expand_more,
                      size: 18,
                      color: colorScheme.onSecondaryContainer,
                    ),
                  ],
                ),
                labelStyle: theme.textTheme.titleSmall?.copyWith(
                  color: colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.w600,
                ),
                labelPadding: const EdgeInsets.symmetric(horizontal: 4),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                backgroundColor: colorScheme.secondaryContainer,
                side: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
      body: ResponsiveBody(
        child: Column(
          children: <Widget>[
            // The title is a text zone too, so it gets the same filled card
            // as the body rather than a bare line above a divider.
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Card.filled(
                margin: EdgeInsets.zero,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(28)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                  child: TextField(
                    controller: _titleController,
                    textCapitalization: TextCapitalization.sentences,
                    onChanged: (_) {
                      if (_titleError != null) {
                        setState(() => _titleError = null);
                      }
                    },
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(
                        context,
                      )!.noteEditorTitleHint,
                      hintStyle: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurfaceVariant.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      errorText: _titleError,
                    ),
                  ),
                ),
              ),
            ),
            // Sits outside the scroll view below, so the gap between title
            // and body stays put instead of scrolling away and letting the
            // two cards touch.
            const SizedBox(height: 12),
            // The writing area starts a few lines tall and grows with the
            // text rather than filling the screen from the outset, so a
            // one-line note doesn't open onto a wall of empty box. Once it
            // reaches the available height the scrolling happens *inside*
            // the card, so its rounded corners stay visible instead of
            // sliding out under the app bar.
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card.filled(
                    margin: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(28)),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: _contentController,
                        minLines: 6,
                        maxLines: null,
                        textCapitalization: TextCapitalization.sentences,
                        textAlignVertical: TextAlignVertical.top,
                        inputFormatters: <TextInputFormatter>[
                          MarkdownListContinuationFormatter(),
                        ],
                        style: theme.textTheme.bodyLarge,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(
                            context,
                          )!.noteEditorBodyHint,
                          hintStyle: theme.textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onSurfaceVariant.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 56,
                      child: FilledButton.icon(
                        onPressed: _isSaving ? null : _save,
                        icon: _isSaving
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  color: colorScheme.onPrimaryContainer,
                                ),
                              )
                            : const Icon(Icons.check),
                        label: Text(
                          AppLocalizations.of(context)!.noteEditorSaveButton,
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: colorScheme.primaryContainer,
                          foregroundColor: colorScheme.onPrimaryContainer,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Book + chapter pickers for re-pointing a note, using the same
/// [PickerField] pair the reading-start onboarding asks its question with.
class _ChapterLinkSheet extends StatefulWidget {
  const _ChapterLinkSheet({
    required this.book,
    required this.chapter,
    required this.onChanged,
  });

  final BibleBook book;
  final int chapter;
  final void Function(String book, int chapter) onChanged;

  @override
  State<_ChapterLinkSheet> createState() => _ChapterLinkSheetState();
}

class _ChapterLinkSheetState extends State<_ChapterLinkSheet> {
  late BibleBook _book = widget.book;
  late int _chapter = widget.chapter.clamp(1, widget.book.chapters);

  void _setBook(BibleBook book) {
    setState(() {
      _book = book;
      // Chapter counts vary wildly (Psalms 150, Obadiah 1), so a chapter
      // that was valid for the old book may not exist in the new one.
      _chapter = _chapter.clamp(1, book.chapters);
    });
    widget.onChanged(_book.id, _chapter);
  }

  void _setChapter(int chapter) {
    setState(() => _chapter = chapter);
    widget.onChanged(_book.id, _chapter);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppLocalizations.of(context)!.noteEditorLinkedChapter,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: PickerField<String>(
                    currentLabel: localizedBookName(context, _book),
                    selectedValue: _book.id,
                    entries: <PickerEntry<String>>[
                      for (final BibleBook b in kBibleBooks)
                        PickerEntry<String>(
                          value: b.id,
                          label: localizedBookName(context, b),
                        ),
                    ],
                    onChanged: (String id) => _setBook(
                      kBibleBooks.firstWhere((BibleBook b) => b.id == id),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: PickerField<int>(
                    currentLabel: '$_chapter',
                    selectedValue: _chapter,
                    entries: <PickerEntry<int>>[
                      for (int c = 1; c <= _book.chapters; c++)
                        PickerEntry<int>(value: c, label: '$c'),
                    ],
                    onChanged: _setChapter,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
