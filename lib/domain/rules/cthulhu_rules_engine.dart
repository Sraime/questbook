import 'dart:math';

import '../../services/dice_service.dart';
import 'rules_engine.dart';

/// Call of Cthulhu 7th edition rules, seeded as Questbook's default system.
///
/// - Characteristics are rolled 3d6, scaled ×5, plus a flat occupation bonus
///   (percentage points) — giving the usual 15-90 characteristic range.
/// - Derived characteristics: ESQ (Dodge) = DEX/2 and MVT (Movement) follow
///   the real CoC7 formulas. COR (Build) and IMP (damage bonus) are
///   simplified to a single small integer tier from the STR+SIZ table
///   (the rulebook's damage bonus is technically a die expression like
///   "+1D4"; the generic schema stores stats as plain ints, so the tier
///   index is shown instead of a dice string).
/// - Skill checks: 01-05 is always a critical success, 96-100 is always a
///   critical failure (the simplified rule stated in the design system's own
///   rules reference), otherwise success if the roll is <= the target value.
class CthulhuRulesEngine implements RulesEngine {
  const CthulhuRulesEngine();

  @override
  String get systemId => 'cthulhu-v7';

  @override
  CharacteristicRoll rollCharacteristic({int bonus = 0, Random? random}) {
    final dice = DiceService.rollDice(3, 6, random: random);
    final sum = dice.fold(0, (a, b) => a + b);
    return CharacteristicRoll(dice: dice, bonus: bonus, total: sum * 5 + bonus);
  }

  @override
  Map<String, int> computeDerivedCharacteristics(Map<String, int> primary) {
    final str = primary['FOR'] ?? 0;
    final dex = primary['DEX'] ?? 0;
    final siz = primary['TAI'] ?? 0;

    final esquive = dex ~/ 2;

    int mvt;
    if (dex < siz && str < siz) {
      mvt = 7;
    } else if (dex > siz && str > siz) {
      mvt = 9;
    } else {
      mvt = 8;
    }

    final buildSum = str + siz;
    final int tier;
    if (buildSum <= 64) {
      tier = -2;
    } else if (buildSum <= 84) {
      tier = -1;
    } else if (buildSum <= 124) {
      tier = 0;
    } else if (buildSum <= 164) {
      tier = 1;
    } else if (buildSum <= 204) {
      tier = 2;
    } else {
      tier = 3;
    }

    return {
      'ESQ': esquive,
      'MVT': mvt,
      'COR': tier,
      'IMP': tier,
    };
  }

  @override
  SkillCheckResult rollSkillCheck(int targetValue, {Random? random}) {
    final roll = DiceService.rollD100(random: random);
    final CheckOutcome outcome;
    if (roll <= 5) {
      outcome = CheckOutcome.criticalSuccess;
    } else if (roll >= 96) {
      outcome = CheckOutcome.criticalFailure;
    } else if (roll <= targetValue) {
      outcome = CheckOutcome.success;
    } else {
      outcome = CheckOutcome.failure;
    }
    return SkillCheckResult(roll: roll, outcome: outcome);
  }
}
