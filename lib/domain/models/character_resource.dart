import 'package:freezed_annotation/freezed_annotation.dart';

import 'tone.dart';

part 'character_resource.freezed.dart';

/// A trackable resource (HP/Sanity/Magic-style) shown as a header badge and
/// adjustable via the resource-edit modal.
@freezed
abstract class CharacterResource with _$CharacterResource {
  const factory CharacterResource({
    required String id,
    required String characterId,
    required String key,
    required String label,
    required int current,
    required int max,
    @Default(Tone.neutral) Tone tone,
  }) = _CharacterResource;
}
