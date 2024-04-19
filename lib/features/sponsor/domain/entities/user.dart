class SponsorUser {
  final String id;
  final String? companyName;
  final String userName;
  final String userPhone;
  final String userEmail;
  final String? userJobPosition;

  const SponsorUser({
    required this.id,
    this.companyName,
    required this.userName,
    required this.userPhone,
    required this.userEmail,
    this.userJobPosition,
  });
}
