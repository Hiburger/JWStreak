import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Concise reward dialog shown the moment a streak freeze is earned — either
/// by completing enough new quizzes (see `LocalDbService.saveQuizResult` and
/// [kQuizzesPerFreeze]) or by passing the review quiz. [message] overrides
/// the default "3 new quizzes" body for contexts where that wording doesn't
/// apply (e.g. the review quiz).
Future<void> showFreezeEarnedDialog(
  BuildContext context, {
  String? message,
}) async {
  final AppLocalizations l10n = AppLocalizations.of(context)!;
  final ColorScheme cs = Theme.of(context).colorScheme;

  await showDialog<void>(
    context: context,
    builder: (BuildContext dialogContext) => AlertDialog(
      icon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: cs.tertiaryContainer,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.whatshot_rounded,
          color: cs.onTertiaryContainer,
          size: 34,
        ),
      ),
      title: Text(l10n.freezeEarnedTitle, textAlign: TextAlign.center),
      content: Text(
        message ?? l10n.freezeEarnedBody,
        textAlign: TextAlign.center,
      ),
      actions: <Widget>[
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.freezeEarnedButton),
          ),
        ),
      ],
    ),
  );
}
