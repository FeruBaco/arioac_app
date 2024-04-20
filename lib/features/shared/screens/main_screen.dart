import 'dart:io';

import 'package:arioac_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:arioac_app/features/speaker/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:arioac_app/features/shared/widgets/widgets.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:arioac_app/features/sponsor/presentation/screens/screens.dart';
import 'package:arioac_app/features/schedule/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';
import '../../auth/domain/domain.dart';

class MainScreen extends StatefulWidget {
  final Role userRole;
  const MainScreen({super.key, required this.userRole});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  int? navigationBarItemsLength;
  final List<Widget> screens = [];
  final Duration fadeDuration = const Duration(milliseconds: 500);

  List<CurvedNavigationBarItem> createNavigationBar() {
    Role role = widget.userRole;
    final List<CurvedNavigationBarItem> navigationBarItems = [];

    if (role == Role.user || role == Role.admin) {
      navigationBarItems.add(CurvedNavigationBarItem(
        child: Icon(
          Icons.calendar_month_outlined,
          color: activeColor(0),
          semanticLabel: 'Programa',
        ),
        label: 'Programa',
        labelStyle: const TextStyle(color: Colors.white),
      ));
      screens.add(const ScheduleScreen());
      navigationBarItems.add(CurvedNavigationBarItem(
        child: Icon(
          Icons.handshake,
          color: activeColor(1),
          semanticLabel: 'Patrocinadores',
        ),
        label: 'Patrocinadores',
        labelStyle: const TextStyle(color: Colors.white),
      ));
      screens.add(const SponsorsScreen());
    }

    if (role == Role.speaker) {
      navigationBarItems.add(CurvedNavigationBarItem(
        child: Icon(
          Icons.question_answer,
          color: activeColor(navigationBarItems.length),
          semanticLabel: 'Preguntas',
        ),
        label: 'Preguntas',
        labelStyle: const TextStyle(color: Colors.white),
      ));
      screens.add(const SpeakerScreen());
      navigationBarItems.add(CurvedNavigationBarItem(
        child: Icon(
          Icons.calendar_month_outlined,
          color: activeColor(1),
          semanticLabel: 'Programa',
        ),
        label: 'Programa',
        labelStyle: const TextStyle(color: Colors.white),
      ));
      screens.add(const ScheduleScreen());
    }

    if (role == Role.sponsor) {
      navigationBarItems.add(CurvedNavigationBarItem(
        child: Icon(
          Icons.home,
          color: activeColor(navigationBarItems.length),
          semanticLabel: 'Inicio',
        ),
        label: 'Inicio',
        labelStyle: const TextStyle(color: Colors.white),
      ));
      screens.add(const RegisterScreen());
    }

    navigationBarItems.add(
      CurvedNavigationBarItem(
        child: Icon(
          Icons.person_pin_rounded,
          color: activeColor(navigationBarItems.length),
          semanticLabel: 'Perfil',
        ),
        label: 'Perfil',
        labelStyle: const TextStyle(color: Colors.white),
      ),
    );
    navigationBarItemsLength = navigationBarItems.length - 1;
    return navigationBarItems;
  }

  void onItemTapped(int i) => setState(() => selectedIndex = i);

  Color activeColor(int i) =>
      selectedIndex == i ? const Color.fromRGBO(43, 118, 137, 1) : Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) => (selectedIndex == navigationBarItemsLength)
            ? SafeArea(
                child: FadeIndexedStack(
                  curve: Curves.easeInOut,
                  duration: fadeDuration,
                  index: 0,
                  children: [ProfileScreen(scaffoldContext: context)],
                ),
              )
            : SafeArea(
                child: CustomPaint(
                  painter: CrossesBackground(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const MainSemiCirle(),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                          child: FadeIndexedStack(
                            curve: Curves.easeInOut,
                            duration: fadeDuration,
                            index: selectedIndex,
                            children: screens,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            width: double.infinity,
            height: (Platform.isAndroid ? 100.0 : 110.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black54.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 0),
                )
              ],
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(43, 118, 137, 1),
                  Color.fromRGBO(43, 162, 137, 1)
                ],
              ),
            ),
          ),
          CurvedNavigationBar(
            index: selectedIndex,
            onTap: onItemTapped,
            backgroundColor: Colors.transparent,
            height: 70,
            iconPadding: 10,
            buttonBackgroundColor: Colors.white,
            color: const Color.fromRGBO(41, 48, 49, 1),
            items: createNavigationBar(),
          )
        ],
      ),
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF298C7A),
                    Color.fromRGBO(94, 90, 156, 1),
                  ],
                ),
              ),
              child: Text(
                'Panel Administrativo',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.white),
              ),
            ),
            ListTile(
                title: const Text('Escanear usuario'),
                leading: const Icon(Icons.qr_code_scanner_sharp),
                onTap: () => context.push('/admin_qr_scanner')),
          ],
        ),
      ),
    );
  }
}
