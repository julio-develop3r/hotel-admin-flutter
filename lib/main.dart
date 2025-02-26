import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:locks_flutter/api/firestore_api.dart';
import 'package:locks_flutter/app/app_service.dart';
import 'package:locks_flutter/features/add_building/add_building_screen.dart';
import 'package:locks_flutter/features/buildings/buildings_repository.dart';
import 'package:locks_flutter/features/buildings/buildings_screen.dart';
import 'package:locks_flutter/features/login/login_screen.dart';
import 'package:locks_flutter/features/operation/operation_screen.dart';
import 'package:locks_flutter/features/operations/operations_screen.dart';
import 'package:locks_flutter/models/building_model.dart';
import 'package:locks_flutter/router/nav_drawer.dart';
import 'package:locks_flutter/shared/print.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (!FirestoreApi.isProduction) {
    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  }

  runApp(const LocksApp());
}

class LocksApp extends StatelessWidget {
  const LocksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: <RepositoryProvider<dynamic>>[
        RepositoryProvider<BuildingsRepository>(create: (_) => BuildingsRepository()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      redirect: (_, __) => '/operations',
    ),
    GoRoute(
      path: '/login',
      builder: (_, __) => const LoginScreen(), // Mandar la instancia que es
    ),
    ShellRoute(
      navigatorKey: GlobalKey(),
      builder: (_, GoRouterState state, Widget child) => Scaffold(
        appBar: AppBar(
          title: Text('${state.topRoute?.name}'),
          backgroundColor: Colors.blue[300],
        ),
        drawer: const NavDrawer(),
        body: child,
      ),
      routes: <RouteBase>[
        GoRoute(
          path: '/operations',
          name: 'Operaciones',
          builder: (_, __) => const OperationsScreen(),
          routes: <RouteBase>[
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'floor',
              builder: (_, GoRouterState state) => OperationScreen(building: state.extra as BuildingModel),
            )
          ],
        ),
        GoRoute(
          path: '/buildings',
          name: 'Hoteles',
          builder: (_, __) => const BuildingsScreen(),
          routes: <RouteBase>[
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'add',
              builder: (_, GoRouterState state) => AddBuildingScreen(state.extra as BuildingModel?),
            )
          ],
        ),
        GoRoute(
          path: '/reports',
          name: 'Reports',
          builder: (_, __) => const SizedBox.shrink(),
        ),
      ],
    ),
  ],
  refreshListenable: AppService.instance,
  redirect: (_, GoRouterState state) {
    final bool isLoggedIn = AppService.instance.credential != null;
    final bool isLoginRoute = state.matchedLocation == '/login';

    printWarning('[Redirect] isLoggedIn $isLoggedIn');

    if (!isLoggedIn && !isLoginRoute) {
      return '/login';
    } else if (isLoggedIn && isLoginRoute) {
      return '/';
    }

    return null;
  },
);
