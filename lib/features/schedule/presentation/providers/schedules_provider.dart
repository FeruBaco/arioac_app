import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:arioac_app/features/schedule/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScheduleState {
  final bool isLastPage;
  final int limit;
  final int offset;
  final bool isLoading;
  final List<Schedule> schedules;
  final bool isPageLoading;

  ScheduleState({
    this.isLastPage = false,
    this.limit = 10,
    this.offset = 1,
    this.isLoading = false,
    this.isPageLoading = false,
    this.schedules = const [],
  });

  ScheduleState copyWith({
    bool? isLastPage,
    int? limit,
    int? offset,
    bool? isLoading,
    bool? isPageLoading,
    List<Schedule>? schedules,
  }) =>
      ScheduleState(
        isLastPage: isLastPage ?? this.isLastPage,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        isLoading: isLoading ?? this.isLoading,
        isPageLoading: isPageLoading ?? this.isPageLoading,
        schedules: schedules ?? this.schedules,
      );
}

class ScheduleNotifier extends StateNotifier<ScheduleState> {
  final SchedulesRepository schedulesRepository;

  ScheduleNotifier({required this.schedulesRepository})
      : super(ScheduleState()) {
    loadNextPage();
  }

  Future loadNextPage() async {
    if (state.isLoading || state.isLastPage) return;

    if (state.schedules.isEmpty) {
      state = state.copyWith(isLoading: true, isPageLoading: true);
    } else {
      state = state.copyWith(isLoading: true);
    }

    final List<Schedule> schedules =
        await schedulesRepository.getScheduleByPage(
      limit: state.limit,
      offset: state.offset,
    );

    if (schedules.isEmpty) {
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
      offset: state.offset + 1,
      schedules: [...state.schedules, ...schedules],
      isPageLoading: false,
    );
  }

  Future<bool> sendSurvey(
    String content,
    String topic,
    String comment,
    String conferenceId,
  ) async {
    try {
      final survey = await schedulesRepository.sendSurvey(
        content,
        topic,
        comment,
        conferenceId,
      );
      return survey;
    } catch (e) {
      print(e);
      return false;
    }
  }
}

final schedulesProvider =
    StateNotifierProvider<ScheduleNotifier, ScheduleState>((ref) {
  final schedulesRepository = ref.watch(schedulesRepositoryProvider);

  return ScheduleNotifier(schedulesRepository: schedulesRepository);
});
