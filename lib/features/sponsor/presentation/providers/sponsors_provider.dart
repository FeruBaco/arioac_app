import 'package:arioac_app/features/sponsor/presentation/providers/sponsors_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:arioac_app/features/sponsor/domain/domain.dart';

class SponsorsState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Sponsor> sponsors;

  SponsorsState({
    this.isLastPage = false,
    this.limit = 18,
    this.offset = 1,
    this.isLoading = false,
    this.sponsors = const [],
  });

  SponsorsState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    List<Sponsor>? sponsors,
  }) =>
      SponsorsState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        sponsors: sponsors ?? this.sponsors,
      );
}

class SponsorNotifier extends StateNotifier<SponsorsState> {
  final SponsorsRepository sponsorsRepository;

  SponsorNotifier({required this.sponsorsRepository}) : super(SponsorsState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    state = state.copyWith(isLoading: true);

    final sponsors = await sponsorsRepository.getSponsorsByPage(
      limit: state.limit,
      offset: state.offset,
    );

    if (sponsors.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true,
      );
      return;
    }

    state = state.copyWith(
        isLastPage: false,
        isLoading: false,
        offset: state.offset + 1,
        sponsors: [...state.sponsors, ...sponsors]);
  }
}

final sponsorsProvider =
    StateNotifierProvider<SponsorNotifier, SponsorsState>((ref) {
  final sponsorsRepository = ref.watch(sponsorsRepositoryProvider);

  return SponsorNotifier(sponsorsRepository: sponsorsRepository);
});
