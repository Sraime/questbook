import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../domain/models/game_table.dart';

final tableListProvider = StreamProvider<List<GameTable>>((ref) {
  return ref.watch(tableRepositoryProvider).watchAll();
});
