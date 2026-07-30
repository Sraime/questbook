import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/providers.dart';
import 'app/router.dart';
import 'app/theme.dart';

void main() {
  runApp(const ProviderScope(child: QuestbookApp()));
}

class QuestbookApp extends ConsumerWidget {
  const QuestbookApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final init = ref.watch(databaseInitProvider);

    return MaterialApp.router(
      title: 'Questbook',
      debugShowCheckedModeBanner: false,
      theme: buildQuestbookTheme(),
      routerConfig: appRouter,
      builder: (context, child) {
        return init.when(
          data: (_) => child ?? const SizedBox.shrink(),
          loading: () => const _SplashScreen(),
          error: (error, stack) => _SplashScreen(error: error),
        );
      },
    );
  }
}

class _SplashScreen extends StatelessWidget {
  const _SplashScreen({this.error});

  final Object? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: error == null
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(24),
                child: Text('Erreur au démarrage : $error'),
              ),
      ),
    );
  }
}
