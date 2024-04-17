import 'package:arioac_app/features/schedule/domain/domain.dart';

abstract class QARepository {
  Future<List<QA>> getQuestionsByPage({
    int limit = 10,
    int offset = 1,
    required String conferenceId,
  });
  Future<List<QA>> getSpeakerQuestionsByPage({
    int limit = 10,
    int offset = 1,
  });
  Future<QA> voteQuestion({
    required String questionId,
  });
  Future<QA> uploadQuestion({
    required String question,
    required String conferenceId,
  });
  Future<QA> uploadAnswer({
    required String answer,
    required String questionId,
  });
}
