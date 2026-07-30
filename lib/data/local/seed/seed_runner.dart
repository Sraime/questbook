import 'dart:convert';

import 'package:drift/drift.dart';

import '../database.dart';
import 'cthulhu_seed.dart';

/// Inserts the Cthulhu v7 GameSystem row on first launch. Idempotent —
/// safe to call on every app start. No demo characters/tables are seeded;
/// Home/Tables start in their empty state.
Future<void> seedDatabase(AppDatabase db) async {
  await db.into(db.gameSystems).insertOnConflictUpdate(
        GameSystemsCompanion.insert(
          id: CthulhuSeed.systemId,
          name: CthulhuSeed.systemName,
          occupationSuggestions: Value(
            jsonEncode(CthulhuSeed.occupationSuggestions),
          ),
        ),
      );
}
