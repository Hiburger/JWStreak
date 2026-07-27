import 'quiz_data.dart';
import 'quiz_data_it_c1.dart';
import 'quiz_data_it_c2.dart';
import 'quiz_data_it_c3.dart';
import 'quiz_data_it_c4.dart';
import 'quiz_data_it_c5.dart';
import 'quiz_data_it_c6.dart';
import 'quiz_data_it_c7.dart';
import 'quiz_data_it_c8.dart';

/// Italian translations, keyed by checkpoint id (`bookId#index`), mirroring
/// the French source in quiz_data.dart. Entries missing here fall back to
/// French automatically (see `_authoredQuizzesFor`/`_extraQuizzesFor`).
const Map<String, List<QuizQuestion>> authoredQuizzesIt = <String, List<QuizQuestion>>{
  ...authoredQuizzesItC1,
  ...authoredQuizzesItC2,
  ...authoredQuizzesItC3,
  ...authoredQuizzesItC4,
  ...authoredQuizzesItC5,
  ...authoredQuizzesItC6,
  ...authoredQuizzesItC7,
  ...authoredQuizzesItC8,
};

const Map<String, List<QuizQuestion>> extraQuizzesIt = <String, List<QuizQuestion>>{
  ...extraQuizzesItC1,
  ...extraQuizzesItC2,
  ...extraQuizzesItC3,
  ...extraQuizzesItC4,
  ...extraQuizzesItC5,
  ...extraQuizzesItC6,
  ...extraQuizzesItC7,
  ...extraQuizzesItC8,
};
