// // import 'package:flutter/material.dart';


// // class HorizontalDatePicker extends StatefulWidget {
// //   @override
// //   _HorizontalDatePickerState createState() => _HorizontalDatePickerState();
// // }

// // class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
// //   DateTime _selectedDate = DateTime.now();

// //   // List<DateTime> _generateWeekDates(DateTime currentDate) {
// //   //   final startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday - 1));
// //   //   return List<DateTime>.generate(7, (index) => startOfWeek.add(Duration(days: index)));
// //   // }
// // List<DateTime> _generateDates(DateTime currentDate, {int weeks = 52}) {
// //   final startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday - 1));
// //   return List<DateTime>.generate(7 * weeks, (index) => startOfWeek.add(Duration(days: index)));
// // }

// //   @override
// //   Widget build(BuildContext context) {
// //     final dates = _generateWeekDates(_selectedDate);
// //     return  Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Text(
// //               'Selected Date: ${_selectedDate.toString()}',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             SizedBox(height: 24),
// //             Container(
// //               height: 60,
// //               child: PageView.builder(
// //                 controller: PageController(viewportFraction: 0.25),
// //                 itemBuilder: (BuildContext context, int index) {
// //                   return GestureDetector(
// //                     onTap: () {
// //                       setState(() {
// //                         _selectedDate = dates[index];
// //                       });
// //                     },
// //                     child: Card(
// //                       color: dates[index].day == _selectedDate.day ? Colors.blue : Colors.white,
// //                       child: Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Center(
// //                           child: Text(
// //                             dates[index].day.toString(),
// //                             style: TextStyle(
// //                               fontSize: 24,
// //                               color: dates[index].day == _selectedDate.day ? Colors.white : Colors.black,
// //                             ),
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   );
// //                 },
// //                 itemCount: dates.length,
// //               ),
// //             ),
// //           ],
// //         ),
  
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';


// class HorizontalDatePicker extends StatefulWidget {
//   @override
//   _HorizontalDatePickerState createState() => _HorizontalDatePickerState();
// }

// class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
//   DateTime _selectedDate = DateTime.now();

//   List<DateTime> _generateWeekDates(DateTime currentDate) {
//     final startOfWeek = currentDate.subtract(Duration(days: currentDate.weekday - 1));
//     return List<DateTime>.generate(7, (index) => startOfWeek.add(Duration(days: index)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final dates = _generateWeekDates(_selectedDate);
//     return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'Selected Date: ${_selectedDate.toString()}',
//               style: TextStyle(fontSize: 16),
//             ),
//             SizedBox(height: 24),
//             Container(
//               height: 60,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemBuilder: (BuildContext context, int index) {
//                   return GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         _selectedDate = dates[index];
//                       });
//                     },
//                     child: Card(
//                       color: dates[index].day == _selectedDate.day ? Colors.blue : Colors.white,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Center(
//                           child: Text(
//                             dates[index].day.toString(),
//                             style: TextStyle(
//                               fontSize: 24,
//                               color: dates[index].day == _selectedDate.day ? Colors.white : Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (BuildContext context, int index) => SizedBox(width: 8),
//                 itemCount: dates.length,
//               ),
//             ),
//           ],
//         ),
   
//     );
//   }
// }


import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HorizontalDatePicker(),
    );
  }
}

class HorizontalDatePicker extends StatefulWidget {
  @override
  State<HorizontalDatePicker> createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  DateTime _selectedDate = DateTime.now();

  DateTime _getDateByIndex(int index) {
    final currentDate = DateTime.now();
    return currentDate.add(Duration(days: index - currentDate.weekday + 1));
  }

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
              height: 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: ( context,  index) {
                  final date = _getDateByIndex(index);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                    child: Card(
                      color: date.day == _selectedDate.day &&
                              date.month == _selectedDate.month &&
                              date.year == _selectedDate.year
                          ? Colors.blue
                          : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(
                              fontSize: 24,
                              color: date.day == _selectedDate.day &&
                                      date.month == _selectedDate.month &&
                                      date.year == _selectedDate.year
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
 
    );
  }
}
