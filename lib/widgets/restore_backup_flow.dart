import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../services/backup_service.dart';
import 'message_dialog.dart';

/// Localised reason a file was turned away, so the reader is told what is
/// wrong with it rather than just that "something failed".
String _rejectionMessage(AppLocalizations l10n, BackupRejection reason) =>
    switch (reason) {
      BackupRejection.unreadable ||
      BackupRejection.notABackup => l10n.restoreErrorNotABackup,
      BackupRejection.tooNew => l10n.restoreErrorTooNew,
      BackupRejection.corrupt => l10n.restoreErrorCorrupt,
    };

/// Shows what the file holds before anything is overwritten. The counts are
/// how a reader recognises their own backup — and the last defence against
/// restoring the wrong file over good data.
Future<bool> _confirmRestore(
  BuildContext context,
  AppLocalizations l10n,
  BackupData data,
) async {
  final bool? confirmed = await showDialog<bool>(
    context: context,
    builder: (BuildContext dialogContext) => AlertDialog(
      icon: const Icon(Icons.settings_backup_restore),
      title: Text(l10n.restoreConfirmTitle),
      content: Text(
        l10n.restoreConfirmBody(
          DateFormat.yMMMMd(
            Localizations.localeOf(dialogContext).toString(),
          ).format(data.exportedAt),
          data.chapterCount,
          data.noteCount,
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(l10n.notesLibraryCancel),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: Theme.of(dialogContext).colorScheme.error,
            foregroundColor: Theme.of(dialogContext).colorScheme.onError,
          ),
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(l10n.restoreConfirmAction),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}

/// The success line, in the language the reader is about to *get* rather than
/// the one they are leaving. Restoring a French backup onto an English device
/// switches the whole UI mid-flow, and a confirmation still speaking English
/// on a now-French screen reads like something only half worked.
Future<AppLocalizations> _localizationsAfterRestore(
  AppLocalizations current,
  BackupData data,
) async {
  final String? code = data.localeCode;
  if (code == null) {
    return current;
  }
  final bool supported = AppLocalizations.supportedLocales.any(
    (Locale locale) => locale.languageCode == code,
  );
  return supported ? AppLocalizations.delegate.load(Locale(code)) : current;
}

/// Picks a backup file, shows the reader what is in it, and only then replaces
/// the database. Returns true if a restore actually happened.
///
/// Shared by the privacy settings page and the welcome screen: someone setting
/// up a new phone needs this before they have an app to put settings in, and
/// duplicating the flow would mean two chances to get a destructive operation
/// subtly wrong.
///
/// The file is parsed and validated *before* the confirmation, so a bad file
/// is refused without ever having threatened the data already on the device.
Future<bool> pickAndRestoreBackup(BuildContext context) async {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  try {
    final XFile? picked = await openFile(
      acceptedTypeGroups: <XTypeGroup>[
        const XTypeGroup(
          label: 'JW Streak backup',
          extensions: <String>['json'],
          mimeTypes: <String>['application/json'],
        ),
      ],
    );
    if (picked == null || !context.mounted) {
      return false;
    }

    final BackupService backup = BackupService();
    final BackupData data = backup.parse(await picked.readAsString());
    if (!context.mounted) {
      return false;
    }

    final bool confirmed = await _confirmRestore(context, l10n, data);
    if (!confirmed || !context.mounted) {
      return false;
    }

    await backup.restore(data);
    // The root of the app re-reads theme, language, skin — and whether
    // onboarding is done, which is what lets a restore on a new phone drop
    // the reader straight onto their own dashboard.
    notifyBackupRestored();

    final AppLocalizations after = await _localizationsAfterRestore(l10n, data);
    if (context.mounted) {
      showMessageDialog(context, message: after.restoreDone);
    }
    return true;
  } on BackupException catch (error) {
    if (context.mounted) {
      showMessageDialog(
        context,
        message: _rejectionMessage(l10n, error.rejection),
        isError: true,
      );
    }
    return false;
  } catch (_) {
    // Everything that isn't a verdict on the file's contents: an unreadable
    // file, bytes that aren't UTF-8, a picker the platform refused. The
    // welcome screen calls this straight from an onPressed with nowhere to
    // catch, so a failure that escapes here is one the reader never hears
    // about — on the very screen where they are trying to recover a phone.
    // Treated as "this file is no good", which is what it means to them.
    if (context.mounted) {
      showMessageDialog(
        context,
        message: l10n.restoreErrorNotABackup,
        isError: true,
      );
    }
    return false;
  }
}
