import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';
import 'uuid_digit_spinner.dart';

class UuidTextInput extends StatefulWidget {
  @override
  _UuidTextInputState createState() => _UuidTextInputState();
}

class _UuidTextInputState extends State<UuidTextInput> {
  late final String uuid;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    uuid = Uuid().v4();
    _controller = TextEditingController(text: uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
