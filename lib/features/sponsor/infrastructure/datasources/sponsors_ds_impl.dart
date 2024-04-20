import 'package:arioac_app/config/environment.dart';
import 'package:arioac_app/features/auth/infrastructure/infrastructure.dart';
import 'package:arioac_app/features/sponsor/domain/domain.dart';
import 'package:arioac_app/features/sponsor/infrastructure/mapper/mapper.dart';
import 'package:dio/dio.dart';

class SponsorsDatasourceImpl extends SponsorsDatasource {
  late final Dio dio;
  final String accessToken;

  SponsorsDatasourceImpl({required this.accessToken})
      : dio = Dio(BaseOptions(
          baseUrl: Environment.apiUrl,
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ));

  @override
  Future<SponsorUser> addUserToList(String userId) async {
    try {
      final response = await dio.post(
        '/sponsors/participant',
        data: {'userId': userId},
      );
      final user = SponsorListMapper.jsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      int? statusCode = e.response?.statusCode;
      if (statusCode == 409) {
        throw Exception('😰 Ups! No se pudo registrar participante');
      }
      throw Exception();
    } catch (e) {
      throw Exception('😰 Ups! Error al agregar participante');
    }
  }

  @override
  Future<SponsorUser> doLottery() async {
    try {
      final response = await dio.get('/participants/winner');
      final user = SponsorListMapper.jsonToEntity(response.data);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Sponsor> getSponsorById(String id) {
    // TODO: This endpoint is not required
    throw UnimplementedError();
  }

  @override
  Future<List<Sponsor>> getSponsorsByPage({int limit = 12, offset = 1}) async {
    final response = await dio.get('/sponsors?page=$offset');
    final List<Sponsor> sponsors = [];
    final responseData = response.data;
    for (final sponsor in responseData['data'] ?? []) {
      sponsors.add(SponsorMapper.jsonToEntity(sponsor));
    }

    return sponsors;
  }

  @override
  Future getUserList() {
    // TODO: implement getUserList
    throw UnimplementedError();
  }

  @override
  Future<List<SponsorUser>> getUsersByPage({int limit = 20, offset}) async {
    try {
      final response = await dio.get(
        '/sponsors/participants?page=$offset',
      );

      final List<SponsorUser> users = [];
      final responseData = response.data['data'];
      for (final user in responseData ?? []) {
        users.add(SponsorListMapper.jsonToEntity(user));
      }
      return users;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<Winner>> getWinnerList() async {
    final response = await dio.get('/sponsors/winners');
    final List<Winner> winners = [];
    for (final winner in response.data ?? []) {
      winners.add(WinnerMapper.jsonToEntity(winner));
    }

    return winners;
  }

  @override
  Future<SponsorUser> registerWinner() async {
    try {
      final response = await dio.post('/participants/winner');
      final user = SponsorListMapper.jsonToEntity(response.data);
      return user;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SponsorUser> removeUserToList(String userId) {
    // TODO: implement removeUserToList
    throw UnimplementedError();
  }
}
