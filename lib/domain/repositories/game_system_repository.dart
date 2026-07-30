import '../models/game_system.dart';

abstract interface class GameSystemRepository {
  Future<List<GameSystem>> getAll();

  Future<GameSystem?> getById(String id);
}
