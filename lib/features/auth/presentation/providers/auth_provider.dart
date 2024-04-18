import 'package:arioac_app/features/shared/infrastructure/services/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arioac_app/features/auth/domain/domain.dart';
import 'package:arioac_app/features/auth/infrastructure/infrastructure.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final storageService = StorageServiceImpl();

  return AuthNotifier(
      authRepository: authRepository, storageService: storageService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final StorageService storageService;

  AuthNotifier({required this.authRepository, required this.storageService})
      : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    try {
      final user = await authRepository.login(email, password);
      await _setLoggedUser(user);
    } on AuthException catch (e) {
      logout(e.msg);
    } catch (e) {
      logout('🤯 Ocurrio un error innesperado.');
    }
  }

  void checkAuthStatus() async {
    final token = await storageService.getValue<String>('token');
    if (token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      await _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  Future<void> _setLoggedUser(User user) async {
    await storageService.setKeyValue('token', user.token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async {
    await storageService.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }

  Future<void> getUserById(String id) async {
    state = state.copyWith(isUserCheckLoading: true, userCheckError: false);
    final token = await storageService.getValue<String>('token');
    try {
      if (token == null) {
        state = state.copyWith(userCheckError: true, isUserCheckLoading: false);
        return;
      }
      final user = await authRepository.getUserById(id, token);
      state = state.copyWith(userCheck: user, isUserCheckLoading: false);
    } catch (e) {
      state = state.copyWith(userCheckError: true, isUserCheckLoading: false);
    }
  }

  Future<String> getCertificate() async {
    final token = await storageService.getValue<String>('token');
    try {
      if (token != null) {
        final cert = await authRepository.getCertificate(token);
        return cert;
      }
    } catch (e) {}
    return '';
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;
  final User? userCheck;
  final bool userCheckError;
  final bool isUserCheckLoading;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
    this.userCheck,
    this.userCheckError = false,
    this.isUserCheckLoading = false,
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
    User? userCheck,
    bool? userCheckError,
    bool? isUserCheckLoading,
  }) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
        userCheck: userCheck ?? this.userCheck,
        userCheckError: userCheckError ?? this.userCheckError,
        isUserCheckLoading: isUserCheckLoading ?? this.isUserCheckLoading,
      );
}
