import 'package:freezed_annotation/freezed_annotation.dart';

part 'inventory_item.freezed.dart';

@freezed
abstract class InventoryItem with _$InventoryItem {
  const factory InventoryItem({
    required String id,
    required String characterId,
    required String name,
    @Default(1) int qty,
    String? weight,
  }) = _InventoryItem;
}
