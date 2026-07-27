import 'quiz_data.dart';
import 'quiz_data_en_c1.dart';
import 'quiz_data_en_c2.dart';
import 'quiz_data_en_c3.dart';
import 'quiz_data_en_c4.dart';
import 'quiz_data_en_c5.dart';
import 'quiz_data_en_c6.dart';
import 'quiz_data_en_c7.dart';
import 'quiz_data_en_c8.dart';

/// English translations of [authoredQuizzesEn]/[extraQuizzesEn], keyed by
/// checkpoint id (`bookId#index`), mirroring the French source in
/// quiz_data.dart. Entries missing here fall back to French automatically
/// (see `_authoredQuizzesFor`/`_extraQuizzesFor` in quiz_data.dart).
const Map<String, List<QuizQuestion>> authoredQuizzesEn = <String, List<QuizQuestion>>{
  ...authoredQuizzesEnC1,
  ...authoredQuizzesEnC2,
  ...authoredQuizzesEnC3,
  ...authoredQuizzesEnC4,
  ...authoredQuizzesEnC5,
  ...authoredQuizzesEnC6,
  ...authoredQuizzesEnC7,
  ...authoredQuizzesEnC8,
};

const Map<String, List<QuizQuestion>> extraQuizzesEn = <String, List<QuizQuestion>>{
  ...extraQuizzesEnC1,
  ...extraQuizzesEnC2,
  ...extraQuizzesEnC3,
  ...extraQuizzesEnC4,
  ...extraQuizzesEnC5,
  ...extraQuizzesEnC6,
  ...extraQuizzesEnC7,
  ...extraQuizzesEnC8,
};
