import '../../domain/domain.dart';

class ScheduleMapper {
  static jsonToEntity(Map<String, dynamic> json) => Schedule(
        id: json['id'],
        order: json['order'],
        type: switch (json['type']) {
          'conference' => ConferenceType.conference,
          'heading' => ConferenceType.heading,
          'simpleConference' => ConferenceType.simpleConference,
          'panel' => ConferenceType.panelConference,
          Object() => ConferenceType.conference,
          null => ConferenceType.conference,
        },
        title: json['title'],
        subtitle: json['subtitle'],
        concept: json['concept'] ?? '',
        hour: json['hour'],
        color: List<int>.from(json['color']),
        logoUrl: json['logo'] ?? '',
        logos: List<String>.from(json['logos'] ?? []),
        speakers: (json['speakers'] != null)
            ? List<ConferenceSpeaker>.from(
                json['speakers'].map(
                  (speaker) => ConferenceSpeaker(
                    name: speaker['name'],
                    jobTitle: speaker['jobTitle'],
                    semblance: speaker['semblance'],
                    photo: speaker['photo'],
                  ),
                ),
              )
            : [],
      );
}

class ConferenceMapper {
  static jsonToEntity(Map<String, dynamic> json) => Conference(
        id: json['id'],
        order: json['order'],
        type: switch (json['type']) {
          'conference' => ConferenceType.conference,
          'heading' => ConferenceType.heading,
          'simpleConference' => ConferenceType.simpleConference,
          'panel' => ConferenceType.panelConference,
          Object() => ConferenceType.conference,
          null => ConferenceType.conference,
        },
        hasSurvey: json['hasSurvey'] ?? false,
        title: json['title'],
        subtitle: json['subtitle'] ?? '',
        concept: json['concept'] ?? '',
        hour: json['hour'],
        color: List<int>.from(json['color']),
        logoUrl: json['logo'] ?? '',
        materialUrl: json['materialUrl'] ?? '',
        speakers: List<ConferenceSpeaker>.from(
          json['speakers'].map(
            (speaker) => ConferenceSpeaker(
              name: speaker['name'],
              jobTitle: speaker['jobTitle'],
              semblance: speaker['semblance'],
              photo: speaker['photo'],
            ),
          ),
        ),
      );
}

class QAMapper {
  static jsonToEntity(Map<String, dynamic> json) => QA(
        id: json['id'],
        question: json['question'],
        answer: json['answer'] ?? '',
        votes: json['votes'] ?? 0,
        userId: json['userQuestionId'],
        conferenceId: json['conferenceId'],
        userVoted: json['userVoted'] ?? false,
      );
}
