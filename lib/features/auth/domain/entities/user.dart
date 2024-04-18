enum Role { user, sponsor, speaker, admin }

class User {
  final String id;
  final String companyName;
  final String userId;
  final String userName;
  final String userPhone;
  final String userEmail;
  final String userGender;
  final String userJobPosition;
  final String config;
  final String token;
  final Role role;
  final bool hasFood;
  final String paymentStatus;

  const User({
    required this.id,
    required this.companyName,
    required this.userId,
    required this.userName,
    this.userPhone = '',
    required this.userEmail,
    this.userGender = '',
    this.userJobPosition = '',
    required this.config,
    required this.token,
    this.role = Role.user,
    this.hasFood = false,
    this.paymentStatus = 'Desconocido',
  });

  @override
  String toString() {
    return '$userName, $role';
  }

  bool get isAdmin {
    return (role == Role.admin) ? true : false;
  }

  bool get isSponsor {
    return (role == Role.sponsor) ? true : false;
  }
}
