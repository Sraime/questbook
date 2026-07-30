import '../models/game_table.dart';

abstract interface class TableRepository {
  Stream<List<GameTable>> watchAll();

  Future<GameTable> create({
    required String title,
    required String universeLabel,
    DateTime? nextSession,
    String? systemId,
  });
}
