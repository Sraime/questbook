import 'package:go_router/go_router.dart';

import '../features/character_creation/character_creation_screen.dart';
import '../features/character_sheet/character_sheet_screen.dart';
import '../features/home/home_screen.dart';
import '../features/shell/app_shell.dart';
import '../features/tables/tables_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/perso',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          AppShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/perso',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'create',
                builder: (context, state) => const CharacterCreationScreen(),
              ),
              GoRoute(
                path: ':id',
                builder: (context, state) => CharacterSheetScreen(
                  characterId: state.pathParameters['id']!,
                ),
              ),
            ],
          ),
        ]),
        StatefulShellBranch(routes: [
          GoRoute(
            path: '/tables',
            builder: (context, state) => const TablesScreen(),
          ),
        ]),
      ],
    ),
  ],
);
