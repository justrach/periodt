// uuid_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

// final wordListProvider = StateProvider<List>((ref) {
//   return [];
// });
// final selectedWordsProvider =
// StateNotifierProvider((ref) => SelectedWordsNotifier());
//


// final selectedWordsProvider =
// StateNotifierProvider<SelectedWordsNotifier>((ref) => SelectedWordsNotifier());

// final selectedWordsProvider =
// StateNotifierProvider<SelectedWordsNotifier, List<String>>((ref) => SelectedWordsNotifier());
// final selectedWordsProvider =
// StateNotifierProvider((ref) => SelectedWordsNotifier());
final selectedWordsProvider = StateNotifierProvider<SelectedWordsNotifier, List<String>>((ref) => SelectedWordsNotifier());

class SelectedWordsNotifier extends StateNotifier<List<String>> {
  SelectedWordsNotifier() : super([]);

  void addWord(String word) {
    state = [...state, word];
  }

  void removeWord(String word) {
    state = state.where((w) => w != word).toList();
  }
}

