import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../components/Input/uuid/clipboard_uuid.dart';
import '../../components/buttons/base_button.dart';
import '../../provider/auth/auth_provider.dart';




class TestPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      backgroundColor: const Color(0xffFAFAFA),

      body: Center(
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: UuidTextInput(),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // final token = await ref.read(signupProvider(uruid).future);
                  // final tokenBox = ref.read(tokenBoxProvider);
                  // await tokenBox.put('jwt_token', token);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Signed up and JWT token saved!')),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error signing up: $e')),
                  );
                }
              },
              child: Text('Buttonrrr In'),
            ),
          ],
        ),
      ),
    );
  }
}
