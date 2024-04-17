import 'package:arioac_app/features/shared/widgets/login_filled_button.dart';
import 'package:arioac_app/features/shared/widgets/login_text_form_field.dart';
import 'package:arioac_app/features/shared/widgets/wave_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: WaveBackground(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'images/asset_1.png',
                  height: 200,
                  width: 200,
                ),
                const _LoginForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void showSnackbar(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (prev, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackbar(context, next.errorMessage);
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          LoginTextFormField(
            hint: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onChanged: ref.read(loginFormProvider.notifier).onEmailChange,
            errMsg:
                loginForm.isFormPosted ? loginForm.email.errorMessage : null,
          ),
          const SizedBox(
            height: 20,
          ),
          LoginTextFormField(
            hint: 'Contraseña',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.send,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            onEditingComplete:
                ref.read(loginFormProvider.notifier).onFormSubmit,
            errMsg:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: LoginFilledButton(onPressed: () {
              if (!loginForm.isPosting) {
                ref.read(loginFormProvider.notifier).onFormSubmit();
                SystemChannels.textInput.invokeMethod('TextInput.hide');
              }
            }),
          )
        ],
      ),
    );
  }
}
