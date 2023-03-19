import 'package:periodt/provider/auth/uuid_provider.dart';
import 'package:riverpod/riverpod.dart';

import 'word_list_provider.dart';
String concatenateList(List<String> list, String str) {
  return list.map((e) => e.toString()).join('') + str;
}


final combinedProvider = Provider<String>((ref) {
  final selectedWords = ref.watch(selectedWordsProvider);
  final uuid = ref.watch(uuidStateProvider);
  return concatenateList(selectedWords, uuid);
});
