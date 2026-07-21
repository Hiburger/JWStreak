import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../app_constants.dart';
import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';
import '../widgets/markdown_editing_controller.dart';

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

  bool get _isNew => widget.noteId == null;

  @override
  void initState() {
    super.initState();
    _loadNote();
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
      setState(
        () => _titleError = AppLocalizations.of(context)!.noteEditorTitleErrorHint,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.noteEditorTitleRequired),
        ),
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
          book: widget.book,
          chapter: widget.chapter,
          content: content,
        );
      } else {
        await widget.dbService.updateNote(
          id: noteId,
          title: title,
          content: content,
        );
      }
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.noteEditorSavedSnackbar),
        ),
      );
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          AppLocalizations.of(context)!.noteEditorErrorSnackbar(error.toString()),
        ),
      ),
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
        title: Text(
          _isNew
              ? AppLocalizations.of(context)!.noteEditorTitleNew
              : AppLocalizations.of(context)!.noteEditorTitleEdit,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Chip(
                avatar: Icon(
                  Icons.auto_stories_outlined,
                  size: 20,
                  color: colorScheme.onSecondaryContainer,
                ),
                label: Text(displayReference(context, widget.book, widget.chapter)),
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
      floatingActionButton: FloatingActionButton.extended(
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
        label: Text(AppLocalizations.of(context)!.noteEditorSaveButton),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
            child: TextField(
              controller: _titleController,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) {
                if (_titleError != null) {
                  setState(() => _titleError = null);
                }
              },
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.noteEditorTitleHint,
                hintStyle: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                errorText: _titleError,
              ),
            ),
          ),
          Divider(
            height: 1,
            indent: 20,
            endIndent: 20,
            color: colorScheme.outlineVariant,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 20, 0),
              child: TextField(
                controller: _contentController,
                expands: true,
                maxLines: null,
                minLines: null,
                textCapitalization: TextCapitalization.sentences,
                textAlignVertical: TextAlignVertical.top,
                inputFormatters: <TextInputFormatter>[
                  MarkdownListContinuationFormatter(),
                ],
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.noteEditorBodyHint,
                  hintStyle: theme.textTheme.bodyLarge?.copyWith(
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const _MarkdownHelpBanner(),
        ],
      ),
    );
  }
}

/// Collapsed-by-default Markdown syntax helper.
class _MarkdownHelpBanner extends StatelessWidget {
  const _MarkdownHelpBanner();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextStyle? tipStyle = theme.textTheme.bodySmall;

    return SafeArea(
      top: false,
      child: Padding(
        // The right inset keeps the banner (and its expand arrow) clear of
        // the floating "Enregistrer" button.
        padding: const EdgeInsets.fromLTRB(12, 0, 176, 8),
        child: Card.filled(
          margin: EdgeInsets.zero,
          color: colorScheme.surfaceContainerHigh,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            side: BorderSide(color: colorScheme.outlineVariant),
          ),
          child: Theme(
            data: theme.copyWith(
              dividerColor: Colors.transparent,
              // No ink flash when tapping the banner: the expand/collapse
              // motion is feedback enough.
              splashFactory: NoSplash.splashFactory,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 12),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              collapsedShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              leading: Icon(
                Icons.tips_and_updates_outlined,
                color: colorScheme.primary,
              ),
              title: Text(
                AppLocalizations.of(context)!.noteEditorMarkdownHelpTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.labelLarge,
              ),
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        AppLocalizations.of(context)!.noteEditorTipBold,
                        style: tipStyle,
                      ),
                      Text(
                        AppLocalizations.of(context)!.noteEditorTipItalic,
                        style: tipStyle,
                      ),
                      Text(
                        AppLocalizations.of(context)!.noteEditorTipStrikethrough,
                        style: tipStyle,
                      ),
                      Text(
                        AppLocalizations.of(context)!.noteEditorTipHeading,
                        style: tipStyle,
                      ),
                      Text(
                        AppLocalizations.of(context)!.noteEditorTipList,
                        style: tipStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
