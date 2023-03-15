import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'token/tokenmodel.dart';

final loginProvider =
    ChangeNotifierProvider<LoginProvider>((ref) => LoginProvider());

class LoginProvider extends ChangeNotifier {
  Box<String> tokenBox = Hive.box<String>('tokenBox');
  String? token;

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('http://192.168.17.172:3000/login');
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = jsonEncode(<String, String>{
      'email': email,
      'password': password,
    });
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      String jsonString = response.body;
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      TokenModel tokenModel = TokenModel.fromJson(jsonMap);
      print('the value of token is ${tokenModel.token!}');
      token = tokenModel.token;
      tokenBox.put('token', tokenModel.token!);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  void logout() {
    // token = null;
    tokenBox.delete('token');
    // notifyListeners();
  }

  String? loginToken() {
    token = tokenBox.get('token');
    // notifyListeners();
    return token;
  }
}

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xffFFDAD8),
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color(0xffFAFAFA),
      ),
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
              Text(ref.read(loginProvider).loginToken() ?? 'Not logged in'),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final email = emailController.text;
                    final password = passwordController.text;
                    final success =
                        await ref.read(loginProvider).login(email, password);
                    if (success) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Invalid email or password'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  }
                },
                child:const  Text('Log in'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('Sign Up'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
