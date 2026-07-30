import 'package:uuid/uuid.dart';

import '../../domain/models/game_table.dart';
import '../../domain/repositories/table_repository.dart';
import 'database.dart';

class LocalTableRepository implements TableRepository {
  LocalTableRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  @override
  Stream<List<GameTable>> watchAll() {
    return _db.select(_db.gameTables).watch().map(
          (rows) => rows.map(_fromRow).toList(),
        );
  }

  @override
  Future<GameTable> create({
    required String title,
    required String universeLabel,
    DateTime? nextSession,
    String? systemId,
  }) async {
    final id = _uuid.v4();
    await _db.into(_db.gameTables).insert(
          GameTableRow(
            id: id,
            title: title,
            universeLabel: universeLabel,
            nextSession: nextSession,
            systemId: systemId,
          ),
        );
    return GameTable(
      id: id,
      title: title,
      universeLabel: universeLabel,
      nextSession: nextSession,
      systemId: systemId,
    );
  }

  GameTable _fromRow(GameTableRow row) => GameTable(
        id: row.id,
        title: row.title,
        universeLabel: row.universeLabel,
        nextSession: row.nextSession,
        systemId: row.systemId,
      );
}
