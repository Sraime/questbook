import 'dart:convert';

import '../../domain/models/game_system.dart';
import '../../domain/repositories/game_system_repository.dart';
import 'database.dart';

class LocalGameSystemRepository implements GameSystemRepository {
  LocalGameSystemRepository(this._db);

  final AppDatabase _db;

  @override
  Future<List<GameSystem>> getAll() async {
    final rows = await _db.select(_db.gameSystems).get();
    return rows.map(_fromRow).toList();
  }

  @override
  Future<GameSystem?> getById(String id) async {
    final row = await (_db.select(_db.gameSystems)..where((s) => s.id.equals(id)))
        .getSingleOrNull();
    return row == null ? null : _fromRow(row);
  }

  GameSystem _fromRow(GameSystemRow row) => GameSystem(
        id: row.id,
        name: row.name,
        occupationSuggestions:
            (jsonDecode(row.occupationSuggestions) as List).cast<String>(),
      );
}
