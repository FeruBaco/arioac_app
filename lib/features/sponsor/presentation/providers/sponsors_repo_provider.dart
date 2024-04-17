import 'package:arioac_app/features/sponsor/domain/domain.dart';
import 'package:arioac_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:arioac_app/features/sponsor/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sponsorsRepositoryProvider = Provider<SponsorsRepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final sponsorsRepository =
      SponsorsRepositoryImpl(SponsorsDatasourceImpl(accessToken: accessToken));

  return sponsorsRepository;
});
