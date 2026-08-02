import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_constants.dart';
import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';
import '../services/note_export.dart';
import '../widgets/message_dialog.dart';
import '../widgets/responsive_body.dart';
import 'note_reader_screen.dart';
import 'notes_screen.dart';

class NotesLibraryScreen extends StatefulWidget {
  const NotesLibraryScreen({required this.dbService, super.key});

  final LocalDbService dbService;

  @override
  State<NotesLibraryScreen> createState() => _NotesLibraryScreenState();
}

class _NotesLibraryScreenState extends State<NotesLibraryScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<NoteEntry> _notes = const <NoteEntry>[];
  final Set<int> _selectedIds = <int>{};
  bool _isLoading = true;
  String _query = '';
  bool _hasChanges = false;

  bool get _selectionMode => _selectedIds.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    try {
      final List<NoteEntry> notes = await widget.dbService.getAllNotes(
        query: _query,
      );
      if (!mounted) {
        return;
      }
      setState(() {
        _notes = notes;
        // Drop selections that no longer exist.
        _selectedIds.retainWhere(
          (int id) => notes.any((NoteEntry n) => n.id == id),
        );
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

  void _toggleSelect(NoteEntry note) {
    setState(() {
      if (!_selectedIds.add(note.id)) {
        _selectedIds.remove(note.id);
      }
    });
  }

  void _clearSelection() {
    setState(_selectedIds.clear);
  }

  List<NoteEntry> get _selectedNotes =>
      _notes.where((NoteEntry n) => _selectedIds.contains(n.id)).toList();

  Future<void> _openReader(NoteEntry note) async {
    final bool? changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) =>
            NoteReaderScreen(dbService: widget.dbService, noteId: note.id),
      ),
    );
    if (changed == true) {
      _hasChanges = true;
      await _loadNotes();
    }
  }

  Future<void> _createNote() async {
    final bool? changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => NotesScreen(dbService: widget.dbService),
      ),
    );
    if (changed == true) {
      _hasChanges = true;
      await _loadNotes();
    }
  }

  Future<bool> _confirmDeleteMessage(String message) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        icon: const Icon(Icons.delete_outline),
        title: Text(
          AppLocalizations.of(dialogContext)!.notesLibraryDeleteDialogTitle,
        ),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(AppLocalizations.of(dialogContext)!.notesLibraryCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
            ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(AppLocalizations.of(dialogContext)!.notesLibraryDelete),
          ),
        ],
      ),
    );
    return confirmed ?? false;
  }

  /// Confirms via dialog (same pattern as the multi-select delete below),
  /// then deletes. Returning `false` here tells the [Dismissible] to spring
  /// the card back into place instead of completing the swipe.
  Future<bool> _confirmSwipeDelete(NoteEntry note) async {
    final bool ok = await _confirmDeleteMessage(
      AppLocalizations.of(
        context,
      )!.notesLibraryDeleteConfirmSingular(note.displayTitle(context)),
    );
    if (!ok) {
      return false;
    }
    try {
      await widget.dbService.deleteNote(note.id);
      _hasChanges = true;
      return true;
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
      return false;
    }
  }

  /// Called by [Dismissible] once its swipe-away animation finishes, after
  /// [_confirmSwipeDelete] already persisted the deletion.
  void _removeNoteFromList(NoteEntry note) {
    if (!mounted) {
      return;
    }
    setState(() {
      _notes = _notes
          .where((NoteEntry entry) => entry.id != note.id)
          .toList(growable: false);
      _selectedIds.remove(note.id);
    });
  }

  Future<void> _deleteSelected() async {
    final List<NoteEntry> selected = _selectedNotes;
    if (selected.isEmpty) {
      return;
    }
    final int count = selected.length;
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final bool ok = await _confirmDeleteMessage(
      count == 1
          ? l10n.notesLibraryDeleteConfirmSingular(
              selected.first.displayTitle(context),
            )
          : l10n.notesLibraryDeleteConfirmPlural(count),
    );
    if (!ok) {
      return;
    }
    try {
      for (final NoteEntry note in selected) {
        await widget.dbService.deleteNote(note.id);
      }
      _hasChanges = true;
      _clearSelection();
      // No confirmation toast: the notes just visibly disappear from the
      // list, which is confirmation enough.
      await _loadNotes();
    } catch (error) {
      if (mounted) {
        _showError(error);
        await _loadNotes();
      }
    }
  }

  Future<void> _shareSelected() async {
    final List<NoteEntry> selected = _selectedNotes;
    if (selected.isEmpty) {
      return;
    }
    try {
      await shareNotesAsPdf(context, selected);
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
    }
  }

  /// Unlike [_shareSelected], fetches every note unfiltered — "export all"
  /// shouldn't silently only export whatever an active search happens to
  /// currently be showing.
  Future<void> _exportAll() async {
    try {
      final List<NoteEntry> allNotes = await widget.dbService.getAllNotes();
      if (!mounted || allNotes.isEmpty) {
        return;
      }
      await exportAllNotesAsZip(context, allNotes);
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
    }
  }

  void _onSearchChanged(String value) {
    setState(() {
      _query = value;
      _isLoading = true;
    });
    _loadNotes();
  }

  void _showError(Object error) {
    showMessageDialog(
      context,
      message: AppLocalizations.of(context)!.notesLibraryErrorMessage('$error'),
      isError: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          return;
        }
        if (_selectionMode) {
          _clearSelection();
        } else {
          Navigator.of(context).pop(_hasChanges);
        }
      },
      child: Scaffold(
        appBar: _selectionMode ? _buildSelectionAppBar() : _buildNormalAppBar(),
        floatingActionButton: _selectionMode
            ? null
            : FloatingActionButton.extended(
                onPressed: _createNote,
                icon: const Icon(Icons.add),
                label: Text(AppLocalizations.of(context)!.notesLibraryNewNote),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: colorScheme.primaryContainer,
                foregroundColor: colorScheme.onPrimaryContainer,
                elevation: 0,
              ),
        body: ResponsiveBody(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: <Widget>[
                SearchBar(
                  controller: _searchController,
                  hintText: AppLocalizations.of(
                    context,
                  )!.notesLibrarySearchHint,
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: Icon(Icons.search),
                  ),
                  onChanged: _onSearchChanged,
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  backgroundColor: WidgetStatePropertyAll(
                    colorScheme.surfaceContainerHighest,
                  ),
                  shadowColor: const WidgetStatePropertyAll(Colors.transparent),
                  surfaceTintColor: WidgetStatePropertyAll(
                    colorScheme.surfaceTint,
                  ),
                ),
                if (!_selectionMode &&
                    !_isLoading &&
                    _notes.isNotEmpty) ...<Widget>[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.tonalIcon(
                      onPressed: _exportAll,
                      icon: const Icon(Icons.ios_share_rounded, size: 20),
                      label: Text(
                        AppLocalizations.of(
                          context,
                        )!.notesLibraryExportAllTooltip,
                      ),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _notes.isEmpty
                        ? _EmptyNotesState(
                            isSearching: _query.trim().isNotEmpty,
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.only(bottom: 96),
                            itemCount: _notes.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 8),
                            itemBuilder: (_, int index) {
                              final NoteEntry note = _notes[index];
                              return _NoteCard(
                                note: note,
                                selectionMode: _selectionMode,
                                selected: _selectedIds.contains(note.id),
                                onTap: () {
                                  if (_selectionMode) {
                                    _toggleSelect(note);
                                  } else {
                                    _openReader(note);
                                  }
                                },
                                onLongPress: () => _toggleSelect(note),
                                confirmDismiss: () => _confirmSwipeDelete(note),
                                onDismissed: () => _removeNoteFromList(note),
                              );
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildNormalAppBar() {
    return AppBar(title: Text(AppLocalizations.of(context)!.notesLibraryTitle));
  }

  AppBar _buildSelectionAppBar() {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final int count = _selectedIds.length;
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        tooltip: l10n.notesLibraryCancelSelectionTooltip,
        onPressed: _clearSelection,
      ),
      title: Text(
        count == 1
            ? l10n.notesLibrarySelectedCountSingular(count)
            : l10n.notesLibrarySelectedCountPlural(count),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.ios_share),
          tooltip: l10n.notesLibraryShareTooltip,
          onPressed: _shareSelected,
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline),
          tooltip: l10n.notesLibraryDeleteTooltip,
          onPressed: _deleteSelected,
        ),
      ],
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({
    required this.note,
    required this.selectionMode,
    required this.selected,
    required this.onTap,
    required this.onLongPress,
    required this.confirmDismiss,
    required this.onDismissed,
  });

  final NoteEntry note;
  final bool selectionMode;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Future<bool> Function() confirmDismiss;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final String preview = _plainPreview(note.content);

    final Widget card = Card.filled(
      margin: EdgeInsets.zero,
      color: selected ? colorScheme.secondaryContainer : null,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  if (selectionMode) ...<Widget>[
                    Icon(
                      selected
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: selected
                          ? colorScheme.primary
                          : colorScheme.onSurfaceVariant,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Text(
                      note.displayTitle(context),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  if (!selectionMode) ...<Widget>[
                    const SizedBox(width: 8),
                    Icon(
                      Icons.chevron_right,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ],
                ],
              ),
              if (preview.isNotEmpty) ...<Widget>[
                const SizedBox(height: 6),
                Text(
                  preview,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    height: 1.35,
                  ),
                ),
              ],
              const SizedBox(height: 14),
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      displayReference(context, note.book, note.chapter),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSecondaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      formatRelativeDate(context, note.updatedAt),
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    // Swipe-to-delete only outside selection mode, to avoid gesture conflicts.
    if (selectionMode) {
      return card;
    }
    return Dismissible(
      key: ValueKey<int>(note.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => confirmDismiss(),
      onDismissed: (_) => onDismissed(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.delete_outline, color: colorScheme.onErrorContainer),
      ),
      child: card,
    );
  }

  /// Strips Markdown markers for a clean, readable card preview.
  String _plainPreview(String content) {
    return content
        .replaceAll(RegExp(r'^#{1,6}\s*', multiLine: true), '')
        .replaceAll(RegExp(r'^\s*[-*>]\s+', multiLine: true), '')
        .replaceAll(RegExp(r'\*\*|\*|~~|`'), '')
        .trim();
  }
}

/// "il y a 5 min", "il y a 3 h", "hier", else short date.
String formatRelativeDate(BuildContext context, DateTime dateTime) {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  final DateTime now = DateTime.now();
  final Duration difference = now.difference(dateTime);

  if (difference.inMinutes < 1) {
    return l10n.notesLibraryJustNow;
  }
  if (difference.inMinutes < 60) {
    return l10n.notesLibraryMinutesAgo(difference.inMinutes);
  }
  if (difference.inHours < 24 && now.day == dateTime.day) {
    return l10n.notesLibraryHoursAgo(difference.inHours);
  }
  final DateTime today = DateTime(now.year, now.month, now.day);
  final DateTime day = DateTime(dateTime.year, dateTime.month, dateTime.day);
  if (today.difference(day).inDays == 1) {
    return l10n.notesLibraryYesterday;
  }
  return DateFormat('dd/MM/yyyy').format(dateTime);
}

class _EmptyNotesState extends StatelessWidget {
  const _EmptyNotesState({required this.isSearching});

  final bool isSearching;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isSearching ? Icons.search_off : Icons.edit_note_outlined,
                size: 44,
                color: colorScheme.onSecondaryContainer,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              isSearching
                  ? AppLocalizations.of(context)!.notesLibraryEmptyNoResults
                  : AppLocalizations.of(context)!.notesLibraryEmptyTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              isSearching
                  ? AppLocalizations.of(context)!.notesLibraryEmptySearchHint
                  : AppLocalizations.of(context)!.notesLibraryEmptySubtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
