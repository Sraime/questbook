import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../data/local/seed/cthulhu_seed.dart';
import '../../../domain/models/character_resource.dart';
import '../../../domain/models/character_stat.dart';
import '../../../domain/models/tone.dart';
import '../../../domain/rules/rules_engine.dart';

/// Draft state for the character-creation flow (screen 1b + the 1i
/// characteristic-roll modal). Nothing is persisted until [submit] — the
/// repository only sees the finished character.
///
/// Only Cthulhu v7 is seeded today, so this reads the skill/characteristic
/// catalog straight from [CthulhuSeed] rather than through a system lookup;
/// once a second system exists, that catalog becomes the thing fetched per
/// systemId instead of a static import.
class CharacterCreationState {
  CharacterCreationState({
    required this.name,
    required this.occupation,
    required this.description,
    required this.characteristics,
    required this.skillAllocated,
    this.isSubmitting = false,
  });

  factory CharacterCreationState.initial() => CharacterCreationState(
        name: '',
        occupation: null,
        description: '',
        characteristics: {
          for (final c in CthulhuSeed.primaryCharacteristics) c.key: null,
        },
        skillAllocated: {
          for (final s in CthulhuSeed.skillCatalog) s.key: 0,
        },
      );

  final String name;
  final String? occupation;
  final String description;
  final Map<String, int?> characteristics;
  final Map<String, int> skillAllocated;
  final bool isSubmitting;

  bool get allCharacteristicsRolled =>
      characteristics.values.every((v) => v != null);

  Map<String, int> get resolvedCharacteristics =>
      characteristics.map((k, v) => MapEntry(k, v ?? 0));

  int get skillPointsTotal {
    if (!allCharacteristicsRolled) return 0;
    final edu = characteristics['EDU'] ?? 0;
    final intel = characteristics['INT'] ?? 0;
    return edu * 4 + intel * 2;
  }

  int get skillPointsSpent =>
      skillAllocated.values.fold(0, (a, b) => a + b);

  int get skillPointsRemaining => skillPointsTotal - skillPointsSpent;

  int baseValueFor(CthulhuSkillDef skill) {
    if (skill.baseValue >= 0) return skill.baseValue;
    if (skill.key == 'esquive') return (characteristics['DEX'] ?? 0) ~/ 2;
    if (skill.key == 'langue_maternelle') return characteristics['EDU'] ?? 0;
    return 0;
  }

  int valueFor(CthulhuSkillDef skill) =>
      baseValueFor(skill) + (skillAllocated[skill.key] ?? 0);

  CharacterCreationState copyWith({
    String? name,
    Object? occupation = _unset,
    String? description,
    Map<String, int?>? characteristics,
    Map<String, int>? skillAllocated,
    bool? isSubmitting,
  }) {
    return CharacterCreationState(
      name: name ?? this.name,
      occupation:
          identical(occupation, _unset) ? this.occupation : occupation as String?,
      description: description ?? this.description,
      characteristics: characteristics ?? this.characteristics,
      skillAllocated: skillAllocated ?? this.skillAllocated,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }
}

const _unset = Object();

class CharacterCreationNotifier extends Notifier<CharacterCreationState> {
  @override
  CharacterCreationState build() => CharacterCreationState.initial();

  void setName(String value) => state = state.copyWith(name: value);

  void setOccupation(String? value) => state = state.copyWith(occupation: value);

  void setDescription(String value) => state = state.copyWith(description: value);

  /// Bonus is only meaningful for the characteristic tied to the chosen
  /// occupation (EDU for "Bibliothécaire", matching the 1i mockup) — the
  /// creation screen decides when to pass one.
  CharacteristicRoll rollCharacteristic(String key, {int bonus = 0}) {
    final rules = ref.read(rulesEngineProvider);
    final roll = rules.rollCharacteristic(bonus: bonus);
    final updated = Map<String, int?>.from(state.characteristics)..[key] = roll.total;
    state = state.copyWith(characteristics: updated);
    return roll;
  }

  void rollAllCharacteristics() {
    for (final c in CthulhuSeed.primaryCharacteristics) {
      if (state.characteristics[c.key] == null) {
        rollCharacteristic(c.key);
      }
    }
  }

  /// Read-only preview of the derived characteristics (MVT/IMP/COR/ESQ) for
  /// display before the character is actually created.
  Map<String, int> previewDerived(Map<String, int> primary) {
    return ref.read(rulesEngineProvider).computeDerivedCharacteristics(primary);
  }

  void incrementSkill(String key) {
    if (state.skillPointsRemaining <= 0) return;
    final updated = Map<String, int>.from(state.skillAllocated);
    updated[key] = (updated[key] ?? 0) + 1;
    state = state.copyWith(skillAllocated: updated);
  }

  void decrementSkill(String key) {
    final current = state.skillAllocated[key] ?? 0;
    if (current <= 0) return;
    final updated = Map<String, int>.from(state.skillAllocated);
    updated[key] = current - 1;
    state = state.copyWith(skillAllocated: updated);
  }

  /// Persists the character and returns its new id.
  Future<String> submit() async {
    state = state.copyWith(isSubmitting: true);
    try {
      final repo = ref.read(characterRepositoryProvider);
      final rules = ref.read(rulesEngineProvider);
      final primary = state.resolvedCharacteristics;
      final derived = rules.computeDerivedCharacteristics(primary);

      var order = 0;
      final stats = <CharacterStat>[];
      for (final c in CthulhuSeed.primaryCharacteristics) {
        stats.add(_draftStat(
          kind: StatKind.characteristic,
          key: c.key,
          label: c.label,
          value: primary[c.key] ?? 0,
          sortOrder: order++,
        ));
      }
      for (final c in CthulhuSeed.derivedCharacteristics) {
        stats.add(_draftStat(
          kind: StatKind.characteristic,
          key: c.key,
          label: c.label,
          value: derived[c.key] ?? 0,
          sortOrder: order++,
        ));
      }
      var skillOrder = 0;
      for (final s in CthulhuSeed.skillCatalog) {
        stats.add(_draftStat(
          kind: StatKind.skill,
          key: s.key,
          label: s.label,
          value: state.valueFor(s),
          base: s.baseDisplay,
          sortOrder: skillOrder++,
        ));
      }

      final con = primary['CON'] ?? 0;
      final tai = primary['TAI'] ?? 0;
      final pou = primary['POU'] ?? 0;
      final pvMax = (((con + tai) / 10).round()).clamp(1, 999);
      final sanMax = pou.clamp(0, 99);
      final pmMax = ((pou / 5).round()).clamp(0, 99);

      final resources = [
        _draftResource(key: 'PV', label: 'PV', value: pvMax, tone: Tone.danger),
        _draftResource(key: 'SAN', label: 'SAN', value: sanMax, tone: Tone.info),
        _draftResource(key: 'PM', label: 'PM', value: pmMax, tone: Tone.warning),
      ];

      final created = await repo.create(
        systemId: CthulhuSeed.systemId,
        name: state.name.trim().isEmpty ? 'Aventurier sans nom' : state.name.trim(),
        occupation: state.occupation,
        description: state.description.trim().isEmpty ? null : state.description.trim(),
        stats: stats,
        resources: resources,
      );
      return created.id;
    } finally {
      state = state.copyWith(isSubmitting: false);
    }
  }

  // The repository assigns real ids/characterId when it inserts — these
  // drafts only carry the values it needs to persist.
  CharacterStat _draftStat({
    required StatKind kind,
    required String key,
    required String label,
    required int value,
    String? base,
    required int sortOrder,
  }) {
    return CharacterStat(
      id: '',
      characterId: '',
      kind: kind,
      key: key,
      label: label,
      value: value,
      base: base,
      sortOrder: sortOrder,
    );
  }

  CharacterResource _draftResource({
    required String key,
    required String label,
    required int value,
    required Tone tone,
  }) {
    return CharacterResource(
      id: '',
      characterId: '',
      key: key,
      label: label,
      current: value,
      max: value,
      tone: tone,
    );
  }
}

final characterCreationProvider =
    NotifierProvider<CharacterCreationNotifier, CharacterCreationState>(
  CharacterCreationNotifier.new,
);
