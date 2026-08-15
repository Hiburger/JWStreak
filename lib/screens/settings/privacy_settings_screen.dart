import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/app_lock_service.dart';
import '../../services/local_db_service.dart';
import '../../services/note_export.dart';
import 'settings_common.dart';

/// The app lock. Its own page rather than a row buried among the reminder
/// permissions: it's the one setting that decides who can read the notes on
/// this phone, and people go looking for it by name.
class PrivacySettingsScreen extends StatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  State<PrivacySettingsScreen> createState() => _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends State<PrivacySettingsScreen> {
  final AppLockService _lockService = AppLockService();
  final LocalDbService _dbService = LocalDbService();

  /// Drives whether the export row is tappable: exporting nothing would
  /// hand the user an empty archive.
  int _noteCount = 0;
  bool _isExporting = false;

  // null while we're still asking the platform whether the device can
  // authenticate at all. A device with no screen lock set up never gets the
  // switch, since turning it on there would lock the user out for good.
  bool? _appLockAvailable;
  bool _appLockEnabled = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final bool available = await _lockService.isAvailable();
      final bool enabled = await _lockService.isEnabled();
      if (!mounted) {
        return;
      }
      // Counted with COUNT(*) rather than by loading every note body: this
      // only decides whether the export row is tappable.
      final int noteCount = await _dbService.getNotesCount();
      if (!mounted) {
        return;
      }
      setState(() {
        _appLockAvailable = available;
        _appLockEnabled = enabled;
        _noteCount = noteCount;
      });
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
    }
  }

  /// Turning the lock on or off both require passing the lock first: enabling
  /// proves the device can actually authenticate before the user is shut
  /// behind it, and disabling stops whoever is holding an already-unlocked
  /// session from simply switching the protection off.
  Future<void> _changeAppLock(bool wantEnabled) async {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final bool ok = await _lockService.authenticate(
      reason: wantEnabled
          ? l10n.appLockEnableReason
          : l10n.appLockDisableReason,
    );
    if (!ok || !mounted) {
      return;
    }
    setState(() => _appLockEnabled = wantEnabled);
    try {
      await _lockService.setEnabled(wantEnabled);
    } catch (error) {
      if (mounted) {
        setState(() => _appLockEnabled = !wantEnabled);
        showSettingsError(context, error);
      }
    }
  }

  /// Same logic the notes library used to run behind its own button: fetch
  /// every note, unfiltered, and hand them to the shared ZIP exporter.
  Future<void> _exportNotes() async {
    setState(() => _isExporting = true);
    try {
      final List<NoteEntry> notes = await _dbService.getAllNotes();
      if (!mounted || notes.isEmpty) {
        return;
      }
      await exportAllNotesAsZip(context, notes);
    } catch (error) {
      if (mounted) {
        showSettingsError(context, error);
      }
    } finally {
      if (mounted) {
        setState(() => _isExporting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return SettingsPage(
      title: l10n.settingsPrivacy,
      children: <Widget>[
        Card.filled(
          shape: settingsSectionShape(context),
          child: SwitchListTile(
            secondary: Icon(
              _appLockEnabled ? Icons.lock_rounded : Icons.lock_open_rounded,
            ),
            title: Text(l10n.settingsAppLockTitle),
            subtitle: Text(
              _appLockAvailable == false
                  ? l10n.settingsAppLockUnavailable
                  : _appLockEnabled
                  ? l10n.settingsAppLockOn
                  : l10n.settingsAppLockOff,
            ),
            value: _appLockEnabled,
            // Disabled (null) both while we're still checking and on a
            // device with no screen lock configured.
            onChanged: _appLockAvailable == true ? _changeAppLock : null,
          ),
        ),
        Card.filled(
          shape: settingsSectionShape(context),
          child: ListTile(
            leading: const Icon(Icons.ios_share_rounded),
            title: Text(l10n.notesLibraryExportAllTooltip),
            subtitle: Text(l10n.settingsExportNotesDesc),
            trailing: _isExporting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  )
                : const Icon(Icons.chevron_right_rounded),
            onTap: _noteCount == 0 || _isExporting ? null : _exportNotes,
          ),
        ),
      ],
    );
  }
}
