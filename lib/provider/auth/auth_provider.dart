// auth_provider.dart
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:crypto/crypto.dart';

final tokenBoxProvider = FutureProvider<Box>((ref) async {
  // Use a strong key for encryption
  final passphrase = 'your-strong-passphrase';
  final List<int> key = sha256.convert(utf8.encode(passphrase)).bytes;

  final box = await Hive.openBox(
    'secure_token',
    encryptionCipher: HiveAesCipher(key),
  );

  return box;
});

final signupProvider = Provider.family<void, String>((ref, uuid) async {
  final response = await http.post(
    Uri.parse('http://localhost:3000/signup'),
    body: json.encode({'uuid': uuid}),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final token = json.decode(response.body)['token'];
    final tokenBox = await ref.watch(tokenBoxProvider.future);
    await tokenBox.put('jwt_token', token);
  } else {
    throw Exception('Failed to sign up');
  }
});
