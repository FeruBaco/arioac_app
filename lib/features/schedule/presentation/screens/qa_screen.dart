import 'package:arioac_app/features/schedule/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';

class QAScreen extends StatelessWidget {
  final Function changeScreen;
  final String conferenceId;

  const QAScreen({
    super.key,
    required this.changeScreen,
    required this.conferenceId,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final topMargin = size.height * .25;

    return Stack(
      children: [
        Container(
          height: size.height,
          margin: EdgeInsets.only(top: topMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                'Preguntas y respuestas',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 8),
                child: const Divider(
                  color: Colors.black,
                ),
              ),
              const Expanded(child: QAList()),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
              ),
            ],
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            height: topMargin,
            color: Colors.transparent,
          ),
        ),
        Positioned(
          right: 15,
          bottom: 40,
          child: ConferenceButton(
            size: const Size(100, 60),
            onPressed: () {
              changeScreen(3);
            },
            child: Wrap(
              children: [
                Text(
                  'Hacer pregunta',
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: Colors.white),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.question_answer)
              ],
            ),
          ),
        )
      ],
    );
  }
}
