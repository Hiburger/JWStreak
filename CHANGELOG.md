# Changelog

All notable changes to JW Streak are recorded here. Dates are release dates.

## [1.7.0] — 2026-08-20

### Added

- **Back up and restore your data.** Settings → Your privacy & data writes
  everything — chapters read, notes, reflections, quiz results, streak,
  reminders, achievements and every setting — to a single JSON file, and
  hands it to the share sheet. Where it goes is entirely your choice; nothing
  is uploaded. Restoring shows you what the file holds (its date, and how many
  chapters and notes) before anything is replaced, and the whole swap happens
  in one transaction, so a file that turns out to be bad cannot leave you with
  half your data gone. The file is plain readable JSON on purpose: your notes
  stay recoverable with a text editor even if this app disappears.
- **Restore from the welcome screen**, so setting up a replacement phone
  doesn't mean inventing a reading position and a reminder first, only for the
  restore to overwrite both. The backup carries your onboarding state, so you
  land straight on your own dashboard.
- **Support the project.** The Donations page now links to GitHub Sponsors,
  and makes the point that starring the repository is a way to help that costs
  nothing. Sponsoring unlocks nothing in the app and never will.
- **An evening nudge with a live countdown.** If the day is still empty at
  20:00, the notification carries a timer ticking down to midnight rather than
  a sentence you have to work out. People with no streak yet get it too, worded
  for them — they were previously the only ones who never got reminded.

### Changed

- **Reminders no longer nag you about something you have already done.** Read
  or take a quiz today and the rest of today's reminders stay quiet; the daily
  repeat is untouched.
- **Reminder suggestions are toggles.** Tap one to set it, tap again to remove
  it. The separate Add button is gone, and confirming a time now says what it
  will do instead of "OK".
- **The "streak at risk" card waits until the evening.** It used to be up from
  the moment you opened the app, warning at breakfast about a day with sixteen
  hours left in it.
- **The home screen only offers quizzes for the book you are actually reading**
  instead of any unlocked checkpoint anywhere in the Bible.
- **Typed quiz answers are read more generously.** Answering in a whole phrase
  where a single word was expected now counts. Answers assembled from word
  chips are unaffected — there, an extra word really is a wrong answer.
- Settings page titles scale down to fit rather than being cut off, which
  affected longer translations.
- Privacy settings renamed **Your privacy & data**.

### Fixed

- **Travelling could silently reset your streak.** Flying west far enough moves
  the local date backwards, and a streak of any length dropped to 1 the moment
  the app was opened after landing. The streak is now held until the date
  catches up.
- **Reminders kept the times of the country you left.** They are now
  rescheduled against the current time zone whenever the app comes back to the
  foreground. Reminder times are also worked out by the calendar rather than by
  adding 24 hours, so a daylight-saving change no longer drifts them by an hour.
- **The save button on a reflection was hidden behind the keyboard**, which
  made it impossible to save what you had just written.
- **The app lock could strand you.** Turning it on and then restoring onto a
  phone with no screen lock configured left no way in, because the only control
  on the lock screen is a credential prompt that device cannot show. The lock
  now stands aside until the device can authenticate again; your setting is
  kept.

### Quiz content

- The Italian question about where Moses' mother hid him offered "fiume" as a
  wrong word while the answer read "sul Nilo" — natural Italian was marked
  wrong. The answer is shorter now, and what the basket was made of moved to
  the fact shown afterwards. The Portuguese version had the same shape.
- Goshen corrected to "Gòsen" in Italian.

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
