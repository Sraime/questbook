import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

@DataClassName('GameSystemRow')
class GameSystems extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();

  /// JSON-encoded `List<String>` of suggested occupations for this system.
  TextColumn get occupationSuggestions => text().withDefault(const Constant('[]'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CharacterRow')
class Characters extends Table {
  TextColumn get id => text()();
  TextColumn get systemId => text().references(GameSystems, #id)();
  TextColumn get name => text()();
  TextColumn get occupation => text().nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get level => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Stores 'characteristic' or 'skill' — see domain/models/character_stat.dart's
/// StatKind, mapped to/from this text value in LocalCharacterRepository.
@DataClassName('CharacterStatRow')
class CharacterStats extends Table {
  TextColumn get id => text()();
  TextColumn get characterId =>
      text().references(Characters, #id, onDelete: KeyAction.cascade)();
  TextColumn get kind => text()();
  TextColumn get key => text()();
  TextColumn get label => text()();
  IntColumn get value => integer()();
  TextColumn get base => text().nullable()();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Stores the resource's tone as text ('neutral'/'danger'/…) — see
/// domain/models/tone.dart's Tone, mapped in LocalCharacterRepository.
@DataClassName('CharacterResourceRow')
class CharacterResources extends Table {
  TextColumn get id => text()();
  TextColumn get characterId =>
      text().references(Characters, #id, onDelete: KeyAction.cascade)();
  TextColumn get key => text()();
  TextColumn get label => text()();
  IntColumn get current => integer()();
  IntColumn get max => integer()();
  TextColumn get tone => text().withDefault(const Constant('neutral'))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('InventoryItemRow')
class InventoryItems extends Table {
  TextColumn get id => text()();
  TextColumn get characterId =>
      text().references(Characters, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  IntColumn get qty => integer().withDefault(const Constant(1))();
  TextColumn get weight => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('GameTableRow')
class GameTables extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get universeLabel => text()();
  DateTimeColumn get nextSession => dateTime().nullable()();
  TextColumn get systemId => text().nullable().references(GameSystems, #id)();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(
  tables: [
    GameSystems,
    Characters,
    CharacterStats,
    CharacterResources,
    InventoryItems,
    GameTables,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'questbook'));

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;
}
