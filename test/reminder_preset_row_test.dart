import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jwstreak/widgets/reminder_picker.dart';

const List<ReminderTimePreset> _presets = <ReminderTimePreset>[
  ReminderTimePreset(
    label: 'Morning',
    hour: 8,
    minute: 0,
    icon: Icons.wb_sunny_outlined,
  ),
  ReminderTimePreset(
    label: 'Noon',
    hour: 12,
    minute: 30,
    icon: Icons.light_mode_outlined,
  ),
  ReminderTimePreset(
    label: 'Evening',
    hour: 20,
    minute: 0,
    icon: Icons.nightlight_outlined,
  ),
];

Future<void> _pumpRow(
  WidgetTester tester, {
  required Set<String> active,
  required bool canAdd,
  required void Function(ReminderTimePreset) onToggle,
}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: ReminderPresetRow(
          presets: _presets,
          isActive: (ReminderTimePreset p) =>
              active.contains('${p.hour}:${p.minute}'),
          canAdd: canAdd,
          onToggle: onToggle,
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets('tapping a suggestion reports it, on and off alike', (
    WidgetTester tester,
  ) async {
    final List<String> toggled = <String>[];
    await _pumpRow(
      tester,
      active: <String>{'8:0'},
      canAdd: true,
      onToggle: (ReminderTimePreset p) => toggled.add(p.label),
    );

    // Already set: tapping it is a request to remove.
    await tester.tap(find.text('Morning'));
    // Not set: tapping it is a request to add.
    await tester.tap(find.text('Evening'));
    await tester.pump();

    expect(toggled, <String>['Morning', 'Evening']);
  });

  testWidgets('a set suggestion is shown as set, not as last-tapped', (
    WidgetTester tester,
  ) async {
    await _pumpRow(
      tester,
      active: <String>{'20:0'},
      canAdd: true,
      onToggle: (_) {},
    );

    final Iterable<ReminderPresetChip> chips = tester
        .widgetList<ReminderPresetChip>(find.byType(ReminderPresetChip));
    expect(
      chips.map((ReminderPresetChip c) => c.selected).toList(),
      <bool>[false, false, true],
      reason: 'only the reminder that actually exists reads as on',
    );
  });

  testWidgets('at the limit, unset suggestions stop responding', (
    WidgetTester tester,
  ) async {
    final List<String> toggled = <String>[];
    await _pumpRow(
      tester,
      active: <String>{'8:0'},
      canAdd: false,
      onToggle: (ReminderTimePreset p) => toggled.add(p.label),
    );

    // Nothing more fits, so a chip that isn't on can't be turned on: it goes
    // quiet rather than swallowing the tap.
    await tester.tap(find.text('Evening'));
    await tester.pump();
    expect(toggled, isEmpty);

    // The one that is already on must still be removable.
    await tester.tap(find.text('Morning'));
    await tester.pump();
    expect(toggled, <String>['Morning']);
  });
}
