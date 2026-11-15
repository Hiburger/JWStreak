import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../l10n/app_localizations.dart';
import '../services/local_db_service.dart';
import '../widgets/circular_back_button.dart';
import '../widgets/responsive_body.dart';

/// Every break that was ever taken + reason if given. Reached from the streak detail screen.
class BreakLogScreen extends StatelessWidget {
  const BreakLogScreen({required this.breaks, super.key});

  final List<Break> breaks;

  String _tierName(AppLocalizations l10n, BreakTier tier) => switch (tier) {
    BreakTier.mini => l10n.streakBreakMini,
    BreakTier.small => l10n.streakBreakSmall,
    BreakTier.medium => l10n.streakBreakMedium,
    BreakTier.big => l10n.streakBreakBig,
  };

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: const CircularBackButton(),
        title: Text(l10n.streakBreakLogTitle),
      ),
      body: ResponsiveBody(
        child: breaks.isEmpty
            ? Center(
                child: Text(
                  l10n.streakBreakLogEmpty,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: cs.onSurfaceVariant,
                  ),
                ),
              )
            : ListView.separated(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                itemCount: breaks.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (BuildContext context, int index) {
                  final Break b = breaks[index];
                  final DateTime start = DateTime.parse(b.startDay);
                  final DateTime end = DateTime.parse(b.endDay);
                  final bool endedEarly =
                      end.difference(start).inDays + 1 < b.tier.durationDays;
                  return Card.filled(
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  '${_tierName(l10n, b.tier)} '
                                  '(${l10n.streakBreakTierDays(b.tier.durationDays)})',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              if (endedEarly)
                                Text(
                                  l10n.streakBreakLogEndedEarly,
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: cs.onSurfaceVariant,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${DateFormat('dd/MM/yyyy').format(start)} → '
                            '${DateFormat('dd/MM/yyyy').format(end)}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: cs.onSurfaceVariant,
                            ),
                          ),
                          if (b.reason.isNotEmpty) ...<Widget>[
                            const SizedBox(height: 6),
                            Text(
                              '“${b.reason}”',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
