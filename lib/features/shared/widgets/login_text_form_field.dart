import 'package:flutter/material.dart';

class LoginTextFormField extends StatelessWidget {
  final String? label;
  final String? initialValue;
  final String? hint;
  final String? errMsg;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final Function()? onEditingComplete;

  const LoginTextFormField(
      {super.key,
      this.label,
      this.initialValue,
      this.hint,
      this.errMsg,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.validator,
      this.onEditingComplete,
      this.textInputAction = TextInputAction.done});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    const border = UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 1));

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onEditingComplete: onEditingComplete,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 18, color: Colors.white),
      decoration: InputDecoration(
        floatingLabelStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        enabledBorder: border,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        focusedBorder: border,
        errorBorder:
            border.copyWith(borderSide: const BorderSide(color: Colors.red)),
        focusedErrorBorder:
            border.copyWith(borderSide: const BorderSide(color: Colors.red)),
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white60),
        // TODO: We add error message under input text?????
        // errorText: (errMsg != null) ? "⚠️ $errMsg" : "",
        errorStyle: const TextStyle(fontSize: 16, color: Colors.white),
        focusColor: colors.primary,
      ),
    );
  }
}
