import 'package:arioac_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:arioac_app/features/schedule/domain/repositories/qa_repo.dart';
import 'package:arioac_app/features/schedule/infrastructure/datasources/qa_ds_impl.dart';
import 'package:arioac_app/features/schedule/infrastructure/repositories/qa_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final qaRepositoryProvider = Provider<QARepository>((ref) {
  final accessToken = ref.watch(authProvider).user?.token ?? '';

  final qaRepository = QARepositoryImpl(
    QADatasourceImpl(accessToken: accessToken),
  );

  return qaRepository;
});
