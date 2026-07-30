import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../domain/models/character.dart';

final characterListProvider = StreamProvider<List<Character>>((ref) {
  return ref.watch(characterRepositoryProvider).watchAll();
});
