# Changelog

All notable changes to JW Streak are recorded here. Dates are release dates.

## [1.6.2] — 2026-08-15

### Added

- **Quiz round-up.** Every quiz now ends on a summary screen: the stars earned,
  a "did you know" fact about the passage, and a review of each question you
  missed with the correct answer and an explanation. Facts are written for all
  225 checkpoints in all 9 languages, and every one cites a verse you can look
  up yourself. Whole-book and review quizzes draw a fact from material you have
  already covered, so the round-up never spoils a passage you haven't reached.
- **Donations page** in Settings, between Privacy and Help. We don't take
  donations yet; the page explains where things stand and why.
- **Daily text opens in JW Library** when the app is installed, honouring the
  "open with" preference in Settings → Reading, and following the app language.
- **Notes are linked to a chapter you can change.** The book chip in the note
  editor is now tappable and opens the same picker used during onboarding.
- **Export my notes** moved to Settings → Privacy, where your data lives.

### Changed

- **Notifications settings redesigned**, with clearer wording and a status
  panel that tells you what is actually blocking a reminder.
- Notes are shown exactly as they were typed: line breaks and blank lines are
  preserved instead of being collapsed into one paragraph.
- Note editor and reader restyled — matching rounded text areas, a title field
  that reads as a field, and a flat app bar that doesn't tint when you scroll.
- "Bible browsed" now shows one decimal, with the separator your language uses.
- Tapping "Mark as read" before opening the chapter nudges the "Open" button
  instead of doing nothing.
- The Markdown help panel was removed from the note editor.

### Fixed

- Stars earned from achievements were missing from the "Stars earned" banner on
  the Bible page.
- The streak calendar showed nothing for days spent on quizzes. Marking a
  chapter read and finishing a quiz both keep a streak alive, but only the
  first was drawn on the calendar, so the streak count and the grid disagreed.
- The library note preview could drop a line when a note contained a list.
- Long greetings on the home banner didn't scroll far enough to be read in full.

### Quiz content

Every book was reviewed against the New World Translation and corrected across
all nine languages. Among the fixes:

- "church" replaced with "congregation" (and its equivalent in each language).
- John 10 now reads "excellent shepherd" rather than "good shepherd", matching
  the NWT's rendering of *kalos*, in French, Spanish, Italian, Portuguese,
  Russian and Chinese.
- Psalm 150:6 uses each language's own form of the shortened divine name —
  "Jah", "Iah", "Иаг" — instead of a single spelling everywhere.
- Details that are widely repeated but not actually in the text were removed:
  Absalom is caught by his *head*, not his hair (2 Samuel 18:9), and Ezra 3:12
  says "many others", not "the joy of the young men".
- Questions that cited a chapter beyond their own checkpoint were rewritten, so
  a quiz can no longer spoil reading you haven't done yet.
