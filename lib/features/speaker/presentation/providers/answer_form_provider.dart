import 'package:arioac_app/features/schedule/presentation/providers/providers.dart';
import 'package:arioac_app/features/shared/domain/entities/forms.dart';
import 'package:arioac_app/features/shared/infrastructure/inputs/required_text.dart';
import 'package:arioac_app/features/speaker/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

class AnswerFormState {
  final bool isPosting;
  final FormStatus isFormPosted;
  final bool isValid;
  final RequiredText answer;
  final String questionId;

  AnswerFormState({
    this.isPosting = false,
    this.isFormPosted = FormStatus.checking,
    this.isValid = false,
    this.answer = const RequiredText.pure(),
    this.questionId = '',
  });

  AnswerFormState copyWith({
    bool? isPosting,
    FormStatus? isFormPosted,
    bool? isValid,
    RequiredText? answer,
    String? questionId,
  }) =>
      AnswerFormState(
        isPosting: isPosting ?? this.isPosting,
        isFormPosted: isFormPosted ?? this.isFormPosted,
        isValid: isValid ?? this.isValid,
        answer: answer ?? this.answer,
        questionId: questionId ?? this.questionId,
      );

  @override
  String toString() {
    return '''
    LoginFormState:
      isPosting: $isPosting
      isFormPosted: $isFormPosted
      isValid: $isValid
      answer: $answer
      questionId: $questionId
    ''';
  }
}

class AnswerFormNotifier extends StateNotifier<AnswerFormState> {
  final Function(String, String) answerCallback;

  AnswerFormNotifier({
    required this.answerCallback,
  }) : super(AnswerFormState());

  onFormSubmit() async {
    _touchEveryField();
    if (!state.isValid) return;

    state = state.copyWith(isPosting: true);
    try {
      await answerCallback(
        state.questionId,
        state.answer.value,
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
    final answer = RequiredText.dirty(state.answer.value);

    state = state.copyWith(
      isFormPosted: FormStatus.checking,
      answer: answer,
      isValid: Formz.validate([answer]),
    );
  }

  updateFormStatus() {
    state = state.copyWith(isFormPosted: FormStatus.checking);
  }

  onAnswerChange(String value) {
    final answer = RequiredText.dirty(value);
    state = state.copyWith(
      answer: answer,
      isValid: Formz.validate(
        [state.answer],
      ),
    );
  }

  setConferenceId(String value) {
    state = state.copyWith(questionId: value);
  }
}

final answerFormProvider =
    StateNotifierProvider.autoDispose<AnswerFormNotifier, AnswerFormState>(
        (ref) {
  final answerCallback = ref.watch(speakerProvider.notifier).uploadAnswer;

  return AnswerFormNotifier(answerCallback: answerCallback);
});
