import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A [TextEditingController] that renders lightweight Markdown **live** inside
/// the text field. Formatting (bold / italic / strikethrough / headings) is
/// applied as the user types, and the Markdown markers themselves are hidden
/// once the caret leaves the token — they reappear only when the caret is on
/// (or next to) that token, so editing stays predictable while the result
/// looks clean, à la Obsidian live preview.
class MarkdownEditingController extends TextEditingController {
  MarkdownEditingController({super.text});

  static final RegExp _inline = RegExp(r'(\*\*.+?\*\*)|(\*.+?\*)|(~~.+?~~)');
  static final RegExp _heading = RegExp(r'^(#{1,6})\s');

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final TextStyle base = style ?? const TextStyle();
    final int caret = selection.isValid ? selection.extentOffset : -1;
    final List<InlineSpan> spans = <InlineSpan>[];
    final List<String> lines = text.split('\n');

    int global = 0;
    for (int i = 0; i < lines.length; i++) {
      final String line = lines[i];
      spans.addAll(_lineSpans(line, global, caret, base));
      global += line.length;
      if (i != lines.length - 1) {
        spans.add(TextSpan(text: '\n', style: base));
        global += 1;
      }
    }
    return TextSpan(style: base, children: spans);
  }

  List<InlineSpan> _lineSpans(
    String line,
    int lineStart,
    int caret,
    TextStyle base,
  ) {
    final List<InlineSpan> out = <InlineSpan>[];
    TextStyle lineStyle = base;
    int contentStart = 0;

    final RegExpMatch? h = _heading.firstMatch(line);
    if (h != null) {
      final int level = h.group(1)!.length;
      lineStyle = base.copyWith(
        fontWeight: FontWeight.w800,
        fontSize: (base.fontSize ?? 16) + (4 - level.clamp(1, 3)) * 2,
      );
      final int markerLen = h.end;
      final bool onLine =
          caret >= lineStart && caret <= lineStart + line.length;
      final String marker = line.substring(0, markerLen);
      out.add(
        onLine
            ? TextSpan(text: marker, style: lineStyle)
            : _hidden(marker, base),
      );
      contentStart = markerLen;
    }

    out.addAll(
      _inlineSpans(
        line.substring(contentStart),
        lineStart + contentStart,
        caret,
        lineStyle,
        base,
      ),
    );
    return out;
  }

  List<InlineSpan> _inlineSpans(
    String text,
    int baseGlobal,
    int caret,
    TextStyle contentStyle,
    TextStyle base,
  ) {
    final List<InlineSpan> out = <InlineSpan>[];
    int last = 0;
    for (final RegExpMatch m in _inline.allMatches(text)) {
      if (m.start > last) {
        out.add(TextSpan(text: text.substring(last, m.start), style: contentStyle));
      }
      final String token = m.group(0)!;
      final int start = baseGlobal + m.start;
      final int end = baseGlobal + m.end;
      final bool reveal = caret >= start && caret <= end;

      // Determine the marker kind from *which alternative matched* (group
      // index), not by inspecting the captured text — a run like "***" can
      // match the italic alternative while still starting with "**", which
      // would misclassify it as bold and compute a wrong marker length.
      final int markerLen;
      final TextStyle tokenStyle;
      if (m.group(1) != null) {
        markerLen = 2;
        tokenStyle = contentStyle.copyWith(fontWeight: FontWeight.bold);
      } else if (m.group(3) != null) {
        markerLen = 2;
        tokenStyle = contentStyle.copyWith(
          decoration: TextDecoration.lineThrough,
        );
      } else {
        markerLen = 1;
        tokenStyle = contentStyle.copyWith(fontStyle: FontStyle.italic);
      }

      // Defensive: skip styling entirely if the token is too short for its
      // markers (should not happen, but never crash on a substring call).
      if (token.length < markerLen * 2) {
        out.add(TextSpan(text: token, style: contentStyle));
        last = m.end;
        continue;
      }

      if (reveal) {
        out.add(TextSpan(text: token, style: tokenStyle));
      } else {
        out.add(_hidden(token.substring(0, markerLen), base));
        out.add(
          TextSpan(
            text: token.substring(markerLen, token.length - markerLen),
            style: tokenStyle,
          ),
        );
        out.add(_hidden(token.substring(token.length - markerLen), base));
      }
      last = m.end;
    }
    if (last < text.length) {
      out.add(TextSpan(text: text.substring(last), style: contentStyle));
    }
    return out;
  }

  // Renders marker characters with (near) zero size so they collapse visually
  // while still occupying their real offsets in the model. A negative
  // letterSpacing here would shrink the *measured* line width below what the
  // visible glyphs actually need, which clips the last pixels of the
  // preceding word — so width is only ever reduced via fontSize, never via
  // letterSpacing.
  TextSpan _hidden(String text, TextStyle base) => TextSpan(
    text: text,
    style: base.copyWith(fontSize: 0.01, color: const Color(0x00000000)),
  );
}

/// Continues a `- ` list automatically: pressing Enter on a non-empty list
/// line inserts a new `- ` marker on the next line; pressing Enter on an
/// empty list line removes the marker instead (exits the list), matching
/// common Markdown editors.
class MarkdownListContinuationFormatter extends TextInputFormatter {
  static final RegExp _listLine = RegExp(r'^(\s*)([-*])\s+(.*)$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Only handle a single '\n' being inserted at the caret.
    if (newValue.text.length != oldValue.text.length + 1) {
      return newValue;
    }
    final int insertPos = newValue.selection.baseOffset;
    if (insertPos < 1 ||
        insertPos > newValue.text.length ||
        newValue.text[insertPos - 1] != '\n') {
      return newValue;
    }

    final String before = newValue.text.substring(0, insertPos - 1);
    final int lineStart = before.lastIndexOf('\n') + 1;
    final String prevLine = before.substring(lineStart);
    final RegExpMatch? match = _listLine.firstMatch(prevLine);
    if (match == null) {
      return newValue;
    }

    final String indent = match.group(1)!;
    final String marker = match.group(2)!;
    final String content = match.group(3)!;

    if (content.trim().isEmpty) {
      // Empty item: remove the dangling marker line instead of continuing it.
      final String newText =
          newValue.text.substring(0, lineStart) +
          newValue.text.substring(insertPos);
      return TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: lineStart),
      );
    }

    final String insertion = '$indent$marker ';
    final String newText =
        newValue.text.substring(0, insertPos) +
        insertion +
        newValue.text.substring(insertPos);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(
        offset: insertPos + insertion.length,
      ),
    );
  }
}
