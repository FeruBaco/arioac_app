import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/domain.dart';
import 'providers.dart';

class WinnersState {
  final bool isLoading;
  final List<Winner> winners;

  WinnersState({
    this.isLoading = false,
    this.winners = const [],
  });

  WinnersState copyWith({
    bool? isLoading,
    List<Winner>? winners,
  }) =>
      WinnersState(
        isLoading: isLoading ?? this.isLoading,
        winners: winners ?? this.winners,
      );
}

class WinnerNotifier extends StateNotifier<WinnersState> {
  final SponsorsRepository sponsorsRepository;

  WinnerNotifier({required this.sponsorsRepository}) : super(WinnersState()) {
    getWinners();
  }

  Future<void> getWinners() async {
    state = state.copyWith(isLoading: true);

    final winners = await sponsorsRepository.getWinnerList();

    state = state.copyWith(isLoading: false, winners: winners);
  }
}

final winnersProvider =
    StateNotifierProvider<WinnerNotifier, WinnersState>((ref) {
  final sponsorsRepository = ref.watch(sponsorsRepositoryProvider);

  return WinnerNotifier(sponsorsRepository: sponsorsRepository);
});
