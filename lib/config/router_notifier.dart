import 'package:arioac_app/features/auth/domain/domain.dart';
import 'package:arioac_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);
  return RouterNotifier(authNotifier);
});

class RouterNotifier extends ChangeNotifier {
  final AuthNotifier _authNotifier;

  AuthStatus _authStatus = AuthStatus.checking;
  Role _role = Role.user;

  RouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
      role = state.user?.role ?? Role.user;
    });
  }

  AuthStatus get authStatus => _authStatus;
  Role get role => _role;

  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }

  set role(Role value) {
    _role = value;
    notifyListeners();
  }
}
