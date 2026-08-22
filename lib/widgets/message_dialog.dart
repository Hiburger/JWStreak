import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

Future<void> showMessageDialog(
  BuildContext context, {
  required String message,
  bool isError = false,
}) async {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  final ColorScheme cs = Theme.of(context).colorScheme;

  await showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) => AlertDialog(
      icon: Icon(
        isError ? Icons.error_outline : Icons.info_outline,
        color: isError ? cs.error : cs.primary,
      ),
      content: Text(message, textAlign: TextAlign.center),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.commonOk),
          ),
        ),
      ],
    ),
  );
}
