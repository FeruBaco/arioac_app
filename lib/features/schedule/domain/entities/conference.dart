enum ConferenceType { heading, conference, simpleConference, panelConference }

class Conference {
  String id;
  int order;
  ConferenceType type;
  bool hasSurvey;
  String title;
  String? subtitle;
  String? concept;
  String hour;
  List<int> color;
  String? logoUrl;
  String materialUrl;
  List<ConferenceSpeaker> speakers;

  Conference({
    required this.id,
    required this.order,
    required this.type,
    this.hasSurvey = false,
    required this.title,
    this.subtitle,
    this.concept,
    required this.hour,
    required this.color,
    required this.logoUrl,
    required this.materialUrl,
    required this.speakers,
  });
}

class ConferenceSpeaker {
  String name;
  String jobTitle;
  String semblance;
  String photo;

  ConferenceSpeaker({
    required this.name,
    required this.jobTitle,
    required this.semblance,
    required this.photo,
  });
}
