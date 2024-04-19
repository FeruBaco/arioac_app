import '../../domain/domain.dart';

class SponsorMapper {
  static jsonToEntity(Map<String, dynamic> json) => Sponsor(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      phones: json['phones'] == null
          ? []
          : List<String>.from(
              json['phones'].map((phone) => phone),
            ),
      socialMedia: json['socialMedia'] == null
          ? []
          : List<SocialMedia>.from(
              json['socialMedia'].map(
                (socialMedia) => SocialMedia(
                  platform: socialMedia['platform'],
                  url: socialMedia['url'],
                ),
              ),
            ));
}

class WinnerMapper {
  static jsonToEntity(Map<String, dynamic> json) => Winner(
        giveawayId: json['giveawayId'],
        userName: json['userName'],
        sponsorName: json['sponsorName'],
      );
}

class SponsorListMapper {
  static jsonToEntity(Map<String, dynamic> json) => SponsorUser(
        id: json['id'],
        companyName: json['companyName'] ?? '',
        userName: json['name'],
        userPhone: json['phone'],
        userEmail: json['email'],
        userJobPosition: json['userJobPosition'] ?? '',
      );
}
