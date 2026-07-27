import 'quiz_data.dart';
import 'quiz_data_es_c1.dart';
import 'quiz_data_es_c2.dart';
import 'quiz_data_es_c3.dart';
import 'quiz_data_es_c4.dart';
import 'quiz_data_es_c5.dart';
import 'quiz_data_es_c6.dart';
import 'quiz_data_es_c7.dart';
import 'quiz_data_es_c8.dart';

/// Spanish translations, keyed by checkpoint id (`bookId#index`), mirroring
/// the French source in quiz_data.dart. Entries missing here fall back to
/// French automatically (see `_authoredQuizzesFor`/`_extraQuizzesFor`).
const Map<String, List<QuizQuestion>> authoredQuizzesEs = <String, List<QuizQuestion>>{
  ...authoredQuizzesEsC1,
  ...authoredQuizzesEsC2,
  ...authoredQuizzesEsC3,
  ...authoredQuizzesEsC4,
  ...authoredQuizzesEsC5,
  ...authoredQuizzesEsC6,
  ...authoredQuizzesEsC7,
  ...authoredQuizzesEsC8,
};

const Map<String, List<QuizQuestion>> extraQuizzesEs = <String, List<QuizQuestion>>{
  ...extraQuizzesEsC1,
  ...extraQuizzesEsC2,
  ...extraQuizzesEsC3,
  ...extraQuizzesEsC4,
  ...extraQuizzesEsC5,
  ...extraQuizzesEsC6,
  ...extraQuizzesEsC7,
  ...extraQuizzesEsC8,
};
