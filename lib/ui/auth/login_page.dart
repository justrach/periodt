import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../provider/auth/biometric_auth.dart';
import '../../provider/auth/login_auth_provider.dart';
import 'dart:convert';


import '../../token/tokenmodel.dart';

final loginProvider =
    ChangeNotifierProvider<LoginProvider>((ref) => LoginProvider());

class LoginProvider extends ChangeNotifier {
  Box<String> tokenBox = Hive.box<String>('tokenBox');
  final storage = const FlutterSecureStorage();
  String? token;

  Future<bool> login(String email, String password) async {
    print(email);
    final url = Uri.parse('https://periodttt.app/login');
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };
    final body = jsonEncode(<String, String>{
      'username': email,
      'password': password,
    });
    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      String jsonString = response.body;
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      TokenModel tokenModel = TokenModel.fromJson(jsonMap);
      print('the value of token is ${tokenModel.token!}');
      token = tokenModel.token;
      await saveCredentials(email, password);
      tokenBox.put('token', tokenModel.token!);
      await storage.write(key: 'token', value: tokenModel.token);
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
  Future<void> saveCredentials(String username, String password) async {
    await storage.write(key: 'username', value: username);
    await storage.write(key: 'password', value: password);
  }

  Future<Map<String, String>?> readCredentials() async {
    final username = await storage.read(key: 'username');
    final password = await storage.read(key: 'password');

    if (username != null && password != null) {
      return {'username': username, 'password': password};
    }
    return null;
  }

  Future<void> logout() async {
    // token = null;
    await storage.delete(key: 'token');
    await tokenBox.delete('token');

    notifyListeners();
  }
  Future<void> logoutTotal() async {
    // token = null;
    await storage.delete(key: 'token');
    await storage.delete(key: 'username');
    await storage.delete(key: 'password');
    await tokenBox.delete('token');


    notifyListeners();
  }

  Future<String?> loginToken() async {
    token = await storage.read(key: 'token');
    token = tokenBox.get('token');
    // notifyListeners();
    return token;
  }
}

class LoginPage extends ConsumerWidget {
  // final _biometricAuth = BiometricAuth();
  //
  // Future<void> _authenticate(BuildContext context, WidgetRef ref) async {
  //   bool isBiometricAvailable = await _biometricAuth.isBiometricAvailable();
  //   if (isBiometricAvailable) {
  //     bool isAuthenticated = await _biometricAuth.authenticateWithBiometrics();
  //     if (isAuthenticated) {
  //       String? token = await ref.read(loginProvider).loginToken();
  //       if (token != null) {
  //         // Recreate the JWT token with local authentication
  //         // ...
  //
  //         Navigator.pushReplacementNamed(context, '/home');
  //       } else {
  //         // Show login screen if token is not available
  //       }
  //     } else {
  //       // Show an error message if authentication failed
  //     }
  //   } else {
  //    await ref.read(loginProvider).logout();
  //     Navigator.pushReplacementNamed(context, '/login');
  //   }
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // WidgetsBinding.instance.addPostFrameCallback((_) => _authenticate(context, ref));
    final formKey = GlobalKey<FormState>();


    return Scaffold(
      backgroundColor: const Color(0xffFFDAD8),
      appBar: AppBar(
        title: const Text('Periodt'),
        // leading: Center(child: const Text('Periodt', style: TextStyle(
        //   fontSize: 24,
        //   fontWeight: FontWeight.bold,
        // ),)),
        // backgroundColor: const Color(0xffFAFAFA),
        backgroundColor:  Colors.transparent,

      ),

      body:  LayoutBuilder(
        builder: (context, constraints) {
      return Center(
        // padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Center(

      //       CircleAvatar(
      //         backgroundColor: themeController.isDarkModeOn
      //             ? Colors.white
      //             : Colors.black,
      //         child: themeController.isDarkModeOn
      //             ? Image(image: AssetImage("assets/images/logo_light-modified.png"))
      //             : Image(image: AssetImage("assets/images/logo_dark-modified.png")),
      //         radius: 50.0,
      //       ),
      //     )),
      // ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const AvatarGlow(
                      endRadius: 250,
                      duration: Duration(seconds: 3),
                      repeatPauseDuration: Duration(seconds: 1),
                      startDelay: Duration(seconds: 1),
                      child: CircleAvatar(
                        radius: 100,
                        child: Image(image: AssetImage('assets/images/periodt.png')
                      )),),
                  // TextFormField(
                  //   controller: emailController,
                  //   decoration: const InputDecoration(labelText: 'Email'),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your email';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  // TextFormField(
                  //   controller: passwordController,
                  //   decoration: const InputDecoration(labelText: 'Password'),
                  //   obscureText: true,
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return 'Please enter your password';
                  //     }
                  //     return null;
                  //   },
                  // ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('Log in ', textAlign: TextAlign.left, style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0, top: 8),
                    child: Text('Enter your account number ', textAlign: TextAlign.left, style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only( left: 16.0, top: 8),
                    child: Column(
                      children: [

                        TextInputWithCounter(),
                      ],
                    ),
                  ),

                  // Text(ref.read(loginProvider).loginToken() ?? 'Not logged in'),
                  // const SizedBox(height: 16.0),
                  // ElevatedButton(
                  //   onPressed: () async {
                  //     if (formKey.currentState!.validate()) {
                  //       final email = emailController.text;
                  //       final password = passwordController.text;
                  //       final success =
                  //           await ref.read(loginProvider).login(email, password);
                  //       if (success) {
                  //         Navigator.pushReplacementNamed(context, '/home');
                  //       } else {
                  //         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  //           content: Text('Invalid email or password'),
                  //           duration: Duration(seconds: 2),
                  //         ));
                  //       }
                  //     }
                  //   },
                  //   child:const  Text('Log in'),
                  // ),
                  // //
                  // // const SizedBox(height: 16.0),
                  // // Consumer(
                  // //   builder: (context, ref, child) {
                  // //    return(
                  // //    Text('UUID: ${ref.watch(uuidStateProvider)}')
                  // //
                  // //    );
                  // //   },
                  // // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pushNamed(context, '/signup');
                  //   },
                  //   child: const Text('Sign Up'),
                  //
                  // ),
                  const SizedBox(height: 50,),
                  Column(
                    children: [
                      const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text('No Account?', textAlign: TextAlign.left, style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),

                      Padding(
                        padding: const EdgeInsets.only(bottom:8.0, top: 4),
                        child: Align(
                          alignment: const Alignment(0, 4),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/newSign');
                            },
                            child: const Text('Sign Up'),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      );
    },
      ),
    );
  }
}
