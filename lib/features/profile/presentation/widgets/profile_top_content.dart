import 'package:floating_bubbles/floating_bubbles.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../../auth/domain/domain.dart';
import '../../../auth/presentation/providers/providers.dart';

class ProfileTopContent extends ConsumerWidget {
  final BuildContext scaffoldContext;
  const ProfileTopContent({super.key, required this.scaffoldContext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authProvider).user!;

    return Stack(
      children: [
        SizedBox(
          width: double.maxFinite,
          height: double.maxFinite,
          child: FloatingBubbles.alwaysRepeating(
            noOfBubbles: 6,
            colorsOfBubbles: [
              const Color.fromRGBO(41, 140, 122, 1).withAlpha(30),
              const Color.fromRGBO(94, 90, 156, 1).withAlpha(30)
            ],
            sizeFactor: .18,
            speed: BubbleSpeed.normal,
          ),
        ),
        if (user.role == Role.admin)
          Positioned(
            top: 10,
            left: 6,
            child: IconButton(
              icon: const Icon(
                Icons.menu,
                size: 26,
              ),
              color: Colors.white,
              onPressed: () => Scaffold.of(scaffoldContext).openDrawer(),
            ),
          ),
        Positioned(
          top: 10,
          right: 6,
          child: IconButton(
            icon: const Icon(
              Icons.logout,
              size: 26,
            ),
            color: Colors.white,
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
          ),
        ),
        Positioned(
          left: 20,
          bottom: 10,
          child: Text('ID: ${user.userId}',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900)
              // style: Theme.of(context).textTheme.titleLarge,
              ),
        )
      ],
    );
  }
}
