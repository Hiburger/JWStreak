import 'quiz_data.dart';
import 'quiz_data_pt_c1.dart';
import 'quiz_data_pt_c2.dart';
import 'quiz_data_pt_c3.dart';
import 'quiz_data_pt_c4.dart';
import 'quiz_data_pt_c5.dart';
import 'quiz_data_pt_c6.dart';
import 'quiz_data_pt_c7.dart';
import 'quiz_data_pt_c8.dart';

/// Portuguese translations, keyed by checkpoint id (`bookId#index`), mirroring
/// the French source in quiz_data.dart. Entries missing here fall back to
/// French automatically (see `_authoredQuizzesFor`/`_extraQuizzesFor`).
const Map<String, List<QuizQuestion>> authoredQuizzesPt = <String, List<QuizQuestion>>{
  ...authoredQuizzesPtC1,
  ...authoredQuizzesPtC2,
  ...authoredQuizzesPtC3,
  ...authoredQuizzesPtC4,
  ...authoredQuizzesPtC5,
  ...authoredQuizzesPtC6,
  ...authoredQuizzesPtC7,
  ...authoredQuizzesPtC8,
};

const Map<String, List<QuizQuestion>> extraQuizzesPt = <String, List<QuizQuestion>>{
  ...extraQuizzesPtC1,
  ...extraQuizzesPtC2,
  ...extraQuizzesPtC3,
  ...extraQuizzesPtC4,
  ...extraQuizzesPtC5,
  ...extraQuizzesPtC6,
  ...extraQuizzesPtC7,
  ...extraQuizzesPtC8,
};
