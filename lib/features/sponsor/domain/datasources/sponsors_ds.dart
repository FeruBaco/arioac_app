import '../entities/entities.dart';

abstract class SponsorsDatasource {
  Future<List<Sponsor>> getSponsorsByPage({int limit = 12, offset = 1});
  Future<Sponsor> getSponsorById(String id);
  Future<List<Winner>> getWinnerList();
  Future<List<SponsorUser>> getUsersByPage({int limit = 20, offset = 1});
  Future<SponsorUser> addUserToList(String userId);
  Future<SponsorUser> removeUserToList(String userId);
  Future<SponsorUser> doLottery();
  Future getUserList();
}
