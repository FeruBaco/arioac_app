import 'package:arioac_app/features/auth/infrastructure/errors/auth_errors.dart';
import 'package:arioac_app/features/auth/infrastructure/mappers/user_mapper.dart';
import 'package:dio/dio.dart';
import 'package:arioac_app/config/environment.dart';
import 'package:arioac_app/features/auth/domain/domain.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
  ));

  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.post(
        '/auth/check',
        data: {'token': token},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthException('⚠️ Token incorrecto');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthException('⚠️ Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw AuthException('⚠️ Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> getUserById(String id, String token) async {
    try {
      final response = await dio.get(
        '/users/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw AuthException('⚠️ Token incorrecto');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<String> getCertificate(String token) async {
    try {
      final response = await dio.get(
        '/certificate',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      final data = response.data;
      return data['diplomaUrl'];
    } catch (e) {
      return '';
    }
  }
}
