class QA {
  String id;
  String question;
  String answer;
  int votes;
  String userId;
  String conferenceId;
  bool userVoted;

  QA({
    required this.id,
    required this.question,
    required this.answer,
    required this.votes,
    required this.userId,
    required this.conferenceId,
    required this.userVoted,
  });
}
