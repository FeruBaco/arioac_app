import 'package:arioac_app/features/sponsor/domain/entities/social_media.dart';

class Sponsor {
  String id;
  String name;
  String logo;
  List<String> phones;
  List<SocialMedia> socialMedia;

  Sponsor({
    required this.id,
    required this.name,
    required this.logo,
    required this.phones,
    required this.socialMedia,
  });
}
