import 'package:flutter/material.dart';

/// One entry in a [PickerField]'s list.
class PickerEntry<T> {
  const PickerEntry({required this.value, required this.label});

  final T value;
  final String label;
}

/// A single-choice field styled to match the card it sits in: flat outline,
/// tap to open, tap an entry to pick.
///
/// Opens a [PickerSheet] rather than a dropdown menu. [DropdownMenu] (tried
/// first) draws its popup as a plain, non-virtualized `SingleChildScrollView`
/// internally — every entry gets built and kept alive whether it's on screen
/// or not. Fine for a handful of options, but the book list is 66 entries
/// and some chapter lists run past 100 (Psalms is 150), and scrolling all of
/// them live is what made the previous version stutter. A bottom sheet over
/// a real `ListView.builder` only ever builds what's actually visible.
class PickerField<T> extends StatelessWidget {
  const PickerField({
    required this.currentLabel,
    required this.selectedValue,
    required this.entries,
    required this.onChanged,
    super.key,
  });

  final String currentLabel;
  final T selectedValue;
  final List<PickerEntry<T>> entries;
  final ValueChanged<T> onChanged;

  Future<void> _open(BuildContext context) async {
    final T? picked = await showModalBottomSheet<T>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (BuildContext sheetContext) =>
          PickerSheet<T>(entries: entries, selectedValue: selectedValue),
    );
    if (picked != null) {
      onChanged(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return Material(
      color: cs.surface,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: cs.outlineVariant),
      ),
      child: InkWell(
        onTap: () => _open(context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  currentLabel,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Icon(Icons.expand_more_rounded, color: cs.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

/// The virtualized list a [PickerField] opens. A plain sheet rather than
/// something more elaborate on purpose: this is a two-tap choice from a
/// flat list, not a search experience.
/// Roughly 1cm at Flutter's baseline 96 logical-pixels-per-inch.
const double _kListBottomMargin = 38.0;

class PickerSheet<T> extends StatelessWidget {
  const PickerSheet({
    required this.entries,
    required this.selectedValue,
    super.key,
  });

  final List<PickerEntry<T>> entries;
  final T selectedValue;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;

    return SafeArea(
      top: false,
      child: ConstrainedBox(
        // Capped rather than left to grow with the list — at 66+ entries
        // the sheet would otherwise push toward covering the whole screen.
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        child: ListView.separated(
          // ~1cm of breathing room below the last row — flush against the
          // sheet's bottom edge (or the drag handle's mirror image) looked
          // cramped, on both the short lists and the capped-and-scrolled
          // long ones.
          padding: const EdgeInsets.only(bottom: _kListBottomMargin),
          // Without this a short list (2 John has one chapter) still fills
          // the whole capped height above, leaving a mostly-empty sheet —
          // shrinkWrap sizes it to its actual content instead, up to the
          // maxHeight this sits inside, which is where the cap still bites
          // for the long lists it's there for (66 books, Psalms' 150).
          shrinkWrap: true,
          itemCount: entries.length,
          separatorBuilder: (BuildContext context, int index) =>
              Divider(height: 1, color: cs.outlineVariant),
          itemBuilder: (BuildContext context, int index) {
            final PickerEntry<T> entry = entries[index];
            final bool selected = entry.value == selectedValue;
            return ListTile(
              title: Text(entry.label),
              trailing: selected
                  ? Icon(Icons.check_rounded, color: cs.primary)
                  : null,
              selected: selected,
              selectedTileColor: cs.primaryContainer.withValues(alpha: 0.35),
              onTap: () => Navigator.of(context).pop(entry.value),
            );
          },
        ),
      ),
    );
  }
}
