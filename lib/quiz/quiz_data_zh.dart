import 'quiz_data.dart';
import 'quiz_data_zh_c1.dart';
import 'quiz_data_zh_c2.dart';
import 'quiz_data_zh_c3.dart';
import 'quiz_data_zh_c4.dart';
import 'quiz_data_zh_c5.dart';
import 'quiz_data_zh_c6.dart';
import 'quiz_data_zh_c7.dart';
import 'quiz_data_zh_c8.dart';

/// Simplified Chinese translations, keyed by checkpoint id (`bookId#index`),
/// mirroring the French source in quiz_data.dart. Entries missing here fall
/// back to French automatically (see `_authoredQuizzesFor`/`_extraQuizzesFor`).
const Map<String, List<QuizQuestion>> authoredQuizzesZh =
    <String, List<QuizQuestion>>{
      ...authoredQuizzesZhC1,
      ...authoredQuizzesZhC2,
      ...authoredQuizzesZhC3,
      ...authoredQuizzesZhC4,
      ...authoredQuizzesZhC5,
      ...authoredQuizzesZhC6,
      ...authoredQuizzesZhC7,
      ...authoredQuizzesZhC8,
    };

const Map<String, List<QuizQuestion>> extraQuizzesZh =
    <String, List<QuizQuestion>>{
      ...extraQuizzesZhC1,
      ...extraQuizzesZhC2,
      ...extraQuizzesZhC3,
      ...extraQuizzesZhC4,
      ...extraQuizzesZhC5,
      ...extraQuizzesZhC6,
      ...extraQuizzesZhC7,
      ...extraQuizzesZhC8,
    };
