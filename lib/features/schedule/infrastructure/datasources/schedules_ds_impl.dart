import 'package:arioac_app/config/environment.dart';
import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:dio/dio.dart';

import '../mapper/mapper.dart';

class SchedulesDatasourceImpl extends ScheduleDatasource {
  late final Dio dio;
  final String accessToken;

  SchedulesDatasourceImpl({required this.accessToken})
      : dio = Dio(
          BaseOptions(
            baseUrl: Environment.apiUrl,
            headers: {
              'Authorization': 'Bearer $accessToken',
            },
          ),
        );

  @override
  Future<List<Schedule>> getScheduleByPage({int limit = 10, offset = 1}) async {
    final response = await dio.get('/conferences?page=$offset');
    final List<Schedule> schedules = [];
    final responseData = response.data;
    for (final schedule in responseData['data'] ?? []) {
      schedules.add(ScheduleMapper.jsonToEntity(schedule));
    }

    return schedules;
  }

  @override
  Future<Conference> getConferenceById(String id) async {
    try {
      final response = await dio.get('/conferences/$id');
      final conference = ConferenceMapper.jsonToEntity(response.data);
      return conference;
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) throw Exception();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<bool> sendSurvey(
    String content,
    String topic,
    String comment,
    String conferenceId,
  ) async {
    try {
      await dio.post(
        '/conferences/survey',
        data: {
          'content': content,
          'topic': topic,
          'comment': comment ?? '',
          'conferenceId': conferenceId
        },
      );
      return true;
    } catch (e) {
      return false;
    }
  }
}
