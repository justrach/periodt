import 'package:flutter/cupertino.dart';

class DatePickerExample extends StatefulWidget {
  @override
  State<DatePickerExample> createState() => _DatePickerExampleState();
}

class _DatePickerExampleState extends State<DatePickerExample> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Selected Date: ${_selectedDate.toString()}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          Container(
            height: 200,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: DateTime.now(),
              onDateTimeChanged: ( newDate) {
                setState(() {
                  _selectedDate = newDate;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
