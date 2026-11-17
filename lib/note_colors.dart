import 'widgets/onboarding_accent.dart';

/// The palette a reader can give a note — the same accents the onboarding
/// and settings tiles use, keyed by what the database stores.
const Map<String, OnboardingAccent> kNoteAccents = <String, OnboardingAccent>{
  'blue': kAccentBlue,
  'amber': kAccentAmber,
  'teal': kAccentTeal,
  'purple': kAccentPurple,
  'orange': kAccentOrange,
  'pink': kAccentPink,
};

/// The accent [key] names, or null when the note carries no color. Unknown
/// keys (a future palette renamed one) degrade to no color rather than
/// crashing on old data.
OnboardingAccent? noteAccent(String key) => kNoteAccents[key];
