import 'package:arioac_app/features/schedule/presentation/providers/providers.dart';
import 'package:arioac_app/features/schedule/presentation/widgets/widgets.dart';
import 'package:arioac_app/features/shared/domain/entities/forms.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SurveyScreen extends ConsumerStatefulWidget {
  final Function changeScreen;
  final String conferenceId;
  final String conferenceTitle;
  const SurveyScreen({
    super.key,
    required this.changeScreen,
    required this.conferenceId,
    required this.conferenceTitle,
  });

  @override
  SurveyScreenState createState() => SurveyScreenState();
}

class SurveyScreenState extends ConsumerState<SurveyScreen> {
  final TextEditingController commentController = TextEditingController();
  final greenColor = const Color.fromRGBO(111, 181, 132, 1);
  String? content;
  String? topic;

  void onContentChange(String? value) {
    setState(() => content = value);
    ref.read(surveyFormProvider.notifier).onContentChange(value);
  }

  void onTopicChange(value) {
    setState(() => topic = value);
    ref.read(surveyFormProvider.notifier).onTopicChange(value);
  }

  void onFormSubmit() {
    ref.read(surveyFormProvider.notifier).setConference(widget.conferenceId);
    ref.read(surveyFormProvider.notifier).onFormSubmit();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final surveyForm = ref.watch(surveyFormProvider);
    final size = MediaQuery.of(context).size;
    final topMargin = size.height * .25;
    ScrollController scrollController = ScrollController(
      initialScrollOffset: size.height,
    );
    ref.listen(surveyFormProvider, (prev, next) {
      if (next.isFormPosted == FormStatus.checking) return;

      if (next.isFormPosted == FormStatus.success) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.bottomSlide,
          autoHide: const Duration(milliseconds: 2000),
          title: 'Gracias por tus comentarios!',
          onDismissCallback: (type) => widget.changeScreen(0),
        ).show();
      }

      if (next.isFormPosted == FormStatus.failed) {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.bottomSlide,
          autoHide: const Duration(milliseconds: 2000),
          title: 'No se ha podido enviar la encuesta',
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Encuesta',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width / 8),
                    child: const Divider(
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Califica el contenido expuesto en la conferencia "${widget.conferenceTitle}"',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SurveyRow(
                    number: "1",
                    text: "El contenido me pareció:",
                    color: (surveyForm.content.errorMessage != null)
                        ? Colors.red
                        : null,
                  ),
                  SurveyGradeList(
                    groupValue: content,
                    onChanged: onContentChange,
                  ),
                  SurveyRow(
                    number: "2",
                    text: "La ejecución de los temas me pareció:",
                    color: (surveyForm.topic.errorMessage != null)
                        ? Colors.red
                        : null,
                  ),
                  SurveyGradeList(groupValue: topic, onChanged: onTopicChange),
                  const SurveyRow(
                    number: "3",
                    text:
                        "¿Tienes algún comentario adicional que quieras compartir?",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 140,
                    child: TextField(
                      controller: commentController,
                      maxLength: 250,
                      decoration: InputDecoration(
                        hintText: 'Compartenos tus comentarios',
                        filled: true,
                        hintStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      keyboardType: TextInputType.multiline,
                      expands: true,
                      maxLines: null,
                      onChanged: (value) {
                        ref
                            .read(surveyFormProvider.notifier)
                            .onCommentChange(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ConferenceButton(
                    onPressed: () {
                      if (surveyForm.isPosting) return null;
                      if (topic != null && content != null) {
                        onFormSubmit();
                      }
                    },
                    size: Size(size.width * .8, 40),
                    child: (surveyForm.isPosting)
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ))
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
                  const SizedBox(
                    height: 80,
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
