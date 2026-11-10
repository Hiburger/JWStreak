import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_constants.dart';
import '../bible_data.dart';
import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';
import '../services/note_export.dart';
import '../widgets/circular_back_button.dart';
import '../widgets/message_dialog.dart';
import '../widgets/picker_field.dart';
import '../widgets/responsive_body.dart';
import 'note_reader_screen.dart';
import 'notes_screen.dart';

class NotesLibraryScreen extends StatefulWidget {
  const NotesLibraryScreen({
    required this.dbService,
    this.book = kDefaultBook,
    this.chapter = kDefaultChapter,
    super.key,
  });

  final LocalDbService dbService;

  /// Where a note created from this screen's own "+ New note" button gets
  /// linked to — passed in by the caller (today's chapter, ideally) rather
  /// than left to fall back to Genesis 1 for every single note.
  final String book;
  final int chapter;

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

  String? _bookFilter;
  NoteCreatedFilter _createdFilter = NoteCreatedFilter.all;

  NoteSortOrder _sort = NoteSortOrder.manual;

  bool _inSelectionMode = false;
  bool get _selectionMode => _inSelectionMode;

  bool get _hasActiveFilters =>
      _bookFilter != null || _createdFilter != NoteCreatedFilter.all;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // The view (sort + filters) is persisted so that a reordered library is still in that order when the reader comes back
    final view = await widget.dbService.getNotesViewState();
    if (!mounted) {
      return;
    }
    setState(() {
      _sort = view.sort;
      _bookFilter = view.book;
      _createdFilter = view.created;
    });
    await _loadNotes();
  }

  Future<void> _persistViewState() => widget.dbService.saveNotesViewState(
    sort: _sort,
    book: _bookFilter,
    created: _createdFilter,
  );

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNotes() async {
    try {
      final List<NoteEntry> notes = await widget.dbService.getAllNotes(
        query: _query,
        book: _bookFilter,
        createdFilter: _createdFilter,
        sort: _sort,
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

  void _enterSelectionMode() {
    setState(() => _inSelectionMode = true);
  }

  void _toggleSelect(NoteEntry note) {
    setState(() {
      if (!_selectedIds.add(note.id)) {
        _selectedIds.remove(note.id);
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _selectedIds.clear();
      _inSelectionMode = false;
    });
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
        builder: (_) => NotesScreen(
          dbService: widget.dbService,
          book: widget.book,
          chapter: widget.chapter,
        ),
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

  void _onSearchChanged(String value) {
    setState(() {
      _query = value;
      _isLoading = true;
    });
    _loadNotes();
  }

  void _reloadWithFilters() {
    setState(() {
      _isLoading = true;
    });
    _persistViewState();
    _loadNotes();
  }

  // Sentinel for the book sheet's "All books" row: book ids are never empty,
  // so popping '' can't be confused with dismissing the sheet (null).
  static const String _allBooksValue = '';

  Future<void> _pickBook() async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final List<String> bookIds = await widget.dbService.getNoteBookIds();
    if (!mounted) {
      return;
    }
    final String? picked = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext sheetContext) => PickerSheet<String>(
        selectedValue: _bookFilter ?? _allBooksValue,
        entries: <PickerEntry<String>>[
          PickerEntry<String>(
            value: _allBooksValue,
            label: l10n.notesLibraryFilterAllBooks,
          ),
          for (final String id in bookIds)
            PickerEntry<String>(
              value: id,
              // A restored backup can hold a book id kBibleBooks doesn't
              // know; show it raw rather than crashing the sheet.
              label: _bookLabel(context, id),
            ),
        ],
      ),
    );
    if (picked == null) {
      return;
    }
    final String? book = picked == _allBooksValue ? null : picked;
    if (book != _bookFilter) {
      setState(() => _bookFilter = book);
      _reloadWithFilters();
    }
  }

  Future<void> _pickCreatedFilter() async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final NoteCreatedFilter?
    picked = await showModalBottomSheet<NoteCreatedFilter>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext sheetContext) => PickerSheet<NoteCreatedFilter>(
        selectedValue: _createdFilter,
        entries: <PickerEntry<NoteCreatedFilter>>[
          for (final MapEntry<NoteCreatedFilter, String> e
              in <NoteCreatedFilter, String>{
                NoteCreatedFilter.all: l10n.notesLibraryFilterAllTime,
                NoteCreatedFilter.today: l10n.notesLibraryFilterToday,
                NoteCreatedFilter.thisWeek: l10n.notesLibraryFilterThisWeek,
                NoteCreatedFilter.thisMonth: l10n.notesLibraryFilterThisMonth,
                NoteCreatedFilter.earlier: l10n.notesLibraryFilterEarlier,
              }.entries)
            PickerEntry<NoteCreatedFilter>(value: e.key, label: e.value),
        ],
      ),
    );
    if (picked != null && picked != _createdFilter) {
      setState(() => _createdFilter = picked);
      _reloadWithFilters();
    }
  }

  Future<void> _pickSort() async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final NoteSortOrder? picked = await showModalBottomSheet<NoteSortOrder>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext sheetContext) => PickerSheet<NoteSortOrder>(
        selectedValue: _sort,
        entries: <PickerEntry<NoteSortOrder>>[
          for (final MapEntry<NoteSortOrder, String> e
              in <NoteSortOrder, String>{
                NoteSortOrder.recentlyUpdated:
                    l10n.notesLibrarySortRecentlyUpdated,
                NoteSortOrder.recentlyCreated:
                    l10n.notesLibrarySortRecentlyCreated,
                NoteSortOrder.titleAZ: l10n.notesLibrarySortTitleAZ,
                NoteSortOrder.bibleOrder: l10n.notesLibrarySortBibleOrder,
              }.entries)
            PickerEntry<NoteSortOrder>(value: e.key, label: e.value),
        ],
      ),
    );
    if (picked != null && picked != _sort) {
      setState(() => _sort = picked);
      _reloadWithFilters();
    }
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
                const SizedBox(height: 8),
                _buildFilterRow(),
                const SizedBox(height: 12),
                Expanded(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : _notes.isEmpty
                        ? _EmptyNotesState(
                            isSearching:
                                _query.trim().isNotEmpty || _hasActiveFilters,
                          )
                        : _buildNotesList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotesList() {
    if (_selectionMode) {
      return ListView.separated(
        padding: const EdgeInsets.only(top: 8, bottom: 96),
        itemCount: _notes.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (_, int index) => _buildNoteCard(_notes[index]),
      );
    }

    return ClipRect(
      child: Overlay(
        initialEntries: <OverlayEntry>[
          OverlayEntry(
            builder: (_) => ReorderableListView(
              padding: const EdgeInsets.only(top: 8, bottom: 96),
              buildDefaultDragHandles: false,
              onReorderItem: _onReorder,
              // Default decorator paints a Material box behind the dragged
              // card, which reads as a white cutout — a slight scale gives
              // the same feedback without it.
              proxyDecorator:
                  (Widget child, int index, Animation<double> animation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (BuildContext context, Widget? child) =>
                          Transform.scale(
                            scale: 1 + 0.02 * animation.value,
                            child: child,
                          ),
                      child: child,
                    );
                  },
              children: <Widget>[
                for (int index = 0; index < _notes.length; index++)
                  Padding(
                    key: ValueKey<int>(_notes[index].id),
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ReorderableDelayedDragStartListener(
                      index: index,
                      child: _buildNoteCard(_notes[index]),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteCard(NoteEntry note) {
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
      confirmDismiss: () => _confirmSwipeDelete(note),
      onDismissed: () => _removeNoteFromList(note),
    );
  }

  Future<void> _onReorder(int oldIndex, int newIndex) async {
    final int movedId = _notes[oldIndex].id;
    final (:List<NoteEntry> notes, :double position) = computeReorder(
      _notes,
      oldIndex,
      newIndex,
    );
    setState(() {
      _notes = notes;
      // A drag means the reader wants their own order, so the sort follows
      // the drag instead of snapping back on the next reload.
      _sort = NoteSortOrder.manual;
      _hasChanges = true;
    });
    _persistViewState();
    try {
      await widget.dbService.setNotePosition(movedId, position);
    } catch (error) {
      if (mounted) {
        _showError(error);
      }
    }
  }

  AppBar _buildNormalAppBar() {
    return AppBar(
      leading: const CircularBackButton(),
      title: Text(AppLocalizations.of(context)!.notesLibraryTitle),
      actions: <Widget>[
        IconButton(
          key: const ValueKey<String>('notes-library-select'),
          icon: const Icon(Icons.checklist_rounded),
          tooltip: AppLocalizations.of(context)!.notesLibrarySelectTooltip,
          onPressed: _enterSelectionMode,
        ),
      ],
    );
  }

  static String _bookLabel(BuildContext context, String bookId) {
    final BibleBook? book = bibleBookById(bookId);
    return book == null ? bookId : localizedBookName(context, book);
  }

  Widget _buildFilterRow() {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final String? bookLabel = _bookFilter == null
        ? null
        : _bookLabel(context, _bookFilter!);
    return Align(
      alignment: Alignment.centerLeft,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            _FilterChip(
              icon: Icons.menu_book_rounded,
              label: l10n.notesLibraryFilterBook,
              value: bookLabel,
              onTap: _pickBook,
            ),
            const SizedBox(width: 8),
            _FilterChip(
              icon: Icons.calendar_month_rounded,
              label: l10n.notesLibraryFilterCreated,
              value: _createdFilter == NoteCreatedFilter.all
                  ? null
                  : <NoteCreatedFilter, String>{
                      NoteCreatedFilter.today: l10n.notesLibraryFilterToday,
                      NoteCreatedFilter.thisWeek:
                          l10n.notesLibraryFilterThisWeek,
                      NoteCreatedFilter.thisMonth:
                          l10n.notesLibraryFilterThisMonth,
                      NoteCreatedFilter.earlier: l10n.notesLibraryFilterEarlier,
                    }[_createdFilter],
              onTap: _pickCreatedFilter,
            ),
            const SizedBox(width: 8),
            _FilterChip(
              icon: Icons.sort_rounded,
              label: l10n.notesLibraryFilterSort,
              value: _sort == NoteSortOrder.manual
                  ? null
                  : <NoteSortOrder, String>{
                      NoteSortOrder.recentlyUpdated:
                          l10n.notesLibrarySortRecentlyUpdated,
                      NoteSortOrder.recentlyCreated:
                          l10n.notesLibrarySortRecentlyCreated,
                      NoteSortOrder.titleAZ: l10n.notesLibrarySortTitleAZ,
                      NoteSortOrder.bibleOrder: l10n.notesLibrarySortBibleOrder,
                    }[_sort],
              onTap: _pickSort,
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildSelectionAppBar() {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final int count = _selectedIds.length;
    return AppBar(
      leading: IconButton(
        key: const ValueKey<String>('notes-library-close'),
        style: circularIconButtonStyle(context),
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
        // Disabled at zero selected: with nothing to act on the buttons
        // shouldn't even play their tap animation.
        IconButton(
          key: const ValueKey<String>('notes-library-share'),
          icon: const Icon(Icons.ios_share),
          tooltip: l10n.notesLibraryShareTooltip,
          onPressed: _selectedIds.isEmpty ? null : _shareSelected,
        ),
        IconButton(
          key: const ValueKey<String>('notes-library-delete'),
          icon: const Icon(Icons.delete_outline),
          tooltip: l10n.notesLibraryDeleteTooltip,
          onPressed: _selectedIds.isEmpty ? null : _deleteSelected,
        ),
      ],
    );
  }
}

/// One dropdown chip of the filter row. Shows just its category at the
/// default ("Book"); once a non-default value is picked it renders filled
/// and reads "Book: Genesis" so active filters stay visible at a glance.
class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final bool active = value != null;
    return ActionChip(
      avatar: Icon(
        icon,
        size: 18,
        color: active ? cs.onPrimaryContainer : cs.onSurfaceVariant,
      ),
      label: Text(active ? '$label: $value' : label),
      labelStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
        color: active ? cs.onPrimaryContainer : cs.onSurfaceVariant,
        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
      ),
      backgroundColor: active
          ? cs.primaryContainer
          : cs.surfaceContainerHighest,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: onTap,
    );
  }
}

class _NoteCard extends StatelessWidget {
  const _NoteCard({
    required this.note,
    required this.selectionMode,
    required this.selected,
    required this.onTap,
    required this.confirmDismiss,
    required this.onDismissed,
  });

  final NoteEntry note;
  final bool selectionMode;
  final bool selected;
  final VoidCallback onTap;
  final Future<bool> Function() confirmDismiss;
  final VoidCallback onDismissed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final String preview = plainNotePreview(note.content);

    final Widget card = Card.filled(
      margin: EdgeInsets.zero,
      color: selected ? colorScheme.secondaryContainer : null,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
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
}

({List<NoteEntry> notes, double position}) computeReorder(
  List<NoteEntry> notes,
  int oldIndex,
  int newIndex,
) {
  final List<NoteEntry> updated = List<NoteEntry>.of(notes);
  final NoteEntry moved = updated.removeAt(oldIndex);
  updated.insert(newIndex, moved);
  final double prev = newIndex > 0
      ? updated[newIndex - 1].position
      : double.negativeInfinity;
  final double next = newIndex < updated.length - 1
      ? updated[newIndex + 1].position
      : double.infinity;
  final double position = prev == double.negativeInfinity
      ? (next == double.infinity ? 0 : next - 1024)
      : (next == double.infinity ? prev + 1024 : (prev + next) / 2);
  return (notes: updated, position: position);
}

/// Strips Markdown markers for a clean, readable card preview.
///
/// The whitespace classes are deliberately `[ \t]` and not `\s`: `\s` also
/// matches newlines, so stripping a list marker used to swallow the blank
/// line before it and the preview came out with lines missing.
String plainNotePreview(String content) {
  return content
      .replaceAll(RegExp(r'^#{1,6}[ \t]*', multiLine: true), '')
      .replaceAll(RegExp(r'^[ \t]*[-*>][ \t]+', multiLine: true), '')
      .replaceAll(RegExp(r'\*\*|\*|~~|`'), '')
      .trim();
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
