import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:periodt/provider/auth/token_provider.dart';

import '../../ui/auth/login_page.dart';
import 'onboarder_provider.dart';

class TextInputWithCounter extends StatefulWidget {
  @override
  // ignore: no_private_typedef_functions
  State<TextInputWithCounter> createState() => _TextInputWithCounterState();
}

class _TextInputWithCounterState extends State<TextInputWithCounter> {
  late final TextEditingController _controller;
  bool _isValid = false;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final tokenProvider =
    StateNotifierProvider<TokenProvider, AsyncValue<String?>>(
            (ref) => TokenProvider());

    return Row(
      children: [
        Expanded(
          child: Consumer(
            builder: (context, ref,child) =>
           Form(
              key: formKey,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Type at least 15 characters',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    _isValid = value.length >= 15;
                  });
                },
              ),
            ),
          ),
        ),
          Consumer(
          builder: (context, ref,child) =>
    IconButton(
          icon: const Icon(Icons.check),
          onPressed: _isValid
              ? () async {
            final email = _controller.text;
            final password = _controller.text;
            final success =
                await ref.read(loginProvider).login(email, password);
    if (success) {
      final userId = ref.watch(tokenProvider).when(
        data: (token) => token,
        loading: () => null,
        error: (_, __) => null,
      );
      final hasCompletedOnboarding =
      userId != null ? ref.watch(onboardingStatusProvider(userId)) : false;
      if(hasCompletedOnboarding) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/onboarding');
      }
      // Navigator.pushReplacementNamed(context, '/home');
    }else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Invalid email or password'),
        duration: Duration(seconds: 2),
      ));
    }
            // Perform action here when the button is clicked
            print('Checkmark button clicked');
          }
              : null,
          color: _isValid ? Colors.red : Colors.grey,
        ),),
      ],
    );
  }
}
