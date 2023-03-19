import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/Input/uuid/clipboard_uuid.dart';
import '../../components/buttons/base_button.dart';
import '../../provider/auth/auth_provider.dart';
import '../../provider/auth/combinedProvider.dart';
import '../../provider/auth/word_generator.dart';
// dynamic eval(String code) {
//   return Function.apply(Function.apply(Function.apply(
//           () => null,
//       code.split(';').map((s) => s.trim()).toList()),
//       [],
//       const [const {}]));
// }

class TestPage extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String dynamicCode = '2 + 2';
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

            ],
          ),
        ),
      ),
    );
  }
}
