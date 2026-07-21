import 'quiz_data.dart';

/// English translations of [authoredQuizzesEn]/[extraQuizzesEn], keyed by
/// checkpoint id (`bookId#index`), mirroring the French source in
/// quiz_data.dart. Entries missing here fall back to French automatically
/// (see `_authoredQuizzesFor`/`_extraQuizzesFor` in quiz_data.dart).
const Map<String, List<QuizQuestion>> authoredQuizzesEn = <String, List<QuizQuestion>>{};

const Map<String, List<QuizQuestion>> extraQuizzesEn = <String, List<QuizQuestion>>{};
