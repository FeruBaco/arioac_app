import 'package:arioac_app/features/sponsor/domain/domain.dart';

class SponsorsRepositoryImpl extends SponsorsRepository {
  final SponsorsDatasource datasource;

  SponsorsRepositoryImpl(this.datasource);

  @override
  Future<Sponsor> getSponsorById(String id) {
    return datasource.getSponsorById(id);
  }

  @override
  Future<List<Sponsor>> getSponsorsByPage({int limit = 12, offset = 1}) {
    return datasource.getSponsorsByPage(limit: limit, offset: offset);
  }

  @override
  Future<List<Winner>> getWinnerList() {
    return datasource.getWinnerList();
  }

  @override
  Future<SponsorUser> addUserToList(String userId) {
    return datasource.addUserToList(userId);
  }

  @override
  Future<SponsorUser> doLottery() {
    return datasource.doLottery();
  }

  @override
  Future getUserList() {
    return datasource.getUserList();
  }

  @override
  Future<List<SponsorUser>> getUsersByPage({int limit = 20, offset = 1}) {
    return datasource.getUsersByPage();
  }

  @override
  Future<SponsorUser> removeUserToList(String userId) {
    return datasource.removeUserToList(userId);
  }
}
