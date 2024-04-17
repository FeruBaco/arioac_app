import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:arioac_app/features/schedule/infrastructure/datasources/schedules_ds_impl.dart';

class SchedulesRepositoryImpl extends SchedulesRepository {
  final SchedulesDatasourceImpl datasource;

  SchedulesRepositoryImpl(this.datasource);

  @override
  Future<Conference> getConferenceById(String id) {
    return datasource.getConferenceById(id);
  }

  @override
  Future<List<Schedule>> getScheduleByPage({int limit = 10, offset = 1}) {
    return datasource.getScheduleByPage(limit: limit, offset: offset);
  }

  @override
  Future<bool> sendSurvey(
    String content,
    String topic,
    String comment,
    String conferenceId,
  ) {
    return datasource.sendSurvey(
      content,
      topic,
      comment,
      conferenceId,
    );
  }
}
