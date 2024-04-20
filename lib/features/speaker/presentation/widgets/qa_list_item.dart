import 'package:arioac_app/features/schedule/domain/domain.dart';
import 'package:arioac_app/features/shared/domain/entities/forms.dart';
import 'package:arioac_app/features/speaker/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/snackbar.dart';

class QAListItem extends ConsumerStatefulWidget {
  final QA question;
  final Color cardColor;
  final int? index;

  const QAListItem({
    super.key,
    required this.question,
    this.index,
    this.cardColor = Colors.white,
  });

  @override
  QAListItemState createState() => QAListItemState();
}

class QAListItemState extends ConsumerState<QAListItem> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _customTileExpanded = false;
  int selected = -1;

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.question.answer;
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  void showSnackbar({
    required BuildContext context,
    required String msg,
    Color? color,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      AppSnackBar(
        content: msg,
        context: context,
        backgroundColor: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.question;
    final answerForm = ref.watch(answerFormProvider);

    ref.listen(answerFormProvider, (prev, next) async {
      if (next.isFormPosted == FormStatus.checking) return;

      if (next.isFormPosted == FormStatus.success) {
        showSnackbar(
          context: context,
          msg: '😀 Tu respuesta se guardo correctamente',
        );
      }

      if (next.isFormPosted == FormStatus.failed) {
        showSnackbar(
          context: context,
          msg: '😰 Ups! Tuvimos un error al guardar tu respuesta',
          color: Colors.red,
        );
      }
    });

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.15),
                    blurRadius: 5,
                    spreadRadius: 12,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: ExpansionTile(
                  key: UniqueKey(),
                  initiallyExpanded: widget.index == selected,
                  backgroundColor: widget.cardColor,
                  shape: const Border(),
                  collapsedIconColor: Colors.green,
                  collapsedBackgroundColor: widget.cardColor,
                  iconColor: Colors.green,
                  title: Text(
                    question.question,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  subtitle: Container(
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      _customTileExpanded
                          ? Icons.expand_less
                          : Icons.expand_more,
                    ),
                  ),
                  trailing: Wrap(
                    direction: Axis.vertical,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.thumb_up_off_alt,
                      ),
                      Text(question.votes.toString())
                    ],
                  ),
                  onExpansionChanged: ((newState) {
                    ref
                        .read(answerFormProvider.notifier)
                        .setConferenceId(question.id);
                    setState(() {
                      _customTileExpanded = newState;
                    });
                    if (newState) {
                      setState(() {
                        selected = widget.index!;
                      });
                    } else {
                      setState(() {
                        selected = -1;
                      });
                    }
                  }),
                  children: [
                    ListTile(
                      title: TextField(
                        maxLines: null,
                        maxLength: 250,
                        autofocus: true,
                        controller: _textEditingController,
                        keyboardType: TextInputType.multiline,
                        onChanged: ref
                            .read(answerFormProvider.notifier)
                            .onAnswerChange,
                        decoration: InputDecoration(
                          filled: true,
                          hintText: 'Escribe tu respuesta',
                          hintStyle: Theme.of(context).textTheme.labelLarge,
                          fillColor: Colors.grey.shade200,
                          suffixIcon: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(20, 20),
                              shape: const CircleBorder(),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.green,
                            ),
                            onPressed: answerForm.isPosting
                                ? null
                                : () {
                                    ref
                                        .read(answerFormProvider.notifier)
                                        .onFormSubmit();
                                    SystemChannels.textInput
                                        .invokeMethod('TextInput.hide');
                                  },
                            child: const Icon(Icons.send),
                          ),
                          errorStyle: Theme.of(context)
                              .textTheme
                              .labelMedium
                              ?.copyWith(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
