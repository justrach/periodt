import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:periodt/provider/auth/combined_provider.dart';

import '../../../components/buttons/button_shape.dart';
import '../../../signup_page.dart';

class LastCycleDuration extends ConsumerWidget {

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
