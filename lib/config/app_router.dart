import 'package:arioac_app/config/router_notifier.dart';
import 'package:arioac_app/features/admin/presentation/screens/qr_screen.dart';
import 'package:arioac_app/features/admin/presentation/screens/user_show_screen.dart';
import 'package:arioac_app/features/auth/domain/domain.dart';
import 'package:arioac_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:arioac_app/features/auth/presentation/screens/screens.dart';
import 'package:arioac_app/features/admin/presentation/screens/screens.dart';
import 'package:arioac_app/features/speaker/presentation/screens/screens.dart';
import 'package:arioac_app/features/sponsor/presentation/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/shared/screens/screens.dart';

final goRouterProvider = Provider(
  (ref) {
    final routerNotifier = ref.watch(routerNotifierProvider);

    return GoRouter(
      initialLocation: '/loading',
      refreshListenable: routerNotifier,
      routes: [
        GoRoute(
          name: 'loading',
          path: '/loading',
          builder: (context, state) => const CheckAuthStatusScreen(),
        ),
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          name: 'home',
          path: '/home',
          builder: (context, state) =>
              MainScreen(userRole: routerNotifier.role),
        ),
        GoRoute(
          name: 'adminQrScanner',
          path: '/admin_qr_scanner',
          builder: (context, state) => QRScreen(),
        ),
        GoRoute(
          name: 'adminShowUser',
          path: '/admin_show_user',
          builder: (context, state) => const UserShowScreen(),
        ),
        GoRoute(
          name: 'speakerQrScanner',
          path: '/speaker_qr_scanner',
          builder: (context, state) => const SpeakerQRScreen(),
        )
      ],
      redirect: (context, state) {
        final isGoingTo = state.matchedLocation;
        final routeName = state.topRoute!.name;
        final authStatus = routerNotifier.authStatus;
        final userRole = routerNotifier.role;

        if (authStatus == AuthStatus.checking) {
          return '/loading';
        }

        if (authStatus == AuthStatus.notAuthenticated) {
          if (isGoingTo == '/login') return null;
          return '/login';
        }

        if (authStatus == AuthStatus.authenticated) {
          if (isGoingTo == '/login' || isGoingTo == '/loading') return '/home';

          // Admin routes
          if (routeName!.startsWith('admin')) {
            if (userRole == Role.admin) {
              return null;
            }

            return '/home';
          }

          // Sponsor routes
          if (routeName.startsWith('speaker')) {
            if (userRole == Role.sponsor) {
              return '/speaker_qr_scanner';
            }

            return '/home';
          }
        }

        return null;
      },
    );
  },
);
