import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:questbook/domain/rules/cthulhu_rules_engine.dart';
import 'package:questbook/domain/rules/rules_engine.dart';

void main() {
  const engine = CthulhuRulesEngine();

  group('rollCharacteristic', () {
    test('total is dice*5 + bonus', () {
      final roll = engine.rollCharacteristic(bonus: 5, random: Random(1));
      expect(roll.dice, hasLength(3));
      expect(roll.total, roll.diceSum * 5 + 5);
    });

    test('dice sum is always between 3 and 18', () {
      final random = Random(9);
      for (var i = 0; i < 200; i++) {
        final roll = engine.rollCharacteristic(random: random);
        expect(roll.diceSum, inInclusiveRange(3, 18));
      }
    });
  });

  group('computeDerivedCharacteristics', () {
    test('ESQ is DEX/2', () {
      final derived = engine.computeDerivedCharacteristics(
        {'FOR': 50, 'DEX': 63, 'TAI': 50},
      );
      expect(derived['ESQ'], 31);
    });

    test('MVT is 8 for average characteristics', () {
      final derived = engine.computeDerivedCharacteristics(
        {'FOR': 50, 'DEX': 50, 'TAI': 50},
      );
      expect(derived['MVT'], 8);
    });

    test('MVT is 9 when DEX and FOR both exceed TAI', () {
      final derived = engine.computeDerivedCharacteristics(
        {'FOR': 80, 'DEX': 80, 'TAI': 30},
      );
      expect(derived['MVT'], 9);
    });

    test('MVT is 7 when DEX and FOR are both below TAI', () {
      final derived = engine.computeDerivedCharacteristics(
        {'FOR': 30, 'DEX': 30, 'TAI': 80},
      );
      expect(derived['MVT'], 7);
    });
  });

  group('rollSkillCheck', () {
    test('01-05 is always a critical success regardless of target', () {
      // A Random seed isn't reliable for forcing an exact roll, so drive the
      // outcome boundaries directly through repeated seeded sampling instead.
      final random = Random(3);
      SkillCheckResult? critical;
      for (var i = 0; i < 2000 && critical == null; i++) {
        final result = engine.rollSkillCheck(1, random: random);
        if (result.roll <= 5) critical = result;
      }
      expect(critical, isNotNull);
      expect(critical!.outcome, CheckOutcome.criticalSuccess);
    });

    test('96-100 is always a critical failure regardless of target', () {
      final random = Random(4);
      SkillCheckResult? critical;
      for (var i = 0; i < 2000 && critical == null; i++) {
        final result = engine.rollSkillCheck(99, random: random);
        if (result.roll >= 96) critical = result;
      }
      expect(critical, isNotNull);
      expect(critical!.outcome, CheckOutcome.criticalFailure);
    });

    test('roll <= target (outside crit ranges) is a success', () {
      final result = engine.rollSkillCheck(50, random: Random(999));
      if (result.roll > 5 && result.roll < 96) {
        expect(
          result.outcome,
          result.roll <= 50 ? CheckOutcome.success : CheckOutcome.failure,
        );
      }
    });
  });
}
