import 'quiz_data.dart';
import 'quiz_data_ru_c1.dart';
import 'quiz_data_ru_c2.dart';
import 'quiz_data_ru_c3.dart';
import 'quiz_data_ru_c4.dart';
import 'quiz_data_ru_c5.dart';
import 'quiz_data_ru_c6.dart';
import 'quiz_data_ru_c7.dart';
import 'quiz_data_ru_c8.dart';

/// Russian translations, keyed by checkpoint id (`bookId#index`), mirroring
/// the French source in quiz_data.dart. Entries missing here fall back to
/// French automatically (see `_authoredQuizzesFor`/`_extraQuizzesFor`).
const Map<String, List<QuizQuestion>> authoredQuizzesRu =
    <String, List<QuizQuestion>>{
      ...authoredQuizzesRuC1,
      ...authoredQuizzesRuC2,
      ...authoredQuizzesRuC3,
      ...authoredQuizzesRuC4,
      ...authoredQuizzesRuC5,
      ...authoredQuizzesRuC6,
      ...authoredQuizzesRuC7,
      ...authoredQuizzesRuC8,
    };

const Map<String, List<QuizQuestion>> extraQuizzesRu =
    <String, List<QuizQuestion>>{
      ...extraQuizzesRuC1,
      ...extraQuizzesRuC2,
      ...extraQuizzesRuC3,
      ...extraQuizzesRuC4,
      ...extraQuizzesRuC5,
      ...extraQuizzesRuC6,
      ...extraQuizzesRuC7,
      ...extraQuizzesRuC8,
    };
