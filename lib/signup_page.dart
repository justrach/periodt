import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'token/tokenmodel.dart';

final signUpProvider =
    ChangeNotifierProvider<SignUpProvider>((ref) => SignUpProvider());

class SignUpProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  Box<String> tokenBox = Hive.box<String>('tokenBox');
  Box<dynamic> hasOnboarded = Hive.box<dynamic>('onboarding_status');
  String? token;
  Future<void> saveCredentials(String username, String password) async {
    await storage.write(key: 'username', value: username);
    await storage.write(key: 'password', value: password);
  }

  Future<bool> signUp(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('https://periodttt.app/signup'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'username': email,
        'password': password,

      }),
    );

    if (response.statusCode == 200) {
      token = response.body;
      String jsonString = response.body;
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      TokenModel tokenModel = TokenModel.fromJson(jsonMap);
      print('the value of token is ${tokenModel.token!}');
      token = tokenModel.token;
      await saveCredentials(email, password);
      tokenBox.put('token', tokenModel.token!);
      await storage.write(key: 'token', value: tokenModel.token);
      bool? hasOnBoarded = tokenModel.hasOnboarded;
      hasOnboarded.put('hasOnboarded', hasOnBoarded!);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}

class ReadHiveBox extends StateNotifier<dynamic> {
  ReadHiveBox() : super(null);

  void readHiveBox() async {
    final box = await Hive.openBox<dynamic>('tokenBox');
    final token = box.get('token');
    print(token);
  }
}

class SignUpPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final email = emailController.text;
                    final password = passwordController.text;

                    final success = await ref
                        .read(signUpProvider)
                        .signUp(email, password);
                    if (success) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('Could not sign up. Please try again later.'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
