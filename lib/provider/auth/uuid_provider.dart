// uuid_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

final uuidStateProvider = StateProvider<String>((ref) {
  return '';
});

final itemCountProvider = StateProvider<int>((ref) {
  return 0;
});