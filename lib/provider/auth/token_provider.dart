import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod/riverpod.dart';

class TokenProvider extends StateNotifier<AsyncValue<String?>> {
  TokenProvider() : super(const AsyncValue.loading()) {
    _loadToken();
  }

  Box<String> tokenBox = Hive.box<String>('tokenBox');
  String? token;

  Future<void> _loadToken() async {
    token = tokenBox.get('token');
    if (token != null) {
      state = AsyncValue.data(token);
    } else {
      state = const AsyncValue.error('Token not found');
    }
  }

  // ... rest of the class
}