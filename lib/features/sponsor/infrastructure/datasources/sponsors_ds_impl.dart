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
  Future<List<Winner>> getWinnerList() async {
    final response = await dio.get('/sponsors/winners');
    final List<Winner> winners = [];
    for (final winner in response.data ?? []) {
      winners.add(WinnerMapper.jsonToEntity(winner));
    }

    return winners;
  }

  @override
  Future<SponsorUser> addUserToList(String userId) async {
    try {
      final response = await dio.post(
        '/sponsors/users',
        data: {'userId': userId},
      );
      final user = SponsorListMapper.jsonToEntity(response.data);
      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<SponsorUser> doLottery() {
    // TODO: implement doLottery
    throw UnimplementedError();
  }

  @override
  Future getUserList() {
    // TODO: implement getUserList
    throw UnimplementedError();
  }

  @override
  Future<List<SponsorUser>> getUsersByPage({int limit = 20, offset = 1}) async {
    try {
      final response = await dio.get(
        '/sponsors/users?_page=$offset&_limit=$limit&_sort=votes&_order=desc',
      );

      final List<SponsorUser> users = [];
      for (final user in response.data ?? []) {
        users.add(SponsorListMapper.jsonToEntity(user));
      }
      return users;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<SponsorUser> removeUserToList(String userId) {
    // TODO: implement removeUserToList
    throw UnimplementedError();
  }
}
