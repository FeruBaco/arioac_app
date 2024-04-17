import 'package:arioac_app/features/schedule/presentation/providers/qa_provider.dart';
import 'package:arioac_app/features/shared/domain/entities/forms.dart';
import 'package:arioac_app/features/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

class QuestionFormState {
  final bool isPosting;
  final FormStatus isFormPosted;
  final bool isValid;
  final RequiredText question;
  final String conferenceId;

  QuestionFormState({
    this.isPosting = false,
    this.isFormPosted = FormStatus.checking,
    this.isValid = false,
    this.question = const RequiredText.pure(),
    this.conferenceId = '',
  });

  QuestionFormState copyWith({
    bool? isPosting,
    FormStatus? isFormPosted,
    bool? isValid,
    RequiredText? question,
    String? conferenceId,
  }) =>
      QuestionFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        question: question ?? this.question,
        conferenceId: conferenceId ?? this.conferenceId,
      );

  @override
  String toString() {
    return '''
    LoginFormState:
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      question: $question
      conferenceId: $conferenceId
    ''';
  }
}

class QuestionFormNotifier extends StateNotifier<QuestionFormState> {
  final Function(String, String) questionCallback;

  QuestionFormNotifier({
    required this.questionCallback,
  }) : super(QuestionFormState());

  onCommentChange(String value) {
    final question = RequiredText.dirty(value);
    state = state.copyWith(
      question: question,
      isValid: Formz.validate(
        [state.question],
      ),
    );
  }

  onFormSubmit(String conferenceId) async {
    _touchEveryField();
    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);
    try {
      await questionCallback(state.question.value, conferenceId);
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
    final question = RequiredText.dirty(state.question.value);

    state = state.copyWith(
      isFormPosted: FormStatus.checking,
      question: question,
      isValid: Formz.validate([question]),
    );
  }

  setConference(String conferenceId) {
    state = state.copyWith(conferenceId: conferenceId);
  }

  updateFormStatus() {
    state = state.copyWith(isFormPosted: FormStatus.checking);
  }
}

final questionFormProvider =
    StateNotifierProvider.autoDispose<QuestionFormNotifier, QuestionFormState>(
        (ref) {
  final questionCallback = ref.watch(qaProvider.notifier).uploadQuestion;

  return QuestionFormNotifier(questionCallback: questionCallback);
});
