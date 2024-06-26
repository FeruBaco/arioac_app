import 'package:arioac_app/config/environment.dart';
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
      final data = response.data['data'];
      final user = SponsorListMapper.jsonToEntity(data);
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
  Future<String> generateCSV() async {
    try {
      final response = await dio.get('/export/participants');
      return response.data['url'];
    } catch (e) {
      throw Exception('😰 Ups! Error al agregar participante');
    }
  }

  @override
  Future<SponsorUser> doLottery() async {
    try {
      final response = await dio.get('/participants/winner');
      final data = response.data['data'];
      final user = SponsorListMapper.jsonToEntity(data);
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
    try {
      final response = await dio.get('/giveaway/winners');
      final List<Winner> winners = [];
      final data = response.data['data'];
      for (final winner in data) {
        winners.add(WinnerMapper.jsonToEntity(winner));
      }
      return winners;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<SponsorUser> registerWinner(String userId) async {
    try {
      final response =
          await dio.post('/participants/winner', data: {'userId': userId});
      final data = response.data['data'];
      final user = SponsorListMapper.jsonToEntity(data);
      return user;
    } on DioException catch (e) {
      int? statusCode = e.response?.statusCode;
      if (statusCode == 409) {
        throw Exception('😰 Ups! Este participante ya gano.');
      }
      throw Exception('😰 Ups! Algo salio mal.');
    } catch (e) {
      throw Exception('😰 Ups! Algo salio mal.');
    }
  }

  @override
  Future<SponsorUser> removeUserToList(String userId) {
    // TODO: implement removeUserToList
    throw UnimplementedError();
  }
}
