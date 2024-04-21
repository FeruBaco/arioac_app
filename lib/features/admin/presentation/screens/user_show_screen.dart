import 'package:arioac_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/widgets/widgets.dart';

class UserShowScreen extends ConsumerStatefulWidget {
  const UserShowScreen({super.key});

  @override
  UserShowScreenState createState() => UserShowScreenState();
}

class UserShowScreenState extends ConsumerState<UserShowScreen> {
  final double borderRadius = 20;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(authProvider);
    final user = ref.watch(authProvider).userCheck;
    final isLoading = ref.watch(authProvider).isUserCheckLoading;
    final hasError = ref.watch(authProvider).userCheckError;

    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color.fromRGBO(240, 248, 248, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: CustomPaint(
                    size: Size.infinite, painter: DottedBacgrkound()),
              ),
            ),
            (isLoading && user == null)
                ? const CircularLoadingIndicator()
                : (hasError)
                    ? Expanded(
                        child: Center(
                          child: Container(
                            height: 300,
                            width: 300,
                            // color: const Color(0xffffc5c2),
                            decoration: const BoxDecoration(
                                color: Color(0xffffdbd9),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(40)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x10000000),
                                    spreadRadius: 3,
                                    offset: Offset(3, 3),
                                    blurRadius: 3,
                                  ),
                                ]),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.error,
                                      color: Colors.red, size: 70),
                                  Text(
                                    'Error al obtener usuario',
                                    // style: TextStyles.errorTitle,
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleLarge,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Usuario',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            ListView(
                              shrinkWrap: true,
                              children: [
                                ListTile(
                                  leading: Text(
                                    '👤 Usuario',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  title: Text(user!.userName),
                                ),
                                ListTile(
                                  leading: Text(
                                    '📧 Correo',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  title: Text(user.userEmail),
                                ),
                                ListTile(
                                  leading: Text(
                                    '📞 Teléfono',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  title: Text(user.userPhone),
                                ),
                                ListTile(
                                  leading: Text(
                                    '💼 Puesto laboral',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  title: Text(user.userJobPosition),
                                ),
                                ListTile(
                                  leading: Text(
                                    '🏢 Empresa',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  title: Text(user.companyName),
                                ),
                                ListTile(
                                  leading: Text(
                                    '🍲 Comida',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  title: Text((user.hasFood) ? '✅' : '❌'),
                                ),
                                ListTile(
                                  leading: Text(
                                    '💵 Pago',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  title: Text(user.paymentStatus),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
            Positioned(
              top: 80,
              right: 10,
              child: MaterialButton(
                onPressed: () => context.pop(),
                color: Colors.green,
                textColor: Colors.white,
                height: 60,
                shape: const CircleBorder(),
                child: const Icon(
                  Icons.close,
                  size: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
