import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:arioac_app/features/schedule/domain/repositories/qa_repo.dart';
import 'package:arioac_app/features/schedule/presentation/providers/qa_repo_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QAState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final bool isPageLoading;
  final String conferenceId;
  final List<QA> qas;

  QAState({
    this.isLastPage = false,
    this.isLoading = false,
    this.isPageLoading = false,
    this.limit = 10,
    this.offset = 1,
    this.qas = const [],
    this.conferenceId = '',
  });

  QAState copyWith({
    bool? isLastPage,
    bool? isLoading,
    bool? isPageLoading,
    int? limit,
    int? offset,
    String? conferenceId,
    List<QA>? qas,
  }) =>
      QAState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        isPageLoading: isPageLoading ?? this.isPageLoading,
        qas: qas ?? this.qas,
        conferenceId: conferenceId ?? this.conferenceId,
      );
}

class QANotifier extends StateNotifier<QAState> {
  final QARepository qaRepository;

  QANotifier({required this.qaRepository}) : super(QAState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage || state.conferenceId.isEmpty) {
      return;
    }

    if (state.qas.isEmpty) {
      state = state.copyWith(isLoading: true, isPageLoading: true);
    } else {
      state = state.copyWith(isLoading: true);
    }

    final List<QA> qas = await qaRepository.getQuestionsByPage(
      limit: state.limit,
      offset: state.offset,
      conferenceId: state.conferenceId,
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

  Future voteQuestion(String questionId) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      await qaRepository.voteQuestion(questionId: questionId);
      final QA newQA = state.qas.firstWhere(
        (element) => element.id == questionId,
      );
      final int qaIndex = state.qas.indexOf(newQA);
      state.qas.removeAt(qaIndex);
      newQA.votes++;
      newQA.userVoted = true;
      state.qas.add(newQA);
      state.qas.sort((a, b) => b.votes.compareTo(a.votes));
      state = state.copyWith(isLoading: false, qas: [...state.qas]);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void setConference(String conferenceId) {
    state = state.copyWith(
      conferenceId: conferenceId,
      qas: [],
      isLastPage: false,
      isLoading: false,
      offset: 1,
    );
    loadNextPage();
  }

  Future<void> pullRefresh() async {
    state =
        state.copyWith(qas: [], isLastPage: false, isLoading: false, offset: 1);
    await loadNextPage();
  }

  Future<void> uploadQuestion(String question, String conferenceId) async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final QA response = await qaRepository.uploadQuestion(
        question: question,
        conferenceId: conferenceId,
      );
      state.qas.add(response);
      state.qas.sort((a, b) => b.votes.compareTo(a.votes));
      state = state.copyWith(isLoading: false, qas: [...state.qas]);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}

final qaProvider = StateNotifierProvider<QANotifier, QAState>((ref) {
  final qaRepository = ref.watch(qaRepositoryProvider);

  return QANotifier(qaRepository: qaRepository);
});
