import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../provider/auth/uuid_provider.dart';
import 'uuid_digit_spinner.dart';

class UuidTextInput extends StatefulWidget {
  @override
  _UuidTextInputState createState() => _UuidTextInputState();
}

class _UuidTextInputState extends State<UuidTextInput> {
  // save UUID to provider
  late final String uuid;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    uuid = const Uuid().v4();
    _controller = TextEditingController(text: uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        // save UUID to provider
        Future.microtask(() => ref.read(uuidStateProvider.state).state = uuid);

      return  Column(
        children: [
          // Text('UUID: ${ref.watch(uuidStateProvider)}'),
          Row(
              children: [

                Expanded(
                  child: Stack(
                    children: [
                      TextField(
                        controller: _controller,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'This is your account name!',
                          border: OutlineInputBorder(),
                        ),
                        style: const TextStyle(fontSize: 16.0, color: Colors.transparent),
                      ),
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                            child: Row(
                              children: uuid.split('').map((digit) {
                                return digit == '-'
                                    ? const Text('-')
                                    : UuidDigitSpinner(
                                  digit: digit,
                                  duration: const Duration(milliseconds: 300),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.content_copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: uuid));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('UUID copied to clipboard!')),
                    );
                  },
                ),
              ],
            ),
        ],
      );
      },

    );
  }
}
