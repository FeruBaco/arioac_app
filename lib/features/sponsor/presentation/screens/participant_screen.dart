import 'package:arioac_app/features/schedule/presentation/widgets/widgets.dart';
import 'package:arioac_app/features/shared/domain/entities/forms.dart';
import 'package:arioac_app/features/shared/widgets/widgets.dart';
import 'package:arioac_app/features/sponsor/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ParticipantScreen extends ConsumerWidget {
  const ParticipantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(sponsorListProvider);
    final winner = state.winner;

    ref.listen(sponsorListProvider, (prev, next) async {
      if (next.isAdding == FormStatus.checking) return;

      if (next.isAdding == FormStatus.success) {
        showSnackbar(
          context: context,
          msg: '😀 Operación completada correctamente',
        );
      }

      if (next.isAdding == FormStatus.failed) {
        showSnackbar(
          context: context,
          msg: next.errMsg,
          color: Colors.red,
        );
      }
    });

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Color.fromRGBO(240, 248, 248, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child:
                  CustomPaint(size: Size.infinite, painter: DottedBacgrkound()),
            ),
          ),
          (state.isLoading)
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.emoji_events,
                              color: Colors.amber,
                              size: 50,
                            ),
                            Text(
                              'Ganador',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            ListTile(
                              title: Text(
                                '🪪 ID: ${winner!.shortId}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                '👤 Nombre: ${winner.userName}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                '🏢 Empresa: ${winner.companyName}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            ListTile(
                              title: Text(
                                '📞 Teléfono: ${winner.userPhone}',
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ConferenceButton(
                              onPressed: () {
                                ref
                                    .read(sponsorListProvider.notifier)
                                    .registerWinner(winner.id);
                              },
                              size: const Size(100, 40),
                              child: Wrap(
                                children: [
                                  Text(
                                    'Guardar ganador',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.emoji_events)
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
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
}
