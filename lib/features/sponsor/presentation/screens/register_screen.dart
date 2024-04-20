import 'package:arioac_app/features/shared/widgets/widgets.dart';
import 'package:arioac_app/features/sponsor/presentation/providers/providers.dart';
import 'package:arioac_app/features/sponsor/presentation/screens/participant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/domain/entities/forms.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends ConsumerState<RegisterScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final sponsorList = ref.watch(sponsorListProvider);
    final Size size = MediaQuery.of(context).size;

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
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Participantes',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              (sponsorList.isPageLoading)
                  ? const Expanded(child: CircularLoadingIndicator())
                  : Expanded(
                      child: RefreshIndicator(
                        onRefresh:
                            ref.read(sponsorListProvider.notifier).pullRefresh,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.only(
                            bottom: size.height / 8,
                          ),
                          scrollDirection: Axis.vertical,
                          child: DataTable(
                            dataRowMinHeight: 40,
                            dataRowMaxHeight: 80,
                            columnSpacing: BorderSide.strokeAlignCenter,
                            columns: [
                              DataColumn(
                                label: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    maxWidth: size.width / 2,
                                    minWidth: size.width / 2,
                                  ),
                                  child: const Text(
                                    'Nombre',
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
                                        'Empresa',
                                        overflow: TextOverflow.fade,
                                      ))),
                              // DataColumn(
                              //     label: ConstrainedBox(
                              //         constraints: BoxConstraints(
                              //           minWidth: (size.width / 3) * .5,
                              //         ),
                              //         child: const Text('Borrar'))),
                            ],
                            rows: sponsorList.users
                                .map(
                                  (data) => DataRow(
                                    cells: [
                                      DataCell(Text(data.userName)),
                                      DataCell(Text(data.companyName!)),
                                      // DataCell(
                                      //   ElevatedButton(
                                      //     style: ElevatedButton.styleFrom(
                                      //       shape: RoundedRectangleBorder(
                                      //         borderRadius:
                                      //             BorderRadius.circular(10.0),
                                      //       ),
                                      //       backgroundColor: Colors.red,
                                      //       foregroundColor: Colors.white,
                                      //     ),
                                      //     child: const Icon(Icons.delete),
                                      //     onPressed: () {},
                                      //   ),
                                      // )
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Column(
              children: [
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  isExtended: true,
                  onPressed: () async {
                    ref.read(sponsorListProvider.notifier).restart();
                    await ref.read(sponsorListProvider.notifier).doLottery();
                    showModalBottomSheet(
                      context: context,
                      enableDrag: true,
                      builder: ((context) => const ParticipantScreen()),
                    );
                  },
                  child: const Icon(Icons.emoji_events),
                ),
                const SizedBox(
                  height: 10,
                ),
                FloatingActionButton(
                  heroTag: null,
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  isExtended: true,
                  onPressed: () => context.push('/sponsor_qr_scanner'),
                  child: const Icon(Icons.add_a_photo),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    scrollController.addListener(
      () {
        if ((scrollController.position.pixels + 200) >=
            scrollController.position.maxScrollExtent) {
          ref.read(sponsorListProvider.notifier).loadNextPage();
        }
      },
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
