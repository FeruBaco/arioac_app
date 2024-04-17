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

    return Column(
      verticalDirection: VerticalDirection.down,
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
            : Flexible(
                child: RefreshIndicator(
                  onRefresh: ref.read(winnersProvider.notifier).getWinners,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      columnSpacing: BorderSide.strokeAlignCenter,
                      columns: const [
                        DataColumn(label: Text('Ganador')),
                        DataColumn(label: Text('Patrocinador')),
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
