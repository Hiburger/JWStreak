import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'Follow system'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @themeOled.
  ///
  /// In en, this message translates to:
  /// **'OLED Dark'**
  String get themeOled;

  /// No description provided for @noteUntitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get noteUntitled;

  /// No description provided for @noteExportMultiTitle.
  ///
  /// In en, this message translates to:
  /// **'My notes — JW Streak'**
  String get noteExportMultiTitle;

  /// No description provided for @noteExportedOn.
  ///
  /// In en, this message translates to:
  /// **'Exported on {date}'**
  String noteExportedOn(String date);

  /// No description provided for @reflectionPrompt0.
  ///
  /// In en, this message translates to:
  /// **'What does this passage teach you about Jehovah?'**
  String get reflectionPrompt0;

  /// No description provided for @reflectionPrompt1.
  ///
  /// In en, this message translates to:
  /// **'What quality shown here would you like to imitate?'**
  String get reflectionPrompt1;

  /// No description provided for @reflectionPrompt2.
  ///
  /// In en, this message translates to:
  /// **'How could you apply this teaching this week?'**
  String get reflectionPrompt2;

  /// No description provided for @reflectionPrompt3.
  ///
  /// In en, this message translates to:
  /// **'Which verse stood out to you most, and why?'**
  String get reflectionPrompt3;

  /// No description provided for @reflectionPrompt4.
  ///
  /// In en, this message translates to:
  /// **'What did you learn that was new in this reading?'**
  String get reflectionPrompt4;

  /// No description provided for @reflectionPrompt5.
  ///
  /// In en, this message translates to:
  /// **'How does this strengthen your faith?'**
  String get reflectionPrompt5;

  /// No description provided for @reflectionPrompt6.
  ///
  /// In en, this message translates to:
  /// **'What would you like to remember from these chapters?'**
  String get reflectionPrompt6;

  /// No description provided for @reflectionPrompt7.
  ///
  /// In en, this message translates to:
  /// **'How would you talk about this passage with someone?'**
  String get reflectionPrompt7;

  /// No description provided for @bookGenesis.
  ///
  /// In en, this message translates to:
  /// **'Genesis'**
  String get bookGenesis;

  /// No description provided for @bookExodus.
  ///
  /// In en, this message translates to:
  /// **'Exodus'**
  String get bookExodus;

  /// No description provided for @bookLeviticus.
  ///
  /// In en, this message translates to:
  /// **'Leviticus'**
  String get bookLeviticus;

  /// No description provided for @bookNumbers.
  ///
  /// In en, this message translates to:
  /// **'Numbers'**
  String get bookNumbers;

  /// No description provided for @bookDeuteronomy.
  ///
  /// In en, this message translates to:
  /// **'Deuteronomy'**
  String get bookDeuteronomy;

  /// No description provided for @bookJoshua.
  ///
  /// In en, this message translates to:
  /// **'Joshua'**
  String get bookJoshua;

  /// No description provided for @bookJudges.
  ///
  /// In en, this message translates to:
  /// **'Judges'**
  String get bookJudges;

  /// No description provided for @bookRuth.
  ///
  /// In en, this message translates to:
  /// **'Ruth'**
  String get bookRuth;

  /// No description provided for @book1Samuel.
  ///
  /// In en, this message translates to:
  /// **'1 Samuel'**
  String get book1Samuel;

  /// No description provided for @book2Samuel.
  ///
  /// In en, this message translates to:
  /// **'2 Samuel'**
  String get book2Samuel;

  /// No description provided for @book1Kings.
  ///
  /// In en, this message translates to:
  /// **'1 Kings'**
  String get book1Kings;

  /// No description provided for @book2Kings.
  ///
  /// In en, this message translates to:
  /// **'2 Kings'**
  String get book2Kings;

  /// No description provided for @book1Chronicles.
  ///
  /// In en, this message translates to:
  /// **'1 Chronicles'**
  String get book1Chronicles;

  /// No description provided for @book2Chronicles.
  ///
  /// In en, this message translates to:
  /// **'2 Chronicles'**
  String get book2Chronicles;

  /// No description provided for @bookEzra.
  ///
  /// In en, this message translates to:
  /// **'Ezra'**
  String get bookEzra;

  /// No description provided for @bookNehemiah.
  ///
  /// In en, this message translates to:
  /// **'Nehemiah'**
  String get bookNehemiah;

  /// No description provided for @bookEsther.
  ///
  /// In en, this message translates to:
  /// **'Esther'**
  String get bookEsther;

  /// No description provided for @bookJob.
  ///
  /// In en, this message translates to:
  /// **'Job'**
  String get bookJob;

  /// No description provided for @bookPsalms.
  ///
  /// In en, this message translates to:
  /// **'Psalms'**
  String get bookPsalms;

  /// No description provided for @bookProverbs.
  ///
  /// In en, this message translates to:
  /// **'Proverbs'**
  String get bookProverbs;

  /// No description provided for @bookEcclesiastes.
  ///
  /// In en, this message translates to:
  /// **'Ecclesiastes'**
  String get bookEcclesiastes;

  /// No description provided for @bookSongOfSolomon.
  ///
  /// In en, this message translates to:
  /// **'Song of Solomon'**
  String get bookSongOfSolomon;

  /// No description provided for @bookIsaiah.
  ///
  /// In en, this message translates to:
  /// **'Isaiah'**
  String get bookIsaiah;

  /// No description provided for @bookJeremiah.
  ///
  /// In en, this message translates to:
  /// **'Jeremiah'**
  String get bookJeremiah;

  /// No description provided for @bookLamentations.
  ///
  /// In en, this message translates to:
  /// **'Lamentations'**
  String get bookLamentations;

  /// No description provided for @bookEzekiel.
  ///
  /// In en, this message translates to:
  /// **'Ezekiel'**
  String get bookEzekiel;

  /// No description provided for @bookDaniel.
  ///
  /// In en, this message translates to:
  /// **'Daniel'**
  String get bookDaniel;

  /// No description provided for @bookHosea.
  ///
  /// In en, this message translates to:
  /// **'Hosea'**
  String get bookHosea;

  /// No description provided for @bookJoel.
  ///
  /// In en, this message translates to:
  /// **'Joel'**
  String get bookJoel;

  /// No description provided for @bookAmos.
  ///
  /// In en, this message translates to:
  /// **'Amos'**
  String get bookAmos;

  /// No description provided for @bookObadiah.
  ///
  /// In en, this message translates to:
  /// **'Obadiah'**
  String get bookObadiah;

  /// No description provided for @bookJonah.
  ///
  /// In en, this message translates to:
  /// **'Jonah'**
  String get bookJonah;

  /// No description provided for @bookMicah.
  ///
  /// In en, this message translates to:
  /// **'Micah'**
  String get bookMicah;

  /// No description provided for @bookNahum.
  ///
  /// In en, this message translates to:
  /// **'Nahum'**
  String get bookNahum;

  /// No description provided for @bookHabakkuk.
  ///
  /// In en, this message translates to:
  /// **'Habakkuk'**
  String get bookHabakkuk;

  /// No description provided for @bookZephaniah.
  ///
  /// In en, this message translates to:
  /// **'Zephaniah'**
  String get bookZephaniah;

  /// No description provided for @bookHaggai.
  ///
  /// In en, this message translates to:
  /// **'Haggai'**
  String get bookHaggai;

  /// No description provided for @bookZechariah.
  ///
  /// In en, this message translates to:
  /// **'Zechariah'**
  String get bookZechariah;

  /// No description provided for @bookMalachi.
  ///
  /// In en, this message translates to:
  /// **'Malachi'**
  String get bookMalachi;

  /// No description provided for @bookMatthew.
  ///
  /// In en, this message translates to:
  /// **'Matthew'**
  String get bookMatthew;

  /// No description provided for @bookMark.
  ///
  /// In en, this message translates to:
  /// **'Mark'**
  String get bookMark;

  /// No description provided for @bookLuke.
  ///
  /// In en, this message translates to:
  /// **'Luke'**
  String get bookLuke;

  /// No description provided for @bookJohn.
  ///
  /// In en, this message translates to:
  /// **'John'**
  String get bookJohn;

  /// No description provided for @bookActs.
  ///
  /// In en, this message translates to:
  /// **'Acts'**
  String get bookActs;

  /// No description provided for @bookRomans.
  ///
  /// In en, this message translates to:
  /// **'Romans'**
  String get bookRomans;

  /// No description provided for @book1Corinthians.
  ///
  /// In en, this message translates to:
  /// **'1 Corinthians'**
  String get book1Corinthians;

  /// No description provided for @book2Corinthians.
  ///
  /// In en, this message translates to:
  /// **'2 Corinthians'**
  String get book2Corinthians;

  /// No description provided for @bookGalatians.
  ///
  /// In en, this message translates to:
  /// **'Galatians'**
  String get bookGalatians;

  /// No description provided for @bookEphesians.
  ///
  /// In en, this message translates to:
  /// **'Ephesians'**
  String get bookEphesians;

  /// No description provided for @bookPhilippians.
  ///
  /// In en, this message translates to:
  /// **'Philippians'**
  String get bookPhilippians;

  /// No description provided for @bookColossians.
  ///
  /// In en, this message translates to:
  /// **'Colossians'**
  String get bookColossians;

  /// No description provided for @book1Thessalonians.
  ///
  /// In en, this message translates to:
  /// **'1 Thessalonians'**
  String get book1Thessalonians;

  /// No description provided for @book2Thessalonians.
  ///
  /// In en, this message translates to:
  /// **'2 Thessalonians'**
  String get book2Thessalonians;

  /// No description provided for @book1Timothy.
  ///
  /// In en, this message translates to:
  /// **'1 Timothy'**
  String get book1Timothy;

  /// No description provided for @book2Timothy.
  ///
  /// In en, this message translates to:
  /// **'2 Timothy'**
  String get book2Timothy;

  /// No description provided for @bookTitus.
  ///
  /// In en, this message translates to:
  /// **'Titus'**
  String get bookTitus;

  /// No description provided for @bookPhilemon.
  ///
  /// In en, this message translates to:
  /// **'Philemon'**
  String get bookPhilemon;

  /// No description provided for @bookHebrews.
  ///
  /// In en, this message translates to:
  /// **'Hebrews'**
  String get bookHebrews;

  /// No description provided for @bookJames.
  ///
  /// In en, this message translates to:
  /// **'James'**
  String get bookJames;

  /// No description provided for @book1Peter.
  ///
  /// In en, this message translates to:
  /// **'1 Peter'**
  String get book1Peter;

  /// No description provided for @book2Peter.
  ///
  /// In en, this message translates to:
  /// **'2 Peter'**
  String get book2Peter;

  /// No description provided for @book1John.
  ///
  /// In en, this message translates to:
  /// **'1 John'**
  String get book1John;

  /// No description provided for @book2John.
  ///
  /// In en, this message translates to:
  /// **'2 John'**
  String get book2John;

  /// No description provided for @book3John.
  ///
  /// In en, this message translates to:
  /// **'3 John'**
  String get book3John;

  /// No description provided for @bookJude.
  ///
  /// In en, this message translates to:
  /// **'Jude'**
  String get bookJude;

  /// No description provided for @bookRevelation.
  ///
  /// In en, this message translates to:
  /// **'Revelation'**
  String get bookRevelation;

  /// No description provided for @welcomeTagline.
  ///
  /// In en, this message translates to:
  /// **'Your daily Bible reading,\none day at a time.'**
  String get welcomeTagline;

  /// No description provided for @welcomeButton.
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcomeButton;

  /// No description provided for @welcomeLogoGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hi!'**
  String get welcomeLogoGreeting;

  /// No description provided for @welcomeFooter.
  ///
  /// In en, this message translates to:
  /// **'Free, libre, and open source'**
  String get welcomeFooter;

  /// No description provided for @onbContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get onbContinue;

  /// No description provided for @onbBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onbBack;

  /// No description provided for @onbFeaturesTitle.
  ///
  /// In en, this message translates to:
  /// **'What you can do'**
  String get onbFeaturesTitle;

  /// No description provided for @onbFeaturesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'A few features to guide your daily reading.'**
  String get onbFeaturesSubtitle;

  /// No description provided for @onbFeatureReadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Guided daily reading'**
  String get onbFeatureReadingTitle;

  /// No description provided for @onbFeatureReadingDesc.
  ///
  /// In en, this message translates to:
  /// **'One chapter a day, at your own pace. It opens in JW Library or on jw.org — your choice in settings. Mark it as read to move forward and feed your streak.'**
  String get onbFeatureReadingDesc;

  /// No description provided for @onbFeatureQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'Quizzes & stars'**
  String get onbFeatureQuizTitle;

  /// No description provided for @onbFeatureQuizDesc.
  ///
  /// In en, this message translates to:
  /// **'Check your understanding with short quizzes that unlock as you read. Answer by choosing, typing, or building words — and earn stars along the way.'**
  String get onbFeatureQuizDesc;

  /// No description provided for @onbFeatureNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal notes'**
  String get onbFeatureNotesTitle;

  /// No description provided for @onbFeatureNotesDesc.
  ///
  /// In en, this message translates to:
  /// **'Jot down your reflections as you read and find them again whenever you like. You can even export them.'**
  String get onbFeatureNotesDesc;

  /// No description provided for @onbFeaturePrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'100% private'**
  String get onbFeaturePrivacyTitle;

  /// No description provided for @onbFeaturePrivacyDesc.
  ///
  /// In en, this message translates to:
  /// **'Everything stays on your phone. No data is sent anywhere, and no account is required.'**
  String get onbFeaturePrivacyDesc;

  /// No description provided for @onbReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Set your first reminder'**
  String get onbReminderTitle;

  /// No description provided for @onbReminderIntro.
  ///
  /// In en, this message translates to:
  /// **'A small daily nudge is the best way to keep your streak going. Pick a calm moment of your day — you can always add more or change them later in settings.'**
  String get onbReminderIntro;

  /// No description provided for @onbReminderTip.
  ///
  /// In en, this message translates to:
  /// **'Tip: link your reminder to an existing habit, like after your morning coffee or before bed.'**
  String get onbReminderTip;

  /// No description provided for @onbReminderFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get onbReminderFinish;

  /// No description provided for @onbReminderSkip.
  ///
  /// In en, this message translates to:
  /// **'Maybe later'**
  String get onbReminderSkip;

  /// No description provided for @tourNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get tourNext;

  /// No description provided for @tourDone.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get tourDone;

  /// No description provided for @tourSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get tourSkip;

  /// No description provided for @tourStreakTitle.
  ///
  /// In en, this message translates to:
  /// **'Your streak'**
  String get tourStreakTitle;

  /// No description provided for @tourStreakBody.
  ///
  /// In en, this message translates to:
  /// **'Grows every day you read a chapter or take a quiz. Matches cover the days you miss.'**
  String get tourStreakBody;

  /// No description provided for @tourReadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s chapter'**
  String get tourReadingTitle;

  /// No description provided for @tourReadingBody.
  ///
  /// In en, this message translates to:
  /// **'Open it, then mark it as read to move on to the next one.'**
  String get tourReadingBody;

  /// No description provided for @tourBrowseTitle.
  ///
  /// In en, this message translates to:
  /// **'The whole Bible'**
  String get tourBrowseTitle;

  /// No description provided for @tourBrowseBody.
  ///
  /// In en, this message translates to:
  /// **'Jump to any book or chapter, and see what you\'ve already read.'**
  String get tourBrowseBody;

  /// No description provided for @tourProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Your progress'**
  String get tourProgressTitle;

  /// No description provided for @tourProgressBody.
  ///
  /// In en, this message translates to:
  /// **'Readings, stars and your recent activity, all in one place.'**
  String get tourProgressBody;

  /// No description provided for @tourQuickActionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get tourQuickActionsTitle;

  /// No description provided for @tourQuickActionsBody.
  ///
  /// In en, this message translates to:
  /// **'The daily text and your notes, always one tap away.'**
  String get tourQuickActionsBody;

  /// No description provided for @tourAchievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get tourAchievementsTitle;

  /// No description provided for @tourAchievementsBody.
  ///
  /// In en, this message translates to:
  /// **'Track the milestones you unlock as you read.'**
  String get tourAchievementsBody;

  /// No description provided for @tourNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'Your notes'**
  String get tourNotesTitle;

  /// No description provided for @tourNotesBody.
  ///
  /// In en, this message translates to:
  /// **'Everything you\'ve written, ready to reread or export.'**
  String get tourNotesBody;

  /// No description provided for @tourSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tourSettingsTitle;

  /// No description provided for @tourSettingsBody.
  ///
  /// In en, this message translates to:
  /// **'Theme, language, reminders — and this tour, if you want to see it again.'**
  String get tourSettingsBody;

  /// No description provided for @settingsReplayTour.
  ///
  /// In en, this message translates to:
  /// **'Replay the guided tour'**
  String get settingsReplayTour;

  /// No description provided for @settingsReplayTourSubtitle.
  ///
  /// In en, this message translates to:
  /// **'See the home screen walkthrough again'**
  String get settingsReplayTourSubtitle;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get settingsPrivacy;

  /// No description provided for @settingsAppLockTitle.
  ///
  /// In en, this message translates to:
  /// **'Lock the app'**
  String get settingsAppLockTitle;

  /// No description provided for @settingsAppLockOn.
  ///
  /// In en, this message translates to:
  /// **'Asks for your fingerprint, face or PIN before opening your notes — unless you come back within 10 minutes.'**
  String get settingsAppLockOn;

  /// No description provided for @settingsAppLockOff.
  ///
  /// In en, this message translates to:
  /// **'Your notes open without asking for anything.'**
  String get settingsAppLockOff;

  /// No description provided for @settingsAppLockUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Set up a screen lock on your phone first.'**
  String get settingsAppLockUnavailable;

  /// No description provided for @appLockPromptReason.
  ///
  /// In en, this message translates to:
  /// **'Unlock JW Streak'**
  String get appLockPromptReason;

  /// No description provided for @appLockEnableReason.
  ///
  /// In en, this message translates to:
  /// **'Confirm to turn the lock on'**
  String get appLockEnableReason;

  /// No description provided for @appLockDisableReason.
  ///
  /// In en, this message translates to:
  /// **'Confirm to turn the lock off'**
  String get appLockDisableReason;

  /// No description provided for @appLockScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'JW Streak is locked'**
  String get appLockScreenTitle;

  /// No description provided for @appLockScreenBody.
  ///
  /// In en, this message translates to:
  /// **'Your notes and your progress stay private until you unlock.'**
  String get appLockScreenBody;

  /// No description provided for @appLockUnlockButton.
  ///
  /// In en, this message translates to:
  /// **'Unlock'**
  String get appLockUnlockButton;

  /// No description provided for @onbReminderPermissionMissing.
  ///
  /// In en, this message translates to:
  /// **'Notifications are off, so this reminder won\'t ring. Turn them on to get notified.'**
  String get onbReminderPermissionMissing;

  /// No description provided for @onbReminderPermissionEnable.
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get onbReminderPermissionEnable;

  /// No description provided for @streakInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your streak alive'**
  String get streakInfoTitle;

  /// No description provided for @streakInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your streak grows every day you stay active — and resets to zero if you\'re away too long.'**
  String get streakInfoSubtitle;

  /// No description provided for @streakInfoRow1Title.
  ///
  /// In en, this message translates to:
  /// **'Stay active every day'**
  String get streakInfoRow1Title;

  /// No description provided for @streakInfoRow1Text.
  ///
  /// In en, this message translates to:
  /// **'Mark a chapter as read OR finish a quiz: both count toward keeping your streak.'**
  String get streakInfoRow1Text;

  /// No description provided for @streakInfoRow2Title.
  ///
  /// In en, this message translates to:
  /// **'4 matches per month'**
  String get streakInfoRow2Title;

  /// No description provided for @streakInfoRow2Text.
  ///
  /// In en, this message translates to:
  /// **'A missed day automatically uses a match to keep your streak\'s flame alight. They refill every month.'**
  String get streakInfoRow2Text;

  /// No description provided for @streakInfoRow3Title.
  ///
  /// In en, this message translates to:
  /// **'Earn back a match'**
  String get streakInfoRow3Title;

  /// No description provided for @streakInfoRow3Text.
  ///
  /// In en, this message translates to:
  /// **'Out of matches? Pass a review quiz (a mix of your readings) to earn one back.'**
  String get streakInfoRow3Text;

  /// No description provided for @streakInfoRow4Title.
  ///
  /// In en, this message translates to:
  /// **'We\'ll warn you'**
  String get streakInfoRow4Title;

  /// No description provided for @streakInfoRow4Text.
  ///
  /// In en, this message translates to:
  /// **'If your streak is at risk, a warning appears and an evening reminder can nudge you.'**
  String get streakInfoRow4Text;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsAppearance;

  /// No description provided for @settingsDynamicColor.
  ///
  /// In en, this message translates to:
  /// **'Dynamic colors'**
  String get settingsDynamicColor;

  /// No description provided for @settingsDynamicColorOn.
  ///
  /// In en, this message translates to:
  /// **'Uses the colors from your wallpaper (Material You)'**
  String get settingsDynamicColorOn;

  /// No description provided for @settingsDynamicColorOff.
  ///
  /// In en, this message translates to:
  /// **'Uses the app\'s brand color'**
  String get settingsDynamicColorOff;

  /// No description provided for @settingsBibleTargetTitle.
  ///
  /// In en, this message translates to:
  /// **'Open the Bible with'**
  String get settingsBibleTargetTitle;

  /// No description provided for @settingsBibleTargetJwLibrary.
  ///
  /// In en, this message translates to:
  /// **'JW Library app'**
  String get settingsBibleTargetJwLibrary;

  /// No description provided for @settingsBibleTargetWeb.
  ///
  /// In en, this message translates to:
  /// **'jw.org (browser)'**
  String get settingsBibleTargetWeb;

  /// No description provided for @settingsBibleTargetJwLibraryMissing.
  ///
  /// In en, this message translates to:
  /// **'The JW Library app is required to open the Bible this way. Would you like to install it?'**
  String get settingsBibleTargetJwLibraryMissing;

  /// No description provided for @settingsBibleTargetInstall.
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get settingsBibleTargetInstall;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsPermissions.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get settingsPermissions;

  /// No description provided for @settingsNotifPermTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification permissions'**
  String get settingsNotifPermTitle;

  /// No description provided for @settingsChecking.
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get settingsChecking;

  /// No description provided for @settingsNotifActive.
  ///
  /// In en, this message translates to:
  /// **'Permission active.'**
  String get settingsNotifActive;

  /// No description provided for @settingsNotifMissing.
  ///
  /// In en, this message translates to:
  /// **'Permission missing. Enable it to receive reminders.'**
  String get settingsNotifMissing;

  /// No description provided for @settingsVerify.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get settingsVerify;

  /// No description provided for @settingsExactAlarms.
  ///
  /// In en, this message translates to:
  /// **'Exact alarms'**
  String get settingsExactAlarms;

  /// No description provided for @settingsExactAlarmsOn.
  ///
  /// In en, this message translates to:
  /// **'Reminders fire at the exact time.'**
  String get settingsExactAlarmsOn;

  /// No description provided for @settingsExactAlarmsOff.
  ///
  /// In en, this message translates to:
  /// **'Not allowed. Reminders may be delayed.'**
  String get settingsExactAlarmsOff;

  /// No description provided for @settingsAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get settingsAllow;

  /// No description provided for @settingsInfo.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get settingsInfo;

  /// No description provided for @settingsVersionLabel.
  ///
  /// In en, this message translates to:
  /// **'JW Streak version'**
  String get settingsVersionLabel;

  /// No description provided for @settingsSourceCode.
  ///
  /// In en, this message translates to:
  /// **'View source code'**
  String get settingsSourceCode;

  /// No description provided for @settingsLicense.
  ///
  /// In en, this message translates to:
  /// **'License'**
  String get settingsLicense;

  /// No description provided for @settingsLicenseLegalese.
  ///
  /// In en, this message translates to:
  /// **'JW Streak is free software licensed under the GNU General Public License v3. The licenses below cover the open-source components it is built with.'**
  String get settingsLicenseLegalese;

  /// No description provided for @settingsQuestion.
  ///
  /// In en, this message translates to:
  /// **'A question?'**
  String get settingsQuestion;

  /// No description provided for @settingsFooter.
  ///
  /// In en, this message translates to:
  /// **'Made with brotherly love, from Switzerland.\nThis app is Free, Libre, and Open Source.'**
  String get settingsFooter;

  /// No description provided for @settingsError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String settingsError(String error);

  /// No description provided for @reminderPresetMorning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get reminderPresetMorning;

  /// No description provided for @reminderPresetNoon.
  ///
  /// In en, this message translates to:
  /// **'Noon'**
  String get reminderPresetNoon;

  /// No description provided for @reminderPresetEvening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get reminderPresetEvening;

  /// No description provided for @reminderAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'This reminder already exists.'**
  String get reminderAlreadyExists;

  /// No description provided for @reminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Reading reminders'**
  String get reminderTitle;

  /// No description provided for @reminderSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get reminderSuggestions;

  /// No description provided for @reminderAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add this reminder'**
  String get reminderAddButton;

  /// No description provided for @reminderMine.
  ///
  /// In en, this message translates to:
  /// **'My reminders'**
  String get reminderMine;

  /// No description provided for @reminderEmpty.
  ///
  /// In en, this message translates to:
  /// **'No reminders yet.\nPick a time and add it.'**
  String get reminderEmpty;

  /// No description provided for @reminderLimitReached.
  ///
  /// In en, this message translates to:
  /// **'Limit of {max} reminders reached. Delete one to add a new one.'**
  String reminderLimitReached(int max);

  /// No description provided for @reminderDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get reminderDeleteTooltip;

  /// No description provided for @reminderNewTime.
  ///
  /// In en, this message translates to:
  /// **'New time'**
  String get reminderNewTime;

  /// No description provided for @reminderEditTime.
  ///
  /// In en, this message translates to:
  /// **'Edit time'**
  String get reminderEditTime;

  /// No description provided for @reminderDailyTextTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily text'**
  String get reminderDailyTextTitle;

  /// No description provided for @reminderDailyTextSubtitle.
  ///
  /// In en, this message translates to:
  /// **'As a bonus, a gentle reminder for jw.org\'s daily text.'**
  String get reminderDailyTextSubtitle;

  /// No description provided for @notifDailyTextTitle.
  ///
  /// In en, this message translates to:
  /// **'JW Streak · Daily text'**
  String get notifDailyTextTitle;

  /// No description provided for @notifDailyTextBody.
  ///
  /// In en, this message translates to:
  /// **'Today\'s text is waiting on jw.org.'**
  String get notifDailyTextBody;

  /// No description provided for @quizQuestionCounter.
  ///
  /// In en, this message translates to:
  /// **'Question {index} / {total}'**
  String quizQuestionCounter(int index, int total);

  /// No description provided for @quizNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get quizNext;

  /// No description provided for @quizSeeScore.
  ///
  /// In en, this message translates to:
  /// **'See score'**
  String get quizSeeScore;

  /// No description provided for @quizTypeAnswerHint.
  ///
  /// In en, this message translates to:
  /// **'Type your answer'**
  String get quizTypeAnswerHint;

  /// No description provided for @quizCheckAnswer.
  ///
  /// In en, this message translates to:
  /// **'Check'**
  String get quizCheckAnswer;

  /// No description provided for @quizWordBankInstruction.
  ///
  /// In en, this message translates to:
  /// **'Tap the words in the right order'**
  String get quizWordBankInstruction;

  /// No description provided for @quizClearAnswer.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get quizClearAnswer;

  /// No description provided for @quizCorrectAnswerWas.
  ///
  /// In en, this message translates to:
  /// **'Answer: {answer}'**
  String quizCorrectAnswerWas(String answer);

  /// No description provided for @quizPerfect.
  ///
  /// In en, this message translates to:
  /// **'Perfect!'**
  String get quizPerfect;

  /// No description provided for @quizWellDone.
  ///
  /// In en, this message translates to:
  /// **'Well done!'**
  String get quizWellDone;

  /// No description provided for @quizScore.
  ///
  /// In en, this message translates to:
  /// **'Score: {score} / {total}'**
  String quizScore(int score, int total);

  /// No description provided for @quizFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get quizFinish;

  /// No description provided for @checkpointAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Step'**
  String get checkpointAppBarTitle;

  /// No description provided for @checkpointQuizLabel.
  ///
  /// In en, this message translates to:
  /// **'Quiz'**
  String get checkpointQuizLabel;

  /// No description provided for @checkpointQuestionCount.
  ///
  /// In en, this message translates to:
  /// **'{count} questions'**
  String checkpointQuestionCount(int count);

  /// No description provided for @checkpointBestScore.
  ///
  /// In en, this message translates to:
  /// **'Best score: {score}/{total}'**
  String checkpointBestScore(int score, int total);

  /// No description provided for @checkpointStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get checkpointStart;

  /// No description provided for @checkpointRedoQuiz.
  ///
  /// In en, this message translates to:
  /// **'Retake quiz'**
  String get checkpointRedoQuiz;

  /// No description provided for @checkpointPersonalReflection.
  ///
  /// In en, this message translates to:
  /// **'Personal reflection'**
  String get checkpointPersonalReflection;

  /// No description provided for @checkpointAnswer.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get checkpointAnswer;

  /// No description provided for @checkpointEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get checkpointEdit;

  /// No description provided for @checkpointReflectionAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Reflection'**
  String get checkpointReflectionAppBarTitle;

  /// No description provided for @checkpointReflectionHint.
  ///
  /// In en, this message translates to:
  /// **'Write your reflection…'**
  String get checkpointReflectionHint;

  /// No description provided for @checkpointSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get checkpointSave;

  /// No description provided for @homeStreakLostMessage.
  ///
  /// In en, this message translates to:
  /// **'Your streak reset to zero — no worries, let\'s start again together 💪'**
  String get homeStreakLostMessage;

  /// No description provided for @homeExactAlarmDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Reminder at the exact time'**
  String get homeExactAlarmDialogTitle;

  /// No description provided for @homeExactAlarmDialogContent.
  ///
  /// In en, this message translates to:
  /// **'To receive the reminder precisely at the chosen time, Android asks to allow \"alarms & reminders\". Without this permission, the notification may be delayed.'**
  String get homeExactAlarmDialogContent;

  /// No description provided for @homeExactAlarmDialogLater.
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get homeExactAlarmDialogLater;

  /// No description provided for @homeExactAlarmDialogOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get homeExactAlarmDialogOpenSettings;

  /// No description provided for @homeReviewQuizLocked.
  ///
  /// In en, this message translates to:
  /// **'Finish a few step quizzes first to unlock the review quiz.'**
  String get homeReviewQuizLocked;

  /// No description provided for @homeReviewQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'Review quiz'**
  String get homeReviewQuizTitle;

  /// No description provided for @homeReviewQuizEarned.
  ///
  /// In en, this message translates to:
  /// **'Well done! You earned back a match 🔥'**
  String get homeReviewQuizEarned;

  /// No description provided for @homeReviewQuizFailed.
  ///
  /// In en, this message translates to:
  /// **'You needed at least 60% correct answers. Try again!'**
  String get homeReviewQuizFailed;

  /// No description provided for @homeGenericError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String homeGenericError(String error);

  /// No description provided for @homeReminderConfigure.
  ///
  /// In en, this message translates to:
  /// **'Set up a reminder'**
  String get homeReminderConfigure;

  /// No description provided for @homeReminderAt.
  ///
  /// In en, this message translates to:
  /// **'Reminder at {label}'**
  String homeReminderAt(String label);

  /// No description provided for @homeRemindersActive.
  ///
  /// In en, this message translates to:
  /// **'{count} active reminders'**
  String homeRemindersActive(int count);

  /// No description provided for @homeNotesLibraryTooltip.
  ///
  /// In en, this message translates to:
  /// **'Notes library'**
  String get homeNotesLibraryTooltip;

  /// No description provided for @homeSettingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get homeSettingsTooltip;

  /// No description provided for @homeSectionReadingTitle.
  ///
  /// In en, this message translates to:
  /// **'Your reading'**
  String get homeSectionReadingTitle;

  /// No description provided for @homeSectionReadingSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pick up where you left off'**
  String get homeSectionReadingSubtitle;

  /// No description provided for @homeSectionProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get homeSectionProgressTitle;

  /// No description provided for @homeSectionQuickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick actions'**
  String get homeSectionQuickActions;

  /// No description provided for @homeStreakStartToday.
  ///
  /// In en, this message translates to:
  /// **'Start your streak today'**
  String get homeStreakStartToday;

  /// No description provided for @homeStreakDayCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{Streak of {count} day} other{Streak of {count} days}}'**
  String homeStreakDayCount(int count);

  /// No description provided for @homeGreetingNight1.
  ///
  /// In en, this message translates to:
  /// **'Good night'**
  String get homeGreetingNight1;

  /// No description provided for @homeGreetingNight2.
  ///
  /// In en, this message translates to:
  /// **'Still up?'**
  String get homeGreetingNight2;

  /// No description provided for @homeGreetingMorning1.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get homeGreetingMorning1;

  /// No description provided for @homeGreetingMorning2.
  ///
  /// In en, this message translates to:
  /// **'Have a great day'**
  String get homeGreetingMorning2;

  /// No description provided for @homeGreetingMorning3.
  ///
  /// In en, this message translates to:
  /// **'Rise and shine'**
  String get homeGreetingMorning3;

  /// No description provided for @homeGreetingMidday1.
  ///
  /// In en, this message translates to:
  /// **'Good noon'**
  String get homeGreetingMidday1;

  /// No description provided for @homeGreetingMidday2.
  ///
  /// In en, this message translates to:
  /// **'Enjoy your meal'**
  String get homeGreetingMidday2;

  /// No description provided for @homeGreetingAfternoon1.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get homeGreetingAfternoon1;

  /// No description provided for @homeGreetingAfternoon2.
  ///
  /// In en, this message translates to:
  /// **'Have a great rest of your day'**
  String get homeGreetingAfternoon2;

  /// No description provided for @homeGreetingEvening1.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get homeGreetingEvening1;

  /// No description provided for @homeGreetingEvening2.
  ///
  /// In en, this message translates to:
  /// **'Have a lovely evening'**
  String get homeGreetingEvening2;

  /// No description provided for @homeReadToday.
  ///
  /// In en, this message translates to:
  /// **'Read today'**
  String get homeReadToday;

  /// No description provided for @homeToReadToday.
  ///
  /// In en, this message translates to:
  /// **'To read today'**
  String get homeToReadToday;

  /// No description provided for @homeFreezesNone.
  ///
  /// In en, this message translates to:
  /// **'no matches left'**
  String get homeFreezesNone;

  /// No description provided for @homeFreezesRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} match left} other{{count} matches left}}'**
  String homeFreezesRemaining(int count);

  /// No description provided for @homeStreakAtRiskTitle.
  ///
  /// In en, this message translates to:
  /// **'Your streak is at risk'**
  String get homeStreakAtRiskTitle;

  /// No description provided for @homeStreakAtRiskSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Read a chapter or take a quiz today · {freezeLabel}'**
  String homeStreakAtRiskSubtitle(String freezeLabel);

  /// No description provided for @homeEarnFreezeButton.
  ///
  /// In en, this message translates to:
  /// **'Earn back a match (review quiz)'**
  String get homeEarnFreezeButton;

  /// No description provided for @homeNewQuizUnlocked.
  ///
  /// In en, this message translates to:
  /// **'New quiz unlocked'**
  String get homeNewQuizUnlocked;

  /// No description provided for @homeToRead.
  ///
  /// In en, this message translates to:
  /// **'To read'**
  String get homeToRead;

  /// No description provided for @homeOpenButton.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get homeOpenButton;

  /// No description provided for @homeMarkReadButton.
  ///
  /// In en, this message translates to:
  /// **'Mark as read'**
  String get homeMarkReadButton;

  /// No description provided for @homeAllRead.
  ///
  /// In en, this message translates to:
  /// **'Well done! You\'ve read the whole Bible.'**
  String get homeAllRead;

  /// No description provided for @homeBrowseBible.
  ///
  /// In en, this message translates to:
  /// **'Browse the Bible'**
  String get homeBrowseBible;

  /// No description provided for @homeChaptersReadCount.
  ///
  /// In en, this message translates to:
  /// **'{read} / {total} chapters'**
  String homeChaptersReadCount(int read, int total);

  /// No description provided for @homeStatStreakDaysPlural.
  ///
  /// In en, this message translates to:
  /// **'day streak'**
  String get homeStatStreakDaysPlural;

  /// No description provided for @homeStatStreakDaySingular.
  ///
  /// In en, this message translates to:
  /// **'day streak'**
  String get homeStatStreakDaySingular;

  /// No description provided for @homeStatReadingsPlural.
  ///
  /// In en, this message translates to:
  /// **'readings'**
  String get homeStatReadingsPlural;

  /// No description provided for @homeStatReadingSingular.
  ///
  /// In en, this message translates to:
  /// **'reading'**
  String get homeStatReadingSingular;

  /// No description provided for @homeStatStarsPlural.
  ///
  /// In en, this message translates to:
  /// **'stars'**
  String get homeStatStarsPlural;

  /// No description provided for @homeStatStarSingular.
  ///
  /// In en, this message translates to:
  /// **'star'**
  String get homeStatStarSingular;

  /// No description provided for @homeLastReadAt.
  ///
  /// In en, this message translates to:
  /// **'Last read: {date}'**
  String homeLastReadAt(String date);

  /// No description provided for @homeBibleBrowsed.
  ///
  /// In en, this message translates to:
  /// **'Bible browsed'**
  String get homeBibleBrowsed;

  /// No description provided for @homeDailyTextTitle.
  ///
  /// In en, this message translates to:
  /// **'Text of the day'**
  String get homeDailyTextTitle;

  /// No description provided for @homeDailyTextSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s thought'**
  String get homeDailyTextSubtitle;

  /// No description provided for @homeWriteNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Write a note'**
  String get homeWriteNoteTitle;

  /// No description provided for @homeWriteNoteSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Keep your reflections'**
  String get homeWriteNoteSubtitle;

  /// No description provided for @homeMyNotesTitle.
  ///
  /// In en, this message translates to:
  /// **'My notes'**
  String get homeMyNotesTitle;

  /// No description provided for @homeMyNotesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Reread your library'**
  String get homeMyNotesSubtitle;

  /// No description provided for @homeRecentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent activity'**
  String get homeRecentActivity;

  /// No description provided for @homeActiveDaysPlural.
  ///
  /// In en, this message translates to:
  /// **'{count} active days'**
  String homeActiveDaysPlural(int count);

  /// No description provided for @homeActiveDaysSingular.
  ///
  /// In en, this message translates to:
  /// **'{count} active day'**
  String homeActiveDaysSingular(int count);

  /// No description provided for @homeWeekdayMon.
  ///
  /// In en, this message translates to:
  /// **'M'**
  String get homeWeekdayMon;

  /// No description provided for @homeWeekdayTue.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get homeWeekdayTue;

  /// No description provided for @homeWeekdayWed.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get homeWeekdayWed;

  /// No description provided for @homeWeekdayThu.
  ///
  /// In en, this message translates to:
  /// **'T'**
  String get homeWeekdayThu;

  /// No description provided for @homeWeekdayFri.
  ///
  /// In en, this message translates to:
  /// **'F'**
  String get homeWeekdayFri;

  /// No description provided for @homeWeekdaySat.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get homeWeekdaySat;

  /// No description provided for @homeWeekdaySun.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get homeWeekdaySun;

  /// No description provided for @bibleAppTitle.
  ///
  /// In en, this message translates to:
  /// **'The Bible'**
  String get bibleAppTitle;

  /// No description provided for @bibleHebrewScriptures.
  ///
  /// In en, this message translates to:
  /// **'Hebrew Scriptures'**
  String get bibleHebrewScriptures;

  /// No description provided for @bibleGreekScriptures.
  ///
  /// In en, this message translates to:
  /// **'Christian Greek Scriptures'**
  String get bibleGreekScriptures;

  /// No description provided for @bibleStarsEarnedLabel.
  ///
  /// In en, this message translates to:
  /// **'Stars earned'**
  String get bibleStarsEarnedLabel;

  /// No description provided for @bibleStarsFraction.
  ///
  /// In en, this message translates to:
  /// **'{earned} / {max}'**
  String bibleStarsFraction(int earned, int max);

  /// No description provided for @bibleBookStarsFraction.
  ///
  /// In en, this message translates to:
  /// **'{stars}/{maxStars}'**
  String bibleBookStarsFraction(int stars, int maxStars);

  /// No description provided for @bibleChaptersReadCount.
  ///
  /// In en, this message translates to:
  /// **'{readCount} / {chapters} chapters'**
  String bibleChaptersReadCount(int readCount, int chapters);

  /// No description provided for @bibleTodoHeader.
  ///
  /// In en, this message translates to:
  /// **'To do'**
  String get bibleTodoHeader;

  /// No description provided for @bibleDoneHeader.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get bibleDoneHeader;

  /// No description provided for @bibleUnlockHint.
  ///
  /// In en, this message translates to:
  /// **'Read {title} to unlock this quiz!'**
  String bibleUnlockHint(String title);

  /// No description provided for @bibleErrorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String bibleErrorGeneric(String error);

  /// No description provided for @bibleOpenInJwLibrary.
  ///
  /// In en, this message translates to:
  /// **'Open in JW Library'**
  String get bibleOpenInJwLibrary;

  /// No description provided for @bibleMarkUnread.
  ///
  /// In en, this message translates to:
  /// **'Mark as unread'**
  String get bibleMarkUnread;

  /// No description provided for @bibleMarkRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as read'**
  String get bibleMarkRead;

  /// No description provided for @bibleChaptersHeader.
  ///
  /// In en, this message translates to:
  /// **'Chapters'**
  String get bibleChaptersHeader;

  /// No description provided for @bibleFullQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'Full quiz · {bookName}'**
  String bibleFullQuizTitle(String bookName);

  /// No description provided for @bibleFullBookQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'Full book quiz'**
  String get bibleFullBookQuizTitle;

  /// No description provided for @bibleFullBookQuizSubtitle.
  ///
  /// In en, this message translates to:
  /// **'All the questions, in one challenge'**
  String get bibleFullBookQuizSubtitle;

  /// No description provided for @bibleReflectionToWriteSuffix.
  ///
  /// In en, this message translates to:
  /// **' · reflection to write'**
  String get bibleReflectionToWriteSuffix;

  /// No description provided for @bibleCheckpointScoreDate.
  ///
  /// In en, this message translates to:
  /// **'{score}/{total} · {date}{suffix}'**
  String bibleCheckpointScoreDate(
    int score,
    int total,
    String date,
    String suffix,
  );

  /// No description provided for @bibleReflectionSaved.
  ///
  /// In en, this message translates to:
  /// **'Reflection saved'**
  String get bibleReflectionSaved;

  /// No description provided for @bibleLocked.
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get bibleLocked;

  /// No description provided for @bibleQuizAndReflection.
  ///
  /// In en, this message translates to:
  /// **'Quiz + reflection'**
  String get bibleQuizAndReflection;

  /// No description provided for @bibleReflectionOnly.
  ///
  /// In en, this message translates to:
  /// **'Reflection'**
  String get bibleReflectionOnly;

  /// No description provided for @noteEditorTitleErrorHint.
  ///
  /// In en, this message translates to:
  /// **'Add a title to save.'**
  String get noteEditorTitleErrorHint;

  /// No description provided for @noteEditorErrorSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String noteEditorErrorSnackbar(String error);

  /// No description provided for @noteEditorTitleNew.
  ///
  /// In en, this message translates to:
  /// **'New note'**
  String get noteEditorTitleNew;

  /// No description provided for @noteEditorTitleEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit note'**
  String get noteEditorTitleEdit;

  /// No description provided for @noteEditorSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get noteEditorSaveButton;

  /// No description provided for @noteEditorTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get noteEditorTitleHint;

  /// No description provided for @noteEditorBodyHint.
  ///
  /// In en, this message translates to:
  /// **'Write your thoughts, reflections, research points...'**
  String get noteEditorBodyHint;

  /// No description provided for @noteEditorMarkdownHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Markdown supported'**
  String get noteEditorMarkdownHelpTitle;

  /// No description provided for @noteEditorTipBold.
  ///
  /// In en, this message translates to:
  /// **'● Bold: **your_text**'**
  String get noteEditorTipBold;

  /// No description provided for @noteEditorTipItalic.
  ///
  /// In en, this message translates to:
  /// **'● Italic: *your_text*'**
  String get noteEditorTipItalic;

  /// No description provided for @noteEditorTipStrikethrough.
  ///
  /// In en, this message translates to:
  /// **'● Strikethrough: ~~your_text~~'**
  String get noteEditorTipStrikethrough;

  /// No description provided for @noteEditorTipHeading.
  ///
  /// In en, this message translates to:
  /// **'● Heading: # Your title'**
  String get noteEditorTipHeading;

  /// No description provided for @noteEditorTipList.
  ///
  /// In en, this message translates to:
  /// **'● List: - item'**
  String get noteEditorTipList;

  /// No description provided for @notesLibraryDeleteDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete?'**
  String get notesLibraryDeleteDialogTitle;

  /// No description provided for @notesLibraryCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get notesLibraryCancel;

  /// No description provided for @notesLibraryDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get notesLibraryDelete;

  /// No description provided for @notesLibraryDeleteConfirmSingular.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" will be permanently deleted.'**
  String notesLibraryDeleteConfirmSingular(String title);

  /// No description provided for @notesLibraryDeleteConfirmPlural.
  ///
  /// In en, this message translates to:
  /// **'These {count} notes will be permanently deleted from your device.'**
  String notesLibraryDeleteConfirmPlural(int count);

  /// No description provided for @notesLibraryErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String notesLibraryErrorMessage(String error);

  /// No description provided for @notesLibraryNewNote.
  ///
  /// In en, this message translates to:
  /// **'New note'**
  String get notesLibraryNewNote;

  /// No description provided for @notesLibrarySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by title, content, or passage'**
  String get notesLibrarySearchHint;

  /// No description provided for @notesLibraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Notes library'**
  String get notesLibraryTitle;

  /// No description provided for @notesLibraryCancelSelectionTooltip.
  ///
  /// In en, this message translates to:
  /// **'Cancel selection'**
  String get notesLibraryCancelSelectionTooltip;

  /// No description provided for @notesLibrarySelectedCountSingular.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String notesLibrarySelectedCountSingular(int count);

  /// No description provided for @notesLibrarySelectedCountPlural.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String notesLibrarySelectedCountPlural(int count);

  /// No description provided for @notesLibraryShareTooltip.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get notesLibraryShareTooltip;

  /// No description provided for @notesLibraryDeleteTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get notesLibraryDeleteTooltip;

  /// No description provided for @notesLibraryJustNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get notesLibraryJustNow;

  /// No description provided for @notesLibraryMinutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min ago'**
  String notesLibraryMinutesAgo(int minutes);

  /// No description provided for @notesLibraryHoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} h ago'**
  String notesLibraryHoursAgo(int hours);

  /// No description provided for @notesLibraryYesterday.
  ///
  /// In en, this message translates to:
  /// **'yesterday'**
  String get notesLibraryYesterday;

  /// No description provided for @notesLibraryEmptyNoResults.
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get notesLibraryEmptyNoResults;

  /// No description provided for @notesLibraryEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No notes yet'**
  String get notesLibraryEmptyTitle;

  /// No description provided for @notesLibraryEmptySearchHint.
  ///
  /// In en, this message translates to:
  /// **'Try different keywords, or check your spelling.'**
  String get notesLibraryEmptySearchHint;

  /// No description provided for @notesLibraryEmptySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Write your first thought using the \"New note\" button.'**
  String get notesLibraryEmptySubtitle;

  /// No description provided for @noteReaderDeleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete this note?'**
  String get noteReaderDeleteTitle;

  /// No description provided for @noteReaderDeleteContent.
  ///
  /// In en, this message translates to:
  /// **'\"{title}\" will be permanently deleted from your device.'**
  String noteReaderDeleteContent(String title);

  /// No description provided for @noteReaderCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get noteReaderCancel;

  /// No description provided for @noteReaderDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get noteReaderDelete;

  /// No description provided for @noteReaderError.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String noteReaderError(String error);

  /// No description provided for @noteReaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get noteReaderTitle;

  /// No description provided for @noteReaderShare.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get noteReaderShare;

  /// No description provided for @noteReaderEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get noteReaderEdit;

  /// No description provided for @noteReaderNoteGone.
  ///
  /// In en, this message translates to:
  /// **'This note no longer exists.'**
  String get noteReaderNoteGone;

  /// No description provided for @noteReaderUpdatedAt.
  ///
  /// In en, this message translates to:
  /// **'Last edited on {date}'**
  String noteReaderUpdatedAt(String date);

  /// No description provided for @noteReaderEmpty.
  ///
  /// In en, this message translates to:
  /// **'This note is empty.'**
  String get noteReaderEmpty;

  /// No description provided for @homeAchievementsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get homeAchievementsTooltip;

  /// No description provided for @achievementsTitle.
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// No description provided for @achievementsUnlockedCount.
  ///
  /// In en, this message translates to:
  /// **'{unlocked} of {total} unlocked'**
  String achievementsUnlockedCount(int unlocked, int total);

  /// No description provided for @achievementsProgressFraction.
  ///
  /// In en, this message translates to:
  /// **'{current} / {goal}'**
  String achievementsProgressFraction(int current, int goal);

  /// No description provided for @achievementsSectionReading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get achievementsSectionReading;

  /// No description provided for @achievementsSectionQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get achievementsSectionQuizzes;

  /// No description provided for @achievementsSectionStreak.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get achievementsSectionStreak;

  /// No description provided for @achievementsSectionOther.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get achievementsSectionOther;

  /// No description provided for @achievementFirstChapterTitle.
  ///
  /// In en, this message translates to:
  /// **'First Steps'**
  String get achievementFirstChapterTitle;

  /// No description provided for @achievementFirstChapterDesc.
  ///
  /// In en, this message translates to:
  /// **'Read your first chapter.'**
  String get achievementFirstChapterDesc;

  /// No description provided for @achievementChapters10Title.
  ///
  /// In en, this message translates to:
  /// **'Getting Started'**
  String get achievementChapters10Title;

  /// No description provided for @achievementChapters10Desc.
  ///
  /// In en, this message translates to:
  /// **'Read 10 chapters.'**
  String get achievementChapters10Desc;

  /// No description provided for @achievementChapters50Title.
  ///
  /// In en, this message translates to:
  /// **'Steady Reader'**
  String get achievementChapters50Title;

  /// No description provided for @achievementChapters50Desc.
  ///
  /// In en, this message translates to:
  /// **'Read 50 chapters.'**
  String get achievementChapters50Desc;

  /// No description provided for @achievementChapters150Title.
  ///
  /// In en, this message translates to:
  /// **'Devoted Reader'**
  String get achievementChapters150Title;

  /// No description provided for @achievementChapters150Desc.
  ///
  /// In en, this message translates to:
  /// **'Read 150 chapters.'**
  String get achievementChapters150Desc;

  /// No description provided for @achievementGenesisTitle.
  ///
  /// In en, this message translates to:
  /// **'In the Beginning'**
  String get achievementGenesisTitle;

  /// No description provided for @achievementGenesisDesc.
  ///
  /// In en, this message translates to:
  /// **'Finish reading the book of Genesis.'**
  String get achievementGenesisDesc;

  /// No description provided for @achievementWholeBibleTitle.
  ///
  /// In en, this message translates to:
  /// **'Cover to Cover'**
  String get achievementWholeBibleTitle;

  /// No description provided for @achievementWholeBibleDesc.
  ///
  /// In en, this message translates to:
  /// **'Read every chapter of the Bible.'**
  String get achievementWholeBibleDesc;

  /// No description provided for @achievementExplorerTitle.
  ///
  /// In en, this message translates to:
  /// **'Explorer'**
  String get achievementExplorerTitle;

  /// No description provided for @achievementExplorerDesc.
  ///
  /// In en, this message translates to:
  /// **'Read chapters from 5 different books.'**
  String get achievementExplorerDesc;

  /// No description provided for @achievementFirstQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'First Quiz'**
  String get achievementFirstQuizTitle;

  /// No description provided for @achievementFirstQuizDesc.
  ///
  /// In en, this message translates to:
  /// **'Complete your first quiz.'**
  String get achievementFirstQuizDesc;

  /// No description provided for @achievementQuizzes5Title.
  ///
  /// In en, this message translates to:
  /// **'Quiz Regular'**
  String get achievementQuizzes5Title;

  /// No description provided for @achievementQuizzes5Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 5 quizzes.'**
  String get achievementQuizzes5Desc;

  /// No description provided for @achievementQuizzes25Title.
  ///
  /// In en, this message translates to:
  /// **'Quiz Master'**
  String get achievementQuizzes25Title;

  /// No description provided for @achievementQuizzes25Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 25 quizzes.'**
  String get achievementQuizzes25Desc;

  /// No description provided for @achievementPerfectQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'Perfectionist'**
  String get achievementPerfectQuizTitle;

  /// No description provided for @achievementPerfectQuizDesc.
  ///
  /// In en, this message translates to:
  /// **'Get a perfect score on a quiz.'**
  String get achievementPerfectQuizDesc;

  /// No description provided for @achievementStars20Title.
  ///
  /// In en, this message translates to:
  /// **'Star Collector'**
  String get achievementStars20Title;

  /// No description provided for @achievementStars20Desc.
  ///
  /// In en, this message translates to:
  /// **'Earn 20 stars.'**
  String get achievementStars20Desc;

  /// No description provided for @achievementStreak7Title.
  ///
  /// In en, this message translates to:
  /// **'One Week Strong'**
  String get achievementStreak7Title;

  /// No description provided for @achievementStreak7Desc.
  ///
  /// In en, this message translates to:
  /// **'Keep a 7-day reading streak.'**
  String get achievementStreak7Desc;

  /// No description provided for @achievementStreak30Title.
  ///
  /// In en, this message translates to:
  /// **'One Month Strong'**
  String get achievementStreak30Title;

  /// No description provided for @achievementStreak30Desc.
  ///
  /// In en, this message translates to:
  /// **'Keep a 30-day reading streak.'**
  String get achievementStreak30Desc;

  /// No description provided for @achievementFirstNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Note Taker'**
  String get achievementFirstNoteTitle;

  /// No description provided for @achievementFirstNoteDesc.
  ///
  /// In en, this message translates to:
  /// **'Write your first note.'**
  String get achievementFirstNoteDesc;

  /// No description provided for @achievementReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay on Track'**
  String get achievementReminderTitle;

  /// No description provided for @achievementReminderDesc.
  ///
  /// In en, this message translates to:
  /// **'Set up a daily reminder.'**
  String get achievementReminderDesc;

  /// No description provided for @notifReminderTitle.
  ///
  /// In en, this message translates to:
  /// **'JW Streak · Bible reading'**
  String get notifReminderTitle;

  /// No description provided for @notifReminderBody.
  ///
  /// In en, this message translates to:
  /// **'Time for your reading. Tap to continue 📖'**
  String get notifReminderBody;

  /// No description provided for @notifStreakRiskTitle.
  ///
  /// In en, this message translates to:
  /// **'Your streak is at risk 🔥'**
  String get notifStreakRiskTitle;

  /// No description provided for @notifStreakRiskBody.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t been active today yet — read a chapter or take a quiz to keep it.'**
  String get notifStreakRiskBody;

  /// No description provided for @easterEggHeartBody.
  ///
  /// In en, this message translates to:
  /// **'I love you too :)'**
  String get easterEggHeartBody;

  /// No description provided for @easterEggVersionTitle.
  ///
  /// In en, this message translates to:
  /// **'Seven taps, really'**
  String get easterEggVersionTitle;

  /// No description provided for @easterEggVersionBody.
  ///
  /// In en, this message translates to:
  /// **'No hidden mode here, sorry. Just a thank you for looking this far — this app was written one evening at a time, and it\'s nice to know someone\'s poking around.'**
  String get easterEggVersionBody;

  /// No description provided for @easterEggVersionButton.
  ///
  /// In en, this message translates to:
  /// **'Stays between us'**
  String get easterEggVersionButton;

  /// No description provided for @achievementQuizzes40Title.
  ///
  /// In en, this message translates to:
  /// **'Quiz Legend'**
  String get achievementQuizzes40Title;

  /// No description provided for @achievementQuizzes40Desc.
  ///
  /// In en, this message translates to:
  /// **'Complete 40 quizzes.'**
  String get achievementQuizzes40Desc;

  /// No description provided for @achievementStars40Title.
  ///
  /// In en, this message translates to:
  /// **'Galaxy Collector'**
  String get achievementStars40Title;

  /// No description provided for @achievementStars40Desc.
  ///
  /// In en, this message translates to:
  /// **'Earn 40 stars.'**
  String get achievementStars40Desc;

  /// No description provided for @achievementStreak180Title.
  ///
  /// In en, this message translates to:
  /// **'Six Months Strong'**
  String get achievementStreak180Title;

  /// No description provided for @achievementStreak180Desc.
  ///
  /// In en, this message translates to:
  /// **'Keep a 180-day reading streak.'**
  String get achievementStreak180Desc;

  /// No description provided for @achievementNotes10Title.
  ///
  /// In en, this message translates to:
  /// **'Prolific Writer'**
  String get achievementNotes10Title;

  /// No description provided for @achievementNotes10Desc.
  ///
  /// In en, this message translates to:
  /// **'Write 10 notes.'**
  String get achievementNotes10Desc;

  /// No description provided for @achievementEasterEggsTitle.
  ///
  /// In en, this message translates to:
  /// **'Secret Hunter'**
  String get achievementEasterEggsTitle;

  /// No description provided for @achievementEasterEggsDesc.
  ///
  /// In en, this message translates to:
  /// **'Discover every hidden secret in the app.'**
  String get achievementEasterEggsDesc;

  /// No description provided for @freezeEarnedTitle.
  ///
  /// In en, this message translates to:
  /// **'New match earned!'**
  String get freezeEarnedTitle;

  /// No description provided for @freezeEarnedBody.
  ///
  /// In en, this message translates to:
  /// **'You\'ve completed 3 new quizzes. A match keeps your streak alight if you miss a day.'**
  String get freezeEarnedBody;

  /// No description provided for @freezeEarnedButton.
  ///
  /// In en, this message translates to:
  /// **'Nice!'**
  String get freezeEarnedButton;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'pl',
    'pt',
    'ru',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
