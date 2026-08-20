import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../l10n/app_localizations.dart';
import '../../widgets/circular_back_button.dart';
import '../../widgets/message_dialog.dart';
import '../../widgets/responsive_body.dart';

/// The shared look of every settings card: matches the achievements screen's
/// cards, with an outline so each section reads as a distinct, bordered block
/// instead of a borderless tonal fill blending into the page background.
RoundedRectangleBorder settingsSectionShape(BuildContext context) =>
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
      side: BorderSide(color: Theme.of(context).colorScheme.outlineVariant),
    );

/// Chips default to a much smaller radius than [settingsSectionShape] —
/// inside a card that's this rounded, that read as a mismatch.
const RoundedRectangleBorder kSettingsChipShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(14)),
);

/// The scaffold every settings page shares: back button, title, the same
/// width cap and padding. Written once so the sibling pages can't drift
/// apart in spacing or in how the back gesture looks.
class SettingsPage extends StatelessWidget {
  const SettingsPage({required this.title, required this.children, super.key});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CircularBackButton(),
        // Some translated section titles ("Конфиденциальность и данные")
        // don't fit the app bar at full size and used to get cut off with
        // an ellipsis; scaling down instead keeps every word on screen.
        title: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(title, maxLines: 1),
        ),
      ),
      body: ResponsiveBody(
        child: ListView(padding: const EdgeInsets.all(16), children: children),
      ),
    );
  }
}

/// The label above a group of cards within a page.
class SettingsSectionLabel extends StatelessWidget {
  const SettingsSectionLabel(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

void showSettingsError(BuildContext context, Object error) {
  showMessageDialog(
    context,
    message: AppLocalizations.of(context)!.settingsError(error.toString()),
    isError: true,
  );
}

/// Hands a link to the system browser (or the mail app, for a `mailto:`).
Future<void> openExternalUri(Uri uri) async {
  final bool opened = await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );
  if (!opened) {
    throw StateError('Impossible d’ouvrir ${uri.toString()}');
  }
}
