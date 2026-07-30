import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_table.freezed.dart';

@freezed
abstract class GameTable with _$GameTable {
  const factory GameTable({
    required String id,
    required String title,
    required String universeLabel,
    DateTime? nextSession,
    String? systemId,
  }) = _GameTable;
}
