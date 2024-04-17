import 'package:arioac_app/features/schedule/presentation/providers/schedules_provider.dart';
import 'package:arioac_app/features/shared/domain/entities/forms.dart';
import 'package:arioac_app/features/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

class SurveyFormState {
  final bool isPosting;
  final FormStatus isFormPosted;
  final bool isValid;
  final SimpleText content;
  final SimpleText topic;
  final SimpleText comment;
  final String conferenceId;

  SurveyFormState({
    this.isPosting = false,
    this.isFormPosted = FormStatus.checking,
    this.isValid = false,
    this.content = const SimpleText.pure(),
    this.topic = const SimpleText.pure(),
    this.comment = const SimpleText.pure(),
    this.conferenceId = '',
  });

  SurveyFormState copyWith({
    bool? isPosting,
    FormStatus? isFormPosted,
    bool? isValid,
    SimpleText? content,
    SimpleText? topic,
    SimpleText? comment,
    String? conferenceId,
  }) =>
      SurveyFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        content: content ?? this.content,
        topic: topic ?? this.topic,
        comment: comment ?? this.comment,
        conferenceId: conferenceId ?? this.conferenceId,
      );

  @override
  String toString() {
    return '''
    LoginFormState:
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      content: $content
      topic: $topic
      comment: $comment
      conferenceId: $conferenceId
    ''';
  }
}

class SurveyFormNotifier extends StateNotifier<SurveyFormState> {
  final Function(String, String, String, String) surveyCallback;

  SurveyFormNotifier({
    required this.surveyCallback,
  }) : super(SurveyFormState());

  onContentChange(String? value) {
    final content = SimpleText.dirty(value!);
    state = state.copyWith(
      content: content,
      isValid: Formz.validate(
        [content, state.topic, state.comment],
      ),
    );
  }

  onTopicChange(String? value) {
    final topic = SimpleText.dirty(value!);
    state = state.copyWith(
      topic: topic,
      isValid: Formz.validate(
        [topic, state.content, state.comment],
      ),
    );
  }

  onCommentChange(String value) {
    final comment = SimpleText.dirty(value);
    state = state.copyWith(
      comment: comment,
      isValid: Formz.validate(
        [comment, state.content, state.topic],
      ),
    );
  }

  setConference(String conferenceId) {
    state = state.copyWith(conferenceId: conferenceId);
  }

  updateFormStatus() {
    state = state.copyWith(isFormPosted: FormStatus.checking);
  }

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);
    try {
      await surveyCallback(
        state.content.value,
        state.topic.value,
        state.comment.value,
        state.conferenceId,
      );
      state = state.copyWith(
        isFormPosted: FormStatus.success,
        isPosting: false,
      );
      updateFormStatus();
    } catch (e) {
      state = state.copyWith(
        isFormPosted: FormStatus.failed,
        isPosting: false,
      );
    }
  }

  _touchEveryField() {
    final content = SimpleText.dirty(state.content.value);
    final topic = SimpleText.dirty(state.topic.value);
    final comment = SimpleText.dirty(state.comment.value);

    state = state.copyWith(
      isFormPosted: FormStatus.checking,
      content: content,
      topic: topic,
      comment: comment,
      isValid: Formz.validate([content, topic, comment]),
    );
  }
}

final surveyFormProvider =
    StateNotifierProvider.autoDispose<SurveyFormNotifier, SurveyFormState>(
        (ref) {
  final surveyCallback = ref.watch(schedulesProvider.notifier).sendSurvey;

  return SurveyFormNotifier(surveyCallback: surveyCallback);
});
