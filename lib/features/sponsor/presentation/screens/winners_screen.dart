import 'package:arioac_app/features/shared/widgets/widgets.dart';
import 'package:arioac_app/features/sponsor/presentation/providers/winners_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class WinnersScreen extends ConsumerWidget {
  final Function changeScreen;
  const WinnersScreen({super.key, required this.changeScreen});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final winnerState = ref.watch(winnersProvider);
    final Size size = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 10,
              child: IconButton(
                onPressed: () {
                  changeScreen(0);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  size: 40,
                ),
              ),
            ),
            Text(
              'PREMIOS',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        (winnerState.isLoading)
            ? const CircularLoadingIndicator()
            : Expanded(
                child: RefreshIndicator(
                  onRefresh: ref.read(winnersProvider.notifier).getWinners,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columnSpacing: BorderSide.strokeAlignCenter,
                      columns: [
                        DataColumn(
                          label: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: size.width / 2,
                              minWidth: size.width / 2,
                            ),
                            child: const Text(
                              'Ganador',
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxWidth: size.width / 2,
                              minWidth: size.width / 2,
                            ),
                            child: const Text(
                              'Patrocinador',
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ),
                      ],
                      rows: winnerState.winners
                          .map(
                            (data) => DataRow(
                              cells: [
                                DataCell(Text(data.userName)),
                                DataCell(Text(data.sponsorName))
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}
