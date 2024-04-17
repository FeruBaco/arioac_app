import 'package:arioac_app/features/shared/widgets/circular_loading_indicator.dart';
import 'package:arioac_app/features/sponsor/presentation/providers/providers.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sponsorList = ref.watch(sponsorListProvider);

    // ref.listen(sponsorListProvider, (prev, next) {
    //   if (next.isAdding == FormStatus.empty) return;

    //   if (next.isAdding == FormStatus.success) {
    //     AwesomeDialog(
    //       context: context,
    //       dialogType: DialogType.success,
    //       animType: AnimType.bottomSlide,
    //       autoHide: const Duration(milliseconds: 2000),
    //       title: 'Se agrego correctamente.',
    //       desc: 'El participante se agrego correctamente.',
    //     ).show();
    //   }

    //   if (next.isAdding == FormStatus.failed) {
    //     AwesomeDialog(
    //             context: context,
    //             dialogType: DialogType.error,
    //             animType: AnimType.bottomSlide,
    //             autoHide: const Duration(milliseconds: 2000),
    //             title: 'Error al agregar participante.',
    //             desc: 'No se ha podido conectar con el servidor.')
    //         .show();
    //   }
    // });

    return Stack(
      children: [
        Column(
          verticalDirection: VerticalDirection.down,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'PREMIOS',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            (sponsorList.isLoading)
                ? const Expanded(child: CircularLoadingIndicator())
                : Flexible(
                    child: RefreshIndicator(
                      onRefresh:
                          ref.read(sponsorListProvider.notifier).pullRefresh,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          dataRowMinHeight: 60,
                          dataRowMaxHeight: 80,
                          columnSpacing: BorderSide.strokeAlignCenter,
                          columns: const [
                            DataColumn(label: Text('Nombre')),
                            DataColumn(label: Text('Empresa')),
                            DataColumn(label: Text('Borrar')),
                          ],
                          rows: sponsorList.users
                              .map(
                                (data) => DataRow(
                                  cells: [
                                    DataCell(Text(data.userName)),
                                    DataCell(Text(data.companyName)),
                                    DataCell(
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                        ),
                                        child: const Icon(Icons.delete),
                                        onPressed: () {},
                                      ),
                                    )
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
          child: FloatingActionButton.extended(
            heroTag: null,
            label: Text(
              "Agregar participante",
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.white),
            ),
            icon: const Icon(Icons.add),
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            isExtended: true,
            onPressed: () => context.push('/speaker_qr_scanner'),
          ),
        )
      ],
    );
  }
}
