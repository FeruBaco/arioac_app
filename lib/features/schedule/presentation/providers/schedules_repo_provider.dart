import 'package:arioac_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:arioac_app/features/schedule/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final schedulesRepositoryProvider = Provider<SchedulesRepository>(
  (ref) {
    final accesToken = ref.watch(authProvider).user?.token ?? '';

    final schedulesRepository = SchedulesRepositoryImpl(
      SchedulesDatasourceImpl(accessToken: accesToken),
    );

    return schedulesRepository;
  },
);
