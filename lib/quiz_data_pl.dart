import 'quiz_data.dart';
import 'quiz_data_pl_c1.dart';
import 'quiz_data_pl_c2.dart';
import 'quiz_data_pl_c3.dart';
import 'quiz_data_pl_c4.dart';
import 'quiz_data_pl_c5.dart';
import 'quiz_data_pl_c6.dart';
import 'quiz_data_pl_c7.dart';
import 'quiz_data_pl_c8.dart';

/// Polish translations of the quizzes, keyed by checkpoint id
/// (`bookId#index`), mirroring the French source in quiz_data.dart. Entries
/// missing here fall back to French automatically (see
/// `_authoredQuizzesFor`/`_extraQuizzesFor` in quiz_data.dart).
const Map<String, List<QuizQuestion>> authoredQuizzesPl = <String, List<QuizQuestion>>{
  ...authoredQuizzesPlC1,
  ...authoredQuizzesPlC2,
  ...authoredQuizzesPlC3,
  ...authoredQuizzesPlC4,
  ...authoredQuizzesPlC5,
  ...authoredQuizzesPlC6,
  ...authoredQuizzesPlC7,
  ...authoredQuizzesPlC8,
};

const Map<String, List<QuizQuestion>> extraQuizzesPl = <String, List<QuizQuestion>>{
  ...extraQuizzesPlC1,
  ...extraQuizzesPlC2,
  ...extraQuizzesPlC3,
  ...extraQuizzesPlC4,
  ...extraQuizzesPlC5,
  ...extraQuizzesPlC6,
  ...extraQuizzesPlC7,
  ...extraQuizzesPlC8,
};
