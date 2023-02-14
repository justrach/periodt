import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

final signUpProvider = ChangeNotifierProvider<SignUpProvider>((ref) => SignUpProvider());

class SignUpProvider extends ChangeNotifier {
  String? token;

  Future<bool> signUp(String email, String password, String firstName, String lastName) async {
    final response = await http.post(
      Uri.parse("http://localhost:3000/signup"),
      headers: <String, String>{"Content-Type": "application/json"},
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
        "firstName": firstName,
        "lastName": lastName,
      }),
    );

    if (response.statusCode == 200) {
      token = response.body;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}

class ReadHiveBox extends StateNotifier{
  ReadHiveBox() : super(null);

  void readHiveBox() async {
    final box = await Hive.openBox('tokenBox');
    final token = box.get('token');
    print(token);
  }
}

class SignUpPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _firstNameController = TextEditingController();
    final _lastNameController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: "First Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your first name";
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: "Last Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your last name";
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    final firstName = _firstNameController.text;
                    final lastName = _lastNameController.text;
                    final success = await ref.read(signUpProvider).signUp(email, password, firstName, lastName);
                    if (success) {
                      Navigator.pushReplacementNamed(context, "/home");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Could not sign up. Please try again later."),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  }
                },
                child: Text("Sign Up"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
