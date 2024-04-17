import 'package:arioac_app/features/schedule/domain/entities/qa.dart';
import 'package:arioac_app/features/schedule/infrastructure/datasources/qa_ds_impl.dart';
import '../../domain/repositories/qa_repo.dart';

class QARepositoryImpl extends QARepository {
  final QADatasourceImpl datasource;

  QARepositoryImpl(this.datasource);

  @override
  Future<List<QA>> getQuestionsByPage({
    int limit = 10,
    int offset = 1,
    required String conferenceId,
  }) {
    return datasource.getQuestionsByPage(
        limit: limit, offset: offset, conferenceId: conferenceId);
  }

  @override
  Future<List<QA>> getSpeakerQuestionsByPage({
    int limit = 10,
    int offset = 1,
  }) {
    return datasource.getSpeakerQuestionsByPage(
      limit: limit,
      offset: offset,
    );
  }

  @override
  Future<QA> uploadAnswer({
    required String answer,
    required String questionId,
  }) {
    return datasource.uploadAnswer(answer: answer, questionId: questionId);
  }

  @override
  Future<QA> uploadQuestion({
    required String question,
    required String conferenceId,
  }) {
    return datasource.uploadQuestion(
        question: question, conferenceId: conferenceId);
  }

  @override
  Future<QA> voteQuestion({required String questionId}) {
    return datasource.voteQuestion(questionId: questionId);
  }
}
