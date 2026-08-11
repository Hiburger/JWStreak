import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Opens the app's time picker and returns the chosen time, or null if the
/// user backed out.
///
/// Replaces Material's `showTimePicker`. That dialog leads with a clock dial
/// that has to be dragged twice (hours, then minutes) with a separate
/// keyboard-entry mode hidden behind a toggle — a lot of interface for
/// "pick 8:00", and it visibly predates the rest of this app. Scrolling
/// wheels are the convention every phone's own alarm clock uses, and one
/// gesture per field gets it done.
///
/// Built here rather than pulled from a package for one concrete reason: it
/// reads its colors from [ColorScheme], so it follows whichever skin is
/// active (see AppSkin) without knowing skins exist. A packaged picker
/// carrying its own palette would be the one screen that ignores them.
Future<TimeOfDay?> showTimeWheelPicker({
  required BuildContext context,
  required TimeOfDay initialTime,
  required String title,
}) {
  return showModalBottomSheet<TimeOfDay>(
    context: context,
    showDragHandle: true,
    builder: (BuildContext sheetContext) =>
        _TimeWheelSheet(initialTime: initialTime, title: title),
  );
}

/// A 0-23 hour as the 1-12 a twelve-hour wheel shows.
///
/// Midnight and noon both display as 12, not 0 — the case that makes this
/// worth a named function instead of a bare modulo at each call site.
int displayHourFrom24(int hour24) {
  final int mod = hour24 % 12;
  return mod == 0 ? 12 : mod;
}

/// A 1-12 wheel position plus an AM/PM choice, back to a 0-23 hour.
int hour24From12({required int displayHour, required bool isPm}) =>
    (displayHour % 12) + (isPm ? 12 : 0);

class _TimeWheelSheet extends StatefulWidget {
  const _TimeWheelSheet({required this.initialTime, required this.title});

  final TimeOfDay initialTime;
  final String title;

  @override
  State<_TimeWheelSheet> createState() => _TimeWheelSheetState();
}

class _TimeWheelSheetState extends State<_TimeWheelSheet> {
  static const double _itemExtent = 46;
  static const double _wheelHeight = 200;

  late int _hour = widget.initialTime.hour;
  late int _minute = widget.initialTime.minute;

  FixedExtentScrollController? _hourController;
  FixedExtentScrollController? _minuteController;
  FixedExtentScrollController? _periodController;

  /// Resolved in [didChangeDependencies] because it needs localizations, and
  /// it decides how many items the hour wheel has — so the controllers can't
  /// be built until it's known.
  bool? _use24Hour;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_use24Hour != null) {
      return;
    }
    final TimeOfDayFormat format = MaterialLocalizations.of(context)
        .timeOfDayFormat(
          alwaysUse24HourFormat: MediaQuery.of(context).alwaysUse24HourFormat,
        );
    final bool use24Hour =
        format != TimeOfDayFormat.h_colon_mm_space_a &&
        format != TimeOfDayFormat.a_space_h_colon_mm;
    _use24Hour = use24Hour;

    _hourController = FixedExtentScrollController(
      initialItem: use24Hour ? _hour : displayHourFrom24(_hour) - 1,
    );
    _minuteController = FixedExtentScrollController(initialItem: _minute);
    _periodController = FixedExtentScrollController(
      initialItem: _hour < 12 ? 0 : 1,
    );
  }

  @override
  void dispose() {
    _hourController?.dispose();
    _minuteController?.dispose();
    _periodController?.dispose();
    super.dispose();
  }

  void _onHourChanged(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      if (_use24Hour!) {
        _hour = index;
      } else {
        // The wheel is 1-12; keep whichever half of the day is already
        // selected rather than inferring it from the hour.
        _hour = hour24From12(displayHour: index + 1, isPm: _hour >= 12);
      }
    });
  }

  void _onMinuteChanged(int index) {
    HapticFeedback.selectionClick();
    setState(() => _minute = index);
  }

  void _onPeriodChanged(int index) {
    HapticFeedback.selectionClick();
    setState(() {
      _hour = hour24From12(
        displayHour: displayHourFrom24(_hour),
        isPm: index == 1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;
    final MaterialLocalizations material = MaterialLocalizations.of(context);
    final bool use24Hour = _use24Hour!;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              widget.title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            // The wheels show the parts; this shows the answer, in the
            // locale's own format, so there's no doubt what's about to be
            // saved before committing to it.
            Text(
              TimeOfDay(hour: _hour, minute: _minute).format(context),
              style: TextStyle(
                fontFamily: 'PlusJakartaSans',
                fontSize: 34,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
                color: cs.primary,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: _wheelHeight,
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  // The band marking which row counts, drawn under the
                  // wheels so the selected numbers sit inside it.
                  IgnorePointer(
                    child: Container(
                      height: _itemExtent,
                      decoration: BoxDecoration(
                        color: cs.primaryContainer.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _Wheel(
                        controller: _hourController!,
                        itemExtent: _itemExtent,
                        onChanged: _onHourChanged,
                        // 24-hour wheels are zero-padded so the column keeps
                        // an even width; a 12-hour wheel reads as a clock
                        // face, where "9" is what you'd expect to see.
                        labels: <String>[
                          for (int h = 0; h < (use24Hour ? 24 : 12); h++)
                            use24Hour
                                ? h.toString().padLeft(2, '0')
                                : '${h + 1}',
                        ],
                      ),
                      _WheelSeparator(),
                      _Wheel(
                        controller: _minuteController!,
                        itemExtent: _itemExtent,
                        onChanged: _onMinuteChanged,
                        labels: <String>[
                          for (int m = 0; m < 60; m++)
                            m.toString().padLeft(2, '0'),
                        ],
                      ),
                      if (!use24Hour) ...<Widget>[
                        const SizedBox(width: 8),
                        _Wheel(
                          controller: _periodController!,
                          itemExtent: _itemExtent,
                          onChanged: _onPeriodChanged,
                          // Two entries only, so this one doesn't loop —
                          // spinning endlessly between AM and PM would be a
                          // gesture with no end state.
                          looping: false,
                          labels: <String>[
                            material.anteMeridiemAbbreviation,
                            material.postMeridiemAbbreviation,
                          ],
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(material.cancelButtonLabel),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton(
                    onPressed: () => Navigator.of(
                      context,
                    ).pop(TimeOfDay(hour: _hour, minute: _minute)),
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      material.okButtonLabel,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// One scrolling column of the picker.
class _Wheel extends StatelessWidget {
  const _Wheel({
    required this.controller,
    required this.labels,
    required this.onChanged,
    required this.itemExtent,
    this.looping = true,
  });

  final FixedExtentScrollController controller;
  final List<String> labels;
  final ValueChanged<int> onChanged;
  final double itemExtent;
  final bool looping;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme cs = theme.colorScheme;

    final List<Widget> children = <Widget>[
      for (final String label in labels)
        Center(
          child: Text(
            label,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: cs.onSurface,
            ),
          ),
        ),
    ];

    return SizedBox(
      width: 74,
      child: ListWheelScrollView.useDelegate(
        controller: controller,
        itemExtent: itemExtent,
        // Physics that snap to a row rather than coming to rest between two,
        // which is what makes a wheel feel like a wheel.
        physics: const FixedExtentScrollPhysics(),
        // Rows away from the centre dim rather than disappear, so there's
        // still context above and below the selection.
        overAndUnderCenterOpacity: 0.35,
        diameterRatio: 1.5,
        squeeze: 1.1,
        onSelectedItemChanged: (int index) {
          // Looping wheels report an unbounded (and possibly negative)
          // index — it counts turns, not positions.
          final int normalized =
              ((index % labels.length) + labels.length) % labels.length;
          onChanged(normalized);
        },
        childDelegate: looping
            ? ListWheelChildLoopingListDelegate(children: children)
            : ListWheelChildListDelegate(children: children),
      ),
    );
  }
}

class _WheelSeparator extends StatelessWidget {
  const _WheelSeparator();

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Text(
      ':',
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.w800,
        color: theme.colorScheme.onSurfaceVariant,
      ),
    );
  }
}
