import 'package:formz/formz.dart';

// Define input validation errors
enum SimpleTextError { empty, format }

// Extend FormzInput and provide the input type and error type.
class SimpleText extends FormzInput<String, SimpleTextError> {
  const SimpleText.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const SimpleText.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == SimpleTextError.empty) return 'Campo obligatorio';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  SimpleTextError? validator(String value) {
    return null;
  }
}
