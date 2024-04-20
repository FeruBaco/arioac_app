class SponsorUser {
  final String id;
  final String? shortId;
  final String? companyName;
  final String userName;
  final String userPhone;
  final String userEmail;
  final String? userJobPosition;
  final bool? isWinner;

  const SponsorUser({
    required this.id,
    this.shortId,
    this.companyName,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    this.userJobPosition,
    this.isWinner,
  });
}
