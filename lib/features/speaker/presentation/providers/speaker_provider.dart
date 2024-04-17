import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:arioac_app/features/schedule/domain/repositories/qa_repo.dart';
import 'package:arioac_app/features/schedule/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SpeakerState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final bool isPageLoading;
  final List<QA> qas;

  SpeakerState({
    this.isLastPage = false,
    this.isLoading = false,
    this.isPageLoading = false,
    this.limit = 10,
    this.offset = 1,
    this.qas = const [],
  });

  SpeakerState copyWith({
    bool? isLastPage,
    bool? isLoading,
    bool? isPageLoading,
    int? limit,
    int? offset,
    List<QA>? qas,
  }) =>
      SpeakerState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        isPageLoading: isPageLoading ?? this.isPageLoading,
        qas: qas ?? this.qas,
      );
}

class SpeakerNotifier extends StateNotifier<SpeakerState> {
  final QARepository qaRepository;

  SpeakerNotifier({required this.qaRepository}) : super(SpeakerState()) {
    loadNextPage();
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || state.isLastPage) {
      return;
    }

    if (state.qas.isEmpty) {
      state = state.copyWith(isLoading: true, isPageLoading: true);
    } else {
      state = state.copyWith(isLoading: true);
    }

    final List<QA> qas = await qaRepository.getSpeakerQuestionsByPage(
      limit: state.limit,
      offset: state.offset,
    );

    if (qas.isEmpty) {
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
      qas: [...state.qas, ...qas],
    );
  }

  Future<void> pullRefresh() async {
    state =
        state.copyWith(qas: [], isLastPage: false, isLoading: false, offset: 1);
    await loadNextPage();
  }

  Future<void> uploadAnswer(String questionId, String answer) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final QA response = await qaRepository.uploadAnswer(
        answer: answer,
        questionId: questionId,
      );
      state.qas.add(response);
      state.qas.sort((a, b) => b.votes.compareTo(a.votes));
      state = state.copyWith(isLoading: false, qas: [...state.qas]);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

final speakerProvider =
    StateNotifierProvider<SpeakerNotifier, SpeakerState>((ref) {
  final qaRepository = ref.watch(qaRepositoryProvider);

  return SpeakerNotifier(qaRepository: qaRepository);
});
