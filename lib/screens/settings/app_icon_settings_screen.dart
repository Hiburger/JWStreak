import 'package:flutter/material.dart';

import '../../app_constants.dart';
import '../../l10n/app_localizations.dart';
import '../../services/app_icon_service.dart';
import '../../widgets/message_dialog.dart';
import 'settings_common.dart';

/// The app-icon settings page: pick the launcher icon, see who drew it, and
/// send in new ideas. Icon and author names are not localized on purpose
class AppIconSettingsScreen extends StatefulWidget {
  const AppIconSettingsScreen({super.key});

  @override
  State<AppIconSettingsScreen> createState() => _AppIconSettingsScreenState();
}

class _AppIconSettingsScreenState extends State<AppIconSettingsScreen> {
  final AppIconService _icons = AppIconService();
  late Future<String> _currentId = _loadCurrent();

  Future<String> _loadCurrent() async {
    try {
      return await _icons.getCurrentId();
    } catch (_) {
      // The platform channel is the only source of truth; if it ever
      // misbehaves the page still works, just from the default.
      return kAppIconOptions.first.id;
    }
  }

  Future<void> _select(String id) async {
    try {
      final String applied = await _icons.requestIcon(id);
      setState(() {
        _currentId = Future<String>.value(applied);
      });
    } catch (error) {
      if (mounted) {
        showMessageDialog(
          context,
          message: AppLocalizations.of(context)!.appIconSetError('$error'),
          isError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return SettingsPage(
      title: l10n.settingsCatAppIcon,
      children: <Widget>[
        Card.filled(
          shape: settingsSectionShape(context),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.appIconPickTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.appIconPickBody,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 16),
                FutureBuilder<String>(
                  future: _currentId,
                  builder: (BuildContext context, AsyncSnapshot<String> snap) {
                    final String current =
                        snap.data ?? kAppIconOptions.first.id;
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        for (final AppIconOption icon
                            in kAppIconOptions) ...<Widget>[
                          _IconOptionTile(
                            option: icon,
                            selected: icon.id == current,
                            onTap: () => _select(icon.id),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Card.filled(
          shape: settingsSectionShape(context),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.appIconSuggestionsTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.appIconSuggestionsBody,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () => openExternalUri(
                      Uri(
                        scheme: 'mailto',
                        path: kSupportEmail,
                        queryParameters: <String, String>{
                          'subject': 'JW Streak app icon',
                        },
                      ),
                    ),
                    icon: const Icon(Icons.mail_outline_rounded),
                    label: Text(l10n.appIconSuggestionsButton),
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

class _IconOptionTile extends StatelessWidget {
  const _IconOptionTile({
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final AppIconOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? cs.secondaryContainer : cs.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? cs.primary : cs.outlineVariant,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                option.previewAsset,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    option.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                    ),
                  ),
                  if ((option.author ?? '').isNotEmpty)
                    Text(
                      option.author!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: selected
                            ? cs.onSecondaryContainer.withValues(alpha: 0.8)
                            : cs.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
