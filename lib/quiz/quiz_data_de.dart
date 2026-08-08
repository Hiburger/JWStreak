import 'quiz_data.dart';
import 'quiz_data_de_c1.dart';
import 'quiz_data_de_c2.dart';
import 'quiz_data_de_c3.dart';
import 'quiz_data_de_c4.dart';
import 'quiz_data_de_c5.dart';
import 'quiz_data_de_c6.dart';
import 'quiz_data_de_c7.dart';
import 'quiz_data_de_c8.dart';

/// German translations of the quizzes, keyed by checkpoint id
/// (`bookId#index`), mirroring the French source in quiz_data.dart. Entries
/// missing here fall back to French automatically (see
/// `_authoredQuizzesFor`/`_extraQuizzesFor` in quiz_data.dart).
const Map<String, List<QuizQuestion>> authoredQuizzesDe =
    <String, List<QuizQuestion>>{
      ...authoredQuizzesDeC1,
      ...authoredQuizzesDeC2,
      ...authoredQuizzesDeC3,
      ...authoredQuizzesDeC4,
      ...authoredQuizzesDeC5,
      ...authoredQuizzesDeC6,
      ...authoredQuizzesDeC7,
      ...authoredQuizzesDeC8,
    };

const Map<String, List<QuizQuestion>> extraQuizzesDe =
    <String, List<QuizQuestion>>{
      ...extraQuizzesDeC1,
      ...extraQuizzesDeC2,
      ...extraQuizzesDeC3,
      ...extraQuizzesDeC4,
      ...extraQuizzesDeC5,
      ...extraQuizzesDeC6,
      ...extraQuizzesDeC7,
      ...extraQuizzesDeC8,
    };
