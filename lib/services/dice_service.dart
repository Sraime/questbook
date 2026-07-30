import 'dart:math';

/// Raw dice mechanics, kept separate from any game system's rules
/// (see domain/rules) so it stays trivially unit-testable and reusable
/// across rulesets.
abstract final class DiceService {
  static int rollDie(int sides, {Random? random}) {
    assert(sides > 0, 'sides must be positive');
    final rng = random ?? Random();
    return 1 + rng.nextInt(sides);
  }

  static List<int> rollDice(int count, int sides, {Random? random}) {
    final rng = random ?? Random();
    return List.generate(count, (_) => rollDie(sides, random: rng));
  }

  static int rollD100({Random? random}) => rollDie(100, random: random);
}
