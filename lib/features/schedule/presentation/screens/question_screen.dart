import 'package:arioac_app/features/schedule/presentation/providers/question_form_provider.dart';
import 'package:arioac_app/features/schedule/presentation/widgets/widgets.dart';
import 'package:arioac_app/features/shared/domain/entities/forms.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionScreen extends ConsumerStatefulWidget {
  final Function changeScreen;
  final String conferenceId;
  const QuestionScreen({
    super.key,
    required this.changeScreen,
    required this.conferenceId,
  });

  @override
  QuestionScreenState createState() => QuestionScreenState();
}

class QuestionScreenState extends ConsumerState<QuestionScreen> {
  final TextEditingController commentController = TextEditingController();

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surveyForm = ref.watch(questionFormProvider);
    final size = MediaQuery.of(context).size;
    ScrollController scrollController = ScrollController(
      initialScrollOffset: size.height,
    );
    final topMargin = size.height * .25;

    ref.listen(questionFormProvider, (prev, next) {
      if (next.isFormPosted == FormStatus.checking) return;

      if (next.isFormPosted == FormStatus.success) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          autoHide: const Duration(milliseconds: 2000),
          title: 'Gracias por tu pregunta!',
          onDismissCallback: (type) => widget.changeScreen(1),
        ).show();
      }

      if (next.isFormPosted == FormStatus.failed) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          autoHide: const Duration(milliseconds: 2000),
          title: 'No se ha podido enviar la pregunta',
          desc: 'No se ha podido conectar con el servidor.',
        ).show();
      }
    });

    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(top: topMargin),
          child: SingleChildScrollView(
            controller: scrollController,
            reverse: true,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Envíanos tu pregunta',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width / 8),
                    child: const Divider(
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 200,
                    child: TextField(
                      maxLength: 180,
                      controller: commentController,
                      decoration: InputDecoration(
                        hintText: 'Escribe tu pregunta',
                        filled: true,
                        hintStyle: Theme.of(context).textTheme.labelLarge,
                        errorStyle: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(color: Colors.red),
                        errorText:
                            surveyForm.isFormPosted == FormStatus.checking
                                ? surveyForm.question.errorMessage
                                : null,
                      ),
                      keyboardType: TextInputType.multiline,
                      expands: true,
                      maxLines: null,
                      onChanged: ref
                          .read(questionFormProvider.notifier)
                          .onCommentChange,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ConferenceButton(
                    onPressed: surveyForm.isPosting
                        ? null
                        : () {
                            ref
                                .read(questionFormProvider.notifier)
                                .onFormSubmit(widget.conferenceId);
                            SystemChannels.textInput
                                .invokeMethod('TextInput.hide');
                          },
                    size: Size(size.width * .8, 40),
                    child: (surveyForm.isPosting)
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Wrap(
                            alignment: WrapAlignment.center,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                'Enviar',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              const Icon(
                                Icons.send_sharp,
                                size: 20,
                              )
                            ],
                          ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                  ),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: size.height * .25,
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
