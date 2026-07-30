import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:questbook/services/dice_service.dart';

void main() {
  group('DiceService', () {
    test('rollDie stays within [1, sides] over many rolls', () {
      final random = Random(42);
      for (var i = 0; i < 500; i++) {
        final roll = DiceService.rollDie(6, random: random);
        expect(roll, inInclusiveRange(1, 6));
      }
    });

    test('rollDice returns the requested count', () {
      final dice = DiceService.rollDice(3, 6, random: Random(1));
      expect(dice, hasLength(3));
      for (final d in dice) {
        expect(d, inInclusiveRange(1, 6));
      }
    });

    test('rollD100 stays within [1, 100]', () {
      final random = Random(7);
      for (var i = 0; i < 500; i++) {
        expect(DiceService.rollD100(random: random), inInclusiveRange(1, 100));
      }
    });

    test('is deterministic given a seeded Random', () {
      expect(
        DiceService.rollDice(3, 6, random: Random(123)),
        DiceService.rollDice(3, 6, random: Random(123)),
      );
    });
  });
}
