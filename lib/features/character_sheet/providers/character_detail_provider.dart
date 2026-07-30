import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../domain/models/character.dart';
import '../../../domain/repositories/character_repository.dart';
import '../../../domain/rules/rules_engine.dart';

final characterDetailProvider =
    StreamProvider.family<Character?, String>((ref, id) {
  return ref.watch(characterRepositoryProvider).watchById(id);
});

final characterActionsProvider = Provider<CharacterActions>((ref) {
  return CharacterActions(
    ref.watch(characterRepositoryProvider),
    ref.watch(rulesEngineProvider),
  );
});

/// Thin wrapper around the repository + rules engine for everything the
/// sheet screen and its modals (dice roll, resource edit) do.
class CharacterActions {
  CharacterActions(this._repo, this._rules);

  final CharacterRepository _repo;
  final RulesEngine _rules;

  SkillCheckResult rollSkillCheck(int targetValue) =>
      _rules.rollSkillCheck(targetValue);

  Future<void> adjustResource(
    String characterId,
    String key,
    int delta, {
    required int current,
    required int max,
  }) {
    final next = (current + delta).clamp(0, max);
    return _repo.updateResourceCurrent(characterId, key, next);
  }

  Future<void> addInventoryItem(
    String characterId, {
    required String name,
    int qty = 1,
    String? weight,
  }) {
    return _repo.addInventoryItem(characterId, name: name, qty: qty, weight: weight);
  }

  Future<void> removeInventoryItem(String itemId) =>
      _repo.removeInventoryItem(itemId);
}
