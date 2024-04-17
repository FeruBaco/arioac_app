import 'package:arioac_app/features/shared/infrastructure/inputs/inputs.dart';

class SurveyAnswer {
  SimpleText topic;
  SimpleText content;
  SimpleText? comment;
  String conferenceId;
  String userId;

  SurveyAnswer({
    required this.topic,
    required this.content,
    this.comment = const SimpleText.pure(),
    required this.conferenceId,
    required this.userId,
  });
}
