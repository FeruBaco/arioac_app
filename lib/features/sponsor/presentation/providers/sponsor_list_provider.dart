import 'package:arioac_app/features/sponsor/domain/domain.dart';
import 'package:arioac_app/features/sponsor/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/domain/entities/forms.dart';

class SponsorListState {
  final bool isLoading;
  final bool isPageLoading;
  final bool isLastPage;
  final FormStatus isAdding;
  final int offset;
  final int limit;
  final List<SponsorUser> users;
  final String errMsg;
  final SponsorUser? winner;

  SponsorListState({
    this.isLoading = false,
    this.isPageLoading = false,
    this.isLastPage = false,
    this.isAdding = FormStatus.empty,
    this.limit = 10,
    this.offset = 1,
    this.users = const [],
    this.winner,
    this.errMsg = '',
  });

  SponsorListState copyWith({
    bool? isLoading,
    bool? isPageLoading,
    bool? isLastPage,
    FormStatus? isAdding,
    int? offset,
    int? limit,
    List<SponsorUser>? users,
    SponsorUser? winner,
    String? errMsg,
  }) =>
      SponsorListState(
        isLoading: isLoading ?? this.isLoading,
        isPageLoading: isPageLoading ?? this.isPageLoading,
        isLastPage: isLastPage ?? this.isLastPage,
        isAdding: isAdding ?? this.isAdding,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
        users: users ?? this.users,
        winner: winner ?? this.winner,
        errMsg: errMsg ?? this.errMsg,
      );
}

class SponsorListNotifier extends StateNotifier<SponsorListState> {
  final SponsorsRepository sponsorsRepository;

  SponsorListNotifier({required this.sponsorsRepository})
      : super(SponsorListState()) {
    loadNextPage();
  }

  Future<void> pullRefresh() async {
    restart();
    state = state.copyWith(
      users: [],
      isLastPage: false,
      isLoading: false,
      offset: 1,
    );
    await loadNextPage();
  }

  void changeEmptyFormStatus() {
    state = state.copyWith(isAdding: FormStatus.empty);
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) {
      return;
    }

    if (state.users.isEmpty) {
      state = state.copyWith(isLoading: true, isPageLoading: true);
    } else {
      state = state.copyWith(isLoading: true);
    }

    final List<SponsorUser> users = await sponsorsRepository.getUsersByPage(
      limit: state.limit,
      offset: state.offset,
    );

    if (users.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        isLastPage: true,
        isPageLoading: false,
      );
      return;
    }

    state = state.copyWith(
      isLastPage: false,
      isLoading: false,
      isPageLoading: false,
      offset: state.offset + 1,
      users: [...state.users, ...users],
    );
  }

  Future<void> addUserToList(String userId) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, isAdding: FormStatus.checking);

    try {
      final SponsorUser response =
          await sponsorsRepository.addUserToList(userId);
      state = state.copyWith(
        isLoading: false,
        users: [...state.users, response],
        isAdding: FormStatus.success,
      );
      changeEmptyFormStatus();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        isAdding: FormStatus.failed,
        errMsg: e.toString(),
      );
      changeEmptyFormStatus();
    }
  }

  Future<void> doLottery() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final winner = await sponsorsRepository.doLottery();
      state = state.copyWith(isLoading: false, winner: winner);
    } catch (e) {
      state = state.copyWith(isLoading: false, errMsg: e.toString());
    }
  }

  Future<String> generateCSV() async {
    try {
      final url = await sponsorsRepository.generateCSV();
      state = state.copyWith(
        isLoading: false,
      );
      return url;
    } catch (e) {
      return '';
    }
  }

  Future<void> registerWinner(String userId) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, isAdding: FormStatus.checking);

    try {
      await sponsorsRepository.registerWinner(userId);
      state = state.copyWith(
          isLoading: false, winner: null, isAdding: FormStatus.success);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errMsg: e.toString(),
        isAdding: FormStatus.failed,
      );
    }
  }

  void restart() {
    state = state.copyWith(isAdding: FormStatus.checking);
  }
}

final sponsorListProvider =
    StateNotifierProvider<SponsorListNotifier, SponsorListState>((ref) {
  final sponsorsRepository = ref.watch(sponsorsRepositoryProvider);

  return SponsorListNotifier(sponsorsRepository: sponsorsRepository);
});
