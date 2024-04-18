import 'package:arioac_app/features/auth/domain/entities/user.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
        id: json['id'],
        companyName: json['companyName'] ?? '',
        userId: json['userId'],
        userPhone: json['phone'] ?? '',
        userName: json['name'],
        userEmail: json['email'],
        userGender: json['gender'] ?? '',
        userJobPosition: json['jobTitle'] ?? '',
        config: json['config'] ?? '',
        token: json['token'] ?? '',
        paymentStatus: json['paymentStatus'] ?? 'Desconocido',
        role: switch (json['role']) {
          'user' => Role.user,
          'sponsor' => Role.sponsor,
          'speaker' => Role.speaker,
          'admin' => Role.admin,
          Object() => Role.user,
          null => Role.user,
        },
        hasFood: json['hasFood'] ?? false,
      );
}
