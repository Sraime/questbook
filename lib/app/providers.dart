import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/database.dart';
import '../data/local/local_character_repository.dart';
import '../data/local/local_game_system_repository.dart';
import '../data/local/local_table_repository.dart';
import '../data/local/seed/seed_runner.dart';
import '../domain/repositories/character_repository.dart';
import '../domain/repositories/game_system_repository.dart';
import '../domain/repositories/table_repository.dart';
import '../domain/rules/cthulhu_rules_engine.dart';
import '../domain/rules/rules_engine.dart';

/// Single Drift connection for the app's lifetime. Swapping to a remote
/// backend later never touches this file's *consumers* — only the
/// repository providers below would gain a `Remote*Repository` alternative.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

/// Ensures the Cthulhu v7 GameSystem row exists before any screen reads it.
/// main.dart awaits this once at startup.
final databaseInitProvider = FutureProvider<void>((ref) async {
  final db = ref.watch(appDatabaseProvider);
  await seedDatabase(db);
});

final characterRepositoryProvider = Provider<CharacterRepository>((ref) {
  return LocalCharacterRepository(ref.watch(appDatabaseProvider));
});

final gameSystemRepositoryProvider = Provider<GameSystemRepository>((ref) {
  return LocalGameSystemRepository(ref.watch(appDatabaseProvider));
});

final tableRepositoryProvider = Provider<TableRepository>((ref) {
  return LocalTableRepository(ref.watch(appDatabaseProvider));
});

/// Only one ruleset is seeded today (Cthulhu v7). When a second system is
/// added, this becomes a `Map<String, RulesEngine>` keyed by systemId.
final rulesEngineProvider = Provider<RulesEngine>((ref) {
  return const CthulhuRulesEngine();
});
