import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
  Future<User> checkAuthStatus(String token);
  Future<User> getUserById(String id, String token);
  Future<String> getCertificate(String token);
}
