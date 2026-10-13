import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';

import '../app_constants.dart';
import '../l10n/app_localizations.dart';
import '../quiz/quiz_data.dart';
import '../widgets/circular_back_button.dart';
import '../widgets/responsive_body.dart';
import 'settings/settings_common.dart';

/// kind of problem the reader is reporting.
enum QuizReportKind { translation, content }

class QuizReportScreen extends StatefulWidget {
  const QuizReportScreen({
    required this.quizTitle,
    required this.question,
    super.key,
  });

  /// Localized title of the quiz the question came from, e.g. Genesis 1-3
  final String quizTitle;

  /// The question being reported, exactly as the reader saw it.
  final QuizQuestion question;

  @override
  State<QuizReportScreen> createState() => _QuizReportScreenState();
}

class _QuizReportScreenState extends State<QuizReportScreen> {
  QuizReportKind? _kind;
  final TextEditingController _commentController = TextEditingController();
  String? _appVersion;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo info) {
      if (mounted) {
        setState(() => _appVersion = '${info.version}+${info.buildNumber}');
      }
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  String get _body {
    final String languageCode = Localizations.localeOf(context).languageCode;
    final QuizQuestionLocation? location = locateQuizQuestion(
      widget.question.text,
      languageCode,
    );
    final bool translation = _kind == QuizReportKind.translation;
    return <String>[
      'JW Streak quiz report',
      '',
      'App version: ${_appVersion ?? 'unknown'}',
      'App language: $languageCode',
      'Quiz: ${widget.quizTitle}',
      if (location != null)
        'Checkpoint: ${location.checkpointId} — '
            'question ${location.index} of ${location.total}'
      else
        'Checkpoint: unknown',
      'Problem: ${translation ? 'Translation issue' : 'Quiz content issue'}',
      'Comment:',
      _commentController.text.trim().isEmpty
          ? '(none)'
          : _commentController.text.trim(),
    ].join('\n');
  }

  String get _subject {
    final String languageCode = Localizations.localeOf(context).languageCode;
    final bool translation = _kind == QuizReportKind.translation;
    return '[Quiz report] ${widget.quizTitle} — '
        '${translation ? 'translation' : 'content'} ($languageCode)';
  }

  Future<void> _send() async {
    final String subject = _subject;
    final String body = _body;
    // Mail first and the share for devices with no mail app at all
    try {
      await openExternalUri(
        Uri(
          scheme: 'mailto',
          path: kSupportEmail,
          queryParameters: <String, String>{'subject': subject, 'body': body},
        ),
      );
    } catch (_) {
      try {
        await SharePlus.instance.share(
          ShareParams(text: body, subject: subject),
        );
      } catch (_) {}
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    Widget kindButton({
      required QuizReportKind kind,
      required String word,
      required String description,
    }) {
      final bool selected = _kind == kind;
      return Expanded(
        child: OutlinedButton(
          onPressed: () => setState(() => _kind = kind),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: BorderSide(
              color: selected ? cs.primary : cs.outlineVariant,
              width: selected ? 2 : 1,
            ),
            backgroundColor: selected
                ? cs.primaryContainer.withValues(alpha: 0.45)
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                word,
                style: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: selected ? cs.primary : cs.onSurface,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                description,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: const CircularBackButton(),
        toolbarHeight: 86,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              l10n.quizReportTitle,
              style: const TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                letterSpacing: -1,
                height: 1.15,
              ),
            ),
            Text(
              widget.quizTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                color: cs.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
      body: ResponsiveBody(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 12, 32, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 420),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Icon(
                            Icons.info_outline_rounded,
                            size: 24,
                            color: cs.primary,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            l10n.quizReportNote1,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            l10n.quizReportNote2,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    kindButton(
                      kind: QuizReportKind.translation,
                      word: l10n.quizReportTranslation,
                      description: l10n.quizReportTranslationDesc,
                    ),
                    const SizedBox(width: 12),
                    kindButton(
                      kind: QuizReportKind.content,
                      word: l10n.quizReportContent,
                      description: l10n.quizReportContentDesc,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.quizReportCommentLabel,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: l10n.quizReportCommentHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _kind == null ? null : _send,
                style: FilledButton.styleFrom(
                  minimumSize: const Size.fromHeight(52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.send_outlined, size: 18),
                label: Text(l10n.quizReportSend),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
