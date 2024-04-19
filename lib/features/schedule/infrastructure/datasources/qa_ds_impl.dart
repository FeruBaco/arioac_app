import 'package:arioac_app/features/schedule/domain/datasources/qa_ds.dart';
import 'package:arioac_app/features/schedule/domain/entities/qa.dart';
import 'package:arioac_app/features/schedule/infrastructure/mapper/mapper.dart';
import 'package:dio/dio.dart';

import '../../../../config/config.dart';

class QADatasourceImpl extends QADatasource {
  late final Dio dio;
  final String accessToken;

  QADatasourceImpl({required this.accessToken})
      : dio = Dio(
          BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );

  @override
  Future<List<QA>> getQuestionsByPage({
    int limit = 10,
    int offset = 1,
    required String conferenceId,
  }) async {
    try {
      final response = await dio.get('/questions/$conferenceId?page=$offset');
      final List<QA> qas = [];
      final responseData = response.data;
      for (final qa in responseData['data'] ?? []) {
        qas.add(QAMapper.jsonToEntity(qa));
      }
      return qas;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<List<QA>> getSpeakerQuestionsByPage({
    int limit = 10,
    int offset = 1,
  }) async {
    try {
      final response = await dio.get('/speaker/questions?page=$offset');
      final List<QA> qas = [];
      final data = response.data['data'];
      for (final qa in data ?? []) {
        qas.add(QAMapper.jsonToEntity(qa));
      }
      return qas;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<QA> uploadQuestion({
    required String question,
    required String conferenceId,
  }) async {
    try {
      final response = await dio.post('/questions',
          data: {'question': question, 'conferenceId': conferenceId});
      final qa = QAMapper.jsonToEntity(response.data);
      return qa;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<QA> uploadAnswer(
      {required String answer, required String questionId}) async {
    try {
      final response =
          await dio.put('/questions/$questionId', data: {'answer': answer});
      final qa = QAMapper.jsonToEntity(response.data);
      return qa;
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<QA> voteQuestion({required String questionId}) async {
    try {
      final response = await dio.put('/vote/questions/$questionId');
      final qa = QAMapper.jsonToEntity(response.data);
      return qa;
    } catch (e) {
      throw Exception(e);
    }
  }
}
