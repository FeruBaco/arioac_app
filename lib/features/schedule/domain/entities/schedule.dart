import 'conference.dart';

class Schedule {
  String id;
  int order;
  ConferenceType type;
  String title;
  String? subtitle;
  String? concept;
  String hour;
  List<int> color;
  String? logoUrl;
  List<String>? logos;
  List<ConferenceSpeaker> speakers;

  Schedule({
    required this.id,
    required this.order,
    required this.type,
    required this.title,
    this.subtitle,
    this.concept,
    required this.hour,
    required this.color,
    this.logoUrl,
    this.logos,
    required this.speakers,
  });
}
