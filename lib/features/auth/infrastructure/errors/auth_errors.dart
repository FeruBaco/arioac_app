class WrongCredentials implements Exception {}

class ConnectionTimeout implements Exception {}

class AuthException implements Exception {
  final String msg;

  AuthException(this.msg);
}
