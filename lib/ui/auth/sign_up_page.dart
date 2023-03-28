import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../../components/Input/uuid/clipboard_uuid.dart';
import '../../components/buttons/button_shape.dart';
import '../../provider/auth/combined_provider.dart';
import '../../provider/auth/word_generator.dart';
import '../../token/tokenmodel.dart';

class SignUpPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final result = eval(dynamicCode);

    return Scaffold(
      backgroundColor: const Color(0xffFFF8F8),

      body: Center(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          

              const SizedBox(height: 16),

              const Text(
                'This is your unique ID, it is your password as well.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  // color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: UuidTextInput(),
              ),
              const SizedBox(height: 16),
              // const Text(
              //   textAlign: TextAlign.center,
              //   'Select a few words below to make the password more random, and hence more secure',
              //   style: TextStyle(
              //     fontSize: 16,
              //     fontWeight: FontWeight.w300,
              //     // color: Colors.blue,
              //   ),
              // ),
              // const SizedBox(height: 16),

            // ElevatedButton(
              //   onPressed: () async {
              //     try {
              //       // final token = await ref.read(signupProvider(uruid).future);
              //       // final tokenBox = ref.read(tokenBoxProvider);
              //       // await tokenBox.put('jwt_token', token);
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text('Signed up and JWT token saved!')),
              //       );
              //     } catch (e) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text('Error signing up: $e')),
              //       );
              //     }
              //   },
              //   child: Text('Buttonrrr In'),
              // ),

              // Padding(padding: const EdgeInsets.all(16.0),
              //   child:
              //       Center(
              //         child: RandomWordsSelection() ,
              //       )
              //  ),
              //
              // Padding(padding: const EdgeInsets.all(16.0),
              //     child:
              //     Consumer(
              //       builder: (context, watch, child) {
              //         late final TextEditingController controller2;
              //
              //         final password = ref.watch(combinedProvider);
              //         controller2 = TextEditingController(text: password);
              //
              //         return Row(
              //           children: [
              //         Expanded(child: TextField(
              //           key: const Key('password'),
              //           decoration: const InputDecoration(
              //             labelText: 'This is your account name!',
              //             border: OutlineInputBorder(),
              //           ),
              //             controller: controller2, readOnly: true,)),
              //             IconButton(
              //               icon: const Icon(Icons.content_copy),
              //               onPressed: () {
              //                 Clipboard.setData(ClipboardData(text: password));
              //                 ScaffoldMessenger.of(context).showSnackBar(
              //                   const SnackBar(content: Text('UUID copied to clipboard!')),
              //                 );
              //               },
              //             ),
              //           ],
              //         );
              //       },
              //       // child: RandomWordsSelection() ,
              //     )
              // ),
              // const SizedBox(height: 16),
              // const Padding(
              //   padding: EdgeInsets.all(8.0),
              //   child: Text(
              //     textAlign: TextAlign.center,
              //     'Please note that if you lose the code above, you will not be able to recover your account. It is important to save this code in a safe and secure place.',
              //     style: TextStyle(
              //
              //       fontSize: 16,
              //       color: Colors.red,
              //     ),
              //   ),
              // ),
              MyButton(
                icon: Icons.arrow_forward,
                shape: ButtonShape.rounded,onPressed: () {
                Navigator.pushReplacementNamed(context, '/selectWords');
              },

              )

            ],
          ),
        ),
      ),
    );
  }
}


class SelectWords extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final result = eval(dynamicCode);

    return Scaffold(
      backgroundColor: const Color(0xffFFF8F8),

      body: Center(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CustomButton(
              //   buttonType: ButtonType.elevated,
              //   onPressed: () => print('Elevated Button Pressed'),
              //   child: const Text('Elevated Button', style: TextStyle(
              //       color: Colors.white
              //   )),
              // ),


              const SizedBox(height: 16),
              const Text(
                textAlign: TextAlign.center,
                'Select a few words below to make the password more random, and hence more secure',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  // color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),

              // ElevatedButton(
              //   onPressed: () async {
              //     try {
              //       // final token = await ref.read(signupProvider(uruid).future);
              //       // final tokenBox = ref.read(tokenBoxProvider);
              //       // await tokenBox.put('jwt_token', token);
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text('Signed up and JWT token saved!')),
              //       );
              //     } catch (e) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text('Error signing up: $e')),
              //       );
              //     }
              //   },
              //   child: Text('Buttonrrr In'),
              // ),

              Padding(padding: const EdgeInsets.all(16.0),
                  child:
                  Center(
                    child: RandomWordsSelection() ,
                  )
              ),
              MyButton(
                icon: Icons.arrow_forward,
                shape: ButtonShape.rounded,onPressed: () {
                Navigator.pushReplacementNamed(context, '/finishLogin');
              },

              )



            ],
          ),
        ),
      ),
    );
  }
}


class FinishSignUp extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final result = eval(dynamicCode);

    return Scaffold(
      backgroundColor: const Color(0xffFFF8F8),

      body: Center(
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // CustomButton(
              //   buttonType: ButtonType.elevated,
              //   onPressed: () => print('Elevated Button Pressed'),
              //   child: const Text('Elevated Button', style: TextStyle(
              //       color: Colors.white
              //   )),
              // ),
              Padding(padding: const EdgeInsets.all(16.0),
                  child:
                  Consumer(
                    builder: (context, watch, child) {
                      late final TextEditingController controller2;

                      final password = ref.watch(combinedProvider);
                      controller2 = TextEditingController(text: password);

                      return Row(
                        children: [
                          Expanded(child: TextField(
                            key: const Key('password'),
                            decoration: const InputDecoration(
                              labelText: 'This is your account name!',
                              border: OutlineInputBorder(),
                            ),
                            controller: controller2, readOnly: true,)),
                          IconButton(
                            icon: const Icon(Icons.content_copy),
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: password));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('UUID copied to clipboard!')),
                              );
                            },
                          ),
                        ],
                      );
                    },
                    // child: RandomWordsSelection() ,
                  )
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'Please note that if you lose the code above, you will not be able to recover your account. It is important to save this code in a safe and secure place.',
                  style: TextStyle(

                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ),
              MyButton(
                text: 'Sign Up',
                shape: ButtonShape.rounded,onPressed: () async {
                final password = ref.watch(combinedProvider);
                final success = await ref
                    .read(signUpProvider)
                    .signUp(password, password);
                if (success) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                    Text('Could not sign up. Please try again later.'),
                    duration: Duration(seconds: 2),
                  ));
                }
                // Navigator.pushNamed(context, '/selectWords');
              },

              ),


            ],
          ),
        ),
      ),
    );
  }
}


final signUpProvider =
ChangeNotifierProvider<SignUpProvider>((ref) => SignUpProvider());

class SignUpProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  String? token;
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



  Future<bool> signUp(
      String email, String password) async {
    final response = await http.post(
      Uri.parse('https://periodttt.app/signup'),
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'username': email,
        'password': password,
        // 'firstName': firstName,
        // 'lastName': lastName,
      }),
    );
    print(response.statusCode);

    if (response.statusCode == 201) {
      token = response.body;
      await saveCredentials(email, password);
      String jsonString = response.body;
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      TokenModel tokenModel = TokenModel.fromJson(jsonMap);
      await storage.write(key: 'token', value: tokenModel.token);
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
