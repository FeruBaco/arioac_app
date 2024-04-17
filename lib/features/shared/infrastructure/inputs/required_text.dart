import 'package:formz/formz.dart';

// Define input validation errors
enum RequiredTextError { empty, length, format }

// Extend FormzInput and provide the input type and error type.
class RequiredText extends FormzInput<String, RequiredTextError> {
  const RequiredText.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const RequiredText.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == RequiredTextError.empty) return 'Campo obligatorio';
    if (displayError == RequiredTextError.length) return 'Mínimo 10 caracteres';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  RequiredTextError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return RequiredTextError.empty;
    if (value.length < 10) return RequiredTextError.length;

    // if (!RequiredTextRegExp.hasMatch(value)) return RequiredTextError.format;

    return null;
  }
}
