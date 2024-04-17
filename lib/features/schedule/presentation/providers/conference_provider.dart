import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:arioac_app/features/schedule/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConferenceState {
  final String id;
  final Conference? conference;
  final bool isLoading;

  ConferenceState({
    required this.id,
    this.conference,
    this.isLoading = true,
  });

  ConferenceState copyWith({
    String? id,
    Conference? conference,
    bool? isLoading,
  }) =>
      ConferenceState(
        id: id ?? this.id,
        conference: conference ?? this.conference,
        isLoading: isLoading ?? this.isLoading,
      );
}

class ConferenceNotifier extends StateNotifier<ConferenceState> {
  final SchedulesRepository schedulesRepository;

  ConferenceNotifier({
    required this.schedulesRepository,
    required String conferenceId,
  }) : super(ConferenceState(id: conferenceId)) {
    loadConference();
  }

  Future<void> loadConference() async {
    try {
      final conference = await schedulesRepository.getConferenceById(state.id);
      state = state.copyWith(isLoading: false, conference: conference);
    } catch (e) {
      print(e);
    }
  }
}

final conferenceProvider = StateNotifierProvider.autoDispose
    .family<ConferenceNotifier, ConferenceState, String>(
  (ref, conferenceId) {
    final schedulesRepository = ref.watch(schedulesRepositoryProvider);

    return ConferenceNotifier(
        schedulesRepository: schedulesRepository, conferenceId: conferenceId);
  },
);
