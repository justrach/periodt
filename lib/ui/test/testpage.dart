import 'package:flutter/material.dart';

import '../../components/Input/uuid/clipboard_uuid.dart';
import '../../components/buttons/base_button.dart';




class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              buttonType: ButtonType.elevated,
              onPressed: () => print('Elevated Button Pressed'),
              child: const Text('Elevated Button', style: TextStyle(
                  color: Colors.white
              )),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: UuidTextInput(),
            ),
          ],
        ),
      ),
    );
  }
}
