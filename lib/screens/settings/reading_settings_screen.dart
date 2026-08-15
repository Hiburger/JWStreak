import 'package:flutter/material.dart';

import '../../app_constants.dart';
import '../../bible_data.dart';
import '../../l10n/app_localizations.dart';
import '../../reading_plan.dart';
import '../../services/deep_link_service.dart';
import '../../services/local_db_service.dart';
import '../../widgets/picker_field.dart';
import '../reading_plan_onboarding_screen.dart';
import 'settings_common.dart';

/// Everything about *what* gets read next and *where* it opens: the order
/// chapters are handed out in, where the reader is picking up from, and
/// which app a chapter opens in.
///
/// "Open the Bible with" used to sit under Appearance, which put a reading
/// decision in with the color pickers purely because both are switches.
class ReadingSettingsScreen extends StatefulWidget {
  const ReadingSettingsScreen({super.key});

  @override
  State<ReadingSettingsScreen> createState() => _ReadingSettingsScreenState();
}

class _ReadingSettingsScreenState extends State<ReadingSettingsScreen> {
  final DeepLinkService _deepLinkService = DeepLinkService();

  ReadingPlan _readingPlan = ReadingPlan.canonical;
  String? _planStartKey;

  // Bible target: true = open chapters in the JW Library app (default),
  // false = open on jw.org in a browser.
  bool _openInJwLibrary = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final ReadingPlan readingPlan = await LocalDbService().getReadingPlan();
      final String? planStartKey = await LocalDbService().getPlanStartKey();
      final bool openOnWeb = await LocalDbService().getOpenBibleOnWeb();
      // The stored preference just says what was picked last time — it
      // doesn't know if JW Library got uninstalled since. Re-check now
      // rather than showing a toggle that's on for an app that's gone.
      bool openInJwLibrary = !openOnWeb;
      if (openInJwLibrary && !await _deepLinkService.isJwLibraryInstalled()) {
        openInJwLibrary = false;
        await LocalDbService().saveOpenBibleOnWeb(true);
      }
      if (!mounted) {
        return;
      }
      setState(() {
        _readingPlan = readingPlan;
        _planStartKey = planStartKey;
        _openInJwLibrary = openInJwLibrary;
      });
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
    }
  }

  /// Switching orders keeps every chapter already marked read — the plan
  /// only decides what to hand out next, so a reader trying another order
  /// doesn't lose their progress and can switch back freely.
  Future<void> _changeReadingPlan(ReadingPlan plan) async {
    setState(() {
      _readingPlan = plan;
    });
    try {
      await LocalDbService().saveReadingPlan(plan);
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
    }
  }

  /// The stored resume point as a (book, chapter) pair, or null if there
  /// isn't one — shared by the label and by the editor sheet's starting
  /// values, so the two can never disagree about what's currently stored.
  (BibleBook, int)? _parsedStartPoint() {
    final String? key = _planStartKey;
    if (key == null) {
      return null;
    }
    final int sep = key.lastIndexOf('|');
    if (sep <= 0) {
      return null;
    }
    final String bookId = key.substring(0, sep);
    final int? chapter = int.tryParse(key.substring(sep + 1));
    if (chapter == null) {
      return null;
    }
    for (final BibleBook book in kBibleBooks) {
      if (book.id == bookId) {
        return (book, chapter);
      }
    }
    return null;
  }

  /// The stored resume point spelled out, or a note that there isn't one.
  String _resumePointLabel(BuildContext context) {
    final (BibleBook, int)? point = _parsedStartPoint();
    if (point == null) {
      return AppLocalizations.of(context)!.settingsResumePointNone;
    }
    final (BibleBook book, int chapter) = point;
    return '${localizedBookName(context, book)} $chapter';
  }

  /// Opens the sheet used both to change the resume point and to clear it —
  /// one place for both since they're really the same decision ("where does
  /// the plan start from?"), not two separate features.
  Future<void> _openResumePointEditor() async {
    final (BibleBook, int)? point = _parsedStartPoint();
    final _ResumePointChoice? result =
        await showModalBottomSheet<_ResumePointChoice>(
          context: context,
          showDragHandle: true,
          isScrollControlled: true,
          builder: (BuildContext sheetContext) => _ResumePointSheet(
            initialBook: point?.$1 ?? kBibleBooks.first,
            initialChapter: point?.$2 ?? 1,
            hasResumePoint: point != null,
          ),
        );
    if (result == null) {
      return;
    }
    final String? newKey = result.cleared ? null : result.key;
    setState(() {
      _planStartKey = newKey;
    });
    try {
      await LocalDbService().savePlanStartKey(newKey);
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
    }
  }

  /// Switches the Bible-opening target. When the user turns the switch toward
  /// JW Library but the app isn't installed, we don't apply the change and
  /// instead offer a link to install it.
  Future<void> _changeBibleTarget(bool wantJwLibrary) async {
    if (wantJwLibrary && !await _deepLinkService.isJwLibraryInstalled()) {
      if (mounted) {
        await _showJwLibraryRequiredDialog();
      }
      return;
    }
    setState(() {
      _openInJwLibrary = wantJwLibrary;
    });
    try {
      await LocalDbService().saveOpenBibleOnWeb(!wantJwLibrary);
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
    }
  }

  Future<void> _showJwLibraryRequiredDialog() async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ColorScheme cs = Theme.of(context).colorScheme;
    await showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        icon: Icon(Icons.menu_book_outlined, color: cs.primary),
        content: Text(
          l10n.settingsBibleTargetJwLibraryMissing,
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              openExternalUri(Uri.parse(jwLibraryStoreUrl));
            },
            child: Text(l10n.settingsBibleTargetInstall),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final RoundedRectangleBorder sectionShape = settingsSectionShape(context);

    return SettingsPage(
      title: l10n.settingsReadingSection,
      children: <Widget>[
        Card.filled(
          shape: sectionShape,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.settingsReadingPlan,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 10),
                // Same row widget the onboarding page uses — one picker
                // rather than two that drift apart.
                for (final ReadingPlan plan in ReadingPlan.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: PlanOptionTile(
                      plan: plan,
                      selected: _readingPlan == plan,
                      onTap: () => _changeReadingPlan(plan),
                    ),
                  ),
                const Divider(height: 24),
                // The whole row is the tap target rather than a trailing
                // icon button — a settings row that opens an editor is a
                // familiar pattern on its own, and a small pencil icon off
                // to the side read as an unexplained extra control.
                InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: _openResumePointEditor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.bookmark_rounded,
                          size: 20,
                          color: cs.onSurfaceVariant,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                l10n.settingsResumePoint,
                                style: theme.textTheme.bodyMedium,
                              ),
                              Text(
                                _resumePointLabel(context),
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: cs.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: cs.onSurfaceVariant,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card.filled(
          shape: sectionShape,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // A plain caption here, same as "settingsReadingPlan" above,
                // rather than the SwitchListTile's own title: now that this
                // sentence covers both the Bible and the daily text it runs
                // long in several languages, and a caption wraps to two
                // lines cleanly where a ListTile title just looks broken.
                Text(
                  l10n.settingsBibleTargetTitle,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                // Theme override rather than a SwitchListTile param: it has
                // no direct way to opt out of the tap ripple/highlight, only
                // the ambient InkWell colors it paints with — flattening
                // those to nothing is the standard way around that.
                Theme(
                  data: theme.copyWith(
                    splashFactory: NoSplash.splashFactory,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                  ),
                  child: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    secondary: Icon(
                      _openInJwLibrary
                          ? Icons.menu_book_outlined
                          : Icons.language_outlined,
                    ),
                    title: Text(
                      _openInJwLibrary
                          ? l10n.settingsBibleTargetJwLibrary
                          : l10n.settingsBibleTargetWeb,
                    ),
                    value: _openInJwLibrary,
                    onChanged: _changeBibleTarget,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// What the resume-point sheet was closed with: a new book+chapter, an
/// explicit clear, or (a plain `null` result, handled by the caller) a
/// dismissal that should change nothing. Two constructors rather than a
/// nullable `key` alone because "cleared" and "dismissed without choosing"
/// both look like "no key" otherwise, and only one of those should write to
/// the database.
class _ResumePointChoice {
  const _ResumePointChoice.set(this.key) : cleared = false;
  const _ResumePointChoice.clear() : key = null, cleared = true;

  final String? key;
  final bool cleared;
}

/// The sheet behind the resume-point row. Reuses the same book+chapter
/// picker fields the onboarding page uses, so setting it up for the first
/// time and changing it later feel like the same action — because they are
/// the same action, just at a different time.
class _ResumePointSheet extends StatefulWidget {
  const _ResumePointSheet({
    required this.initialBook,
    required this.initialChapter,
    required this.hasResumePoint,
  });

  final BibleBook initialBook;
  final int initialChapter;

  /// Whether a resume point is currently stored — gates the Clear button,
  /// which would otherwise have nothing to do on a fresh install.
  final bool hasResumePoint;

  @override
  State<_ResumePointSheet> createState() => _ResumePointSheetState();
}

class _ResumePointSheetState extends State<_ResumePointSheet> {
  late BibleBook _book = widget.initialBook;
  late int _chapter = widget.initialChapter;

  void _setBook(BibleBook book) {
    setState(() {
      _book = book;
      _chapter = _chapter.clamp(1, book.chapters);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          4,
          20,
          20 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(l10n.settingsResumePoint, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              l10n.onbStartResumeLabel,
              style: theme.textTheme.bodySmall?.copyWith(
                color: cs.onSurfaceVariant,
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
                    onChanged: (int chapter) =>
                        setState(() => _chapter = chapter),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: <Widget>[
                if (widget.hasResumePoint)
                  TextButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).pop(const _ResumePointChoice.clear()),
                    child: Text(l10n.settingsResumePointClear),
                  ),
                const Spacer(),
                FilledButton(
                  onPressed: () => Navigator.of(context).pop(
                    _ResumePointChoice.set(bibleChapterKey(_book.id, _chapter)),
                  ),
                  child: Text(l10n.checkpointSave),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
