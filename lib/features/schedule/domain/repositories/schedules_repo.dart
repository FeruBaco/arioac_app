import '../entities/entities.dart';

abstract class SchedulesRepository {
  Future<List<Schedule>> getScheduleByPage({int limit = 10, offset = 1});
  Future<Conference> getConferenceById(String id);
  Future<bool> sendSurvey(
      String content, String topic, String comment, String conferenceId);
}
