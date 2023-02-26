// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:intl/intl.dart';
// // // // //
// // // // // class PeriodCountdownCircular extends StatefulWidget {
// // // // //   final DateTime periodStartDate;
// // // // //
// // // // //   const PeriodCountdownCircular({Key? key, required this.periodStartDate}) : super(key: key);
// // // // //
// // // // //   @override
// // // // //   _PeriodCountdownCircularState createState() => _PeriodCountdownCircularState();
// // // // // }
// // // // //
// // // // // class _PeriodCountdownCircularState extends State<PeriodCountdownCircular> with SingleTickerProviderStateMixin {
// // // // //   late AnimationController _animationController;
// // // // //   late Duration _remainingTime;
// // // // //
// // // // //   @override
// // // // //   void initState() {
// // // // //     super.initState();
// // // // //     _calculateRemainingTime();
// // // // //     _animationController = AnimationController(
// // // // //       vsync: this,
// // // // //       duration: _remainingTime,
// // // // //     );
// // // // //     _animationController.forward(from: 0);
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   void dispose() {
// // // // //     _animationController.dispose();
// // // // //     super.dispose();
// // // // //   }
// // // // //
// // // // //   void _calculateRemainingTime() {
// // // // //     final now = DateTime.now();
// // // // //     final start = widget.periodStartDate;
// // // // //     final difference = start.difference(now);
// // // // //     print(difference);
// // // // //     if (difference.isNegative) {
// // // // //       _remainingTime = Duration.zero;
// // // // //     } else {
// // // // //       _remainingTime = difference;
// // // // //     }
// // // // //   }
// // // // //
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return AnimatedBuilder(
// // // // //       animation: _animationController,
// // // // //       builder: (context, child) {
// // // // //         final percentage = _animationController.value;
// // // // //         final days = _remainingTime.inDays;
// // // // //         final hours = _remainingTime.inHours.remainder(24);
// // // // //         final minutes = _remainingTime.inMinutes.remainder(60);
// // // // //         final seconds = _remainingTime.inSeconds.remainder(60);
// // // // //         final periodDateTime = DateTime.now().add(_remainingTime);
// // // // //         final remaining = DateFormat('d \'days\', HH:mm \'hours\'').format(periodDateTime);
// // // // //
// // // // //         return SizedBox(
// // // // //           width: 150,
// // // // //           height: 150,
// // // // //           child: Stack(
// // // // //             children: [
// // // // //               Positioned.fill(
// // // // //                 child: CircularProgressIndicator(
// // // // //                   value: percentage,
// // // // //                   strokeWidth: 10,
// // // // //                   valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
// // // // //                   backgroundColor: Colors.grey[200],
// // // // //                 ),
// // // // //               ),
// // // // //               Center(
// // // // //                 child: Column(
// // // // //                   mainAxisAlignment: MainAxisAlignment.center,
// // // // //                   children: [
// // // // //                     Text(
// // // // //                       'Period in',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 16,
// // // // //                         color: Colors.grey[600],
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(height: 8),
// // // // //                     Text(
// // // // //                       '$days',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 24,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                       ),
// // // // //                     ),
// // // // //                     Text(
// // // // //                       'days',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 16,
// // // // //                         color: Colors.grey[600],
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(height: 8),
// // // // //                     Text(
// // // // //                       '$hours',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 24,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                       ),
// // // // //                     ),
// // // // //                     Text(
// // // // //                       'hours',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 16,
// // // // //                         color: Colors.grey[600],
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(height: 8),
// // // // //                     Text(
// // // // //                       '$seconds',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 24,
// // // // //                         fontWeight: FontWeight.bold,
// // // // //                       ),
// // // // //                     ),
// // // // //                     Text(
// // // // //                       'minutes',
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 16,
// // // // //                         color: Colors.grey[600],
// // // // //                       ),
// // // // //                     ),
// // // // //                     const SizedBox(height: 8),
// // // // //                     Text(
// // // // //                       remaining,
// // // // //                       style: TextStyle(
// // // // //                         fontSize: 12,
// // // // //                         color: Colors.grey[600],
// // // // //                       ),
// // // // //                     ),
// // // // //                   ],
// // // // //                 ),
// // // // //               ),
// // // // //             ],
// // // // //           ),
// // // // //         );
// // // // //       },
// // // // //     );
// // // // //   }
// // // // // }
// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // // // import 'package:riverpod/riverpod.dart';
// // // // import 'package:intl/intl.dart';
// // // //
// // // // final periodStartDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
// // // //
// // // // class PeriodCountdown extends ConsumerWidget {
// // // //   const PeriodCountdown({Key? key}) : super(key: key);
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context, WidgetRef ref) {
// // // //     final periodStartDate = ref.watch(periodStartDateProvider);
// // // //     final now = DateTime.now();
// // // //     final difference = periodStartDate.difference(now);
// // // //     final days = difference.inDays;
// // // //     final hours = difference.inHours.remainder(24);
// // // //     final minutes = difference.inMinutes.remainder(60);
// // // //     final remaining = DateFormat('d \'days\', HH:mm \'hours\'').format(periodStartDate);
// // // //
// // // //     return Column(
// // // //       children: [
// // // //         Text(
// // // //           'Period in:',
// // // //           style: TextStyle(fontSize: 16),
// // // //         ),
// // // //         const SizedBox(height: 8),
// // // //         Text(
// // // //           '$days days',
// // // //           style: TextStyle(
// // // //             fontSize: 24,
// // // //             fontWeight: FontWeight.bold,
// // // //           ),
// // // //         ),
// // // //         Text(
// // // //           '$hours hours',
// // // //           style: TextStyle(
// // // //             fontSize: 24,
// // // //             fontWeight: FontWeight.bold,
// // // //           ),
// // // //         ),
// // // //         Text(
// // // //           '$minutes minutes',
// // // //           style: TextStyle(
// // // //             fontSize: 24,
// // // //             fontWeight: FontWeight.bold,
// // // //           ),
// // // //         ),
// // // //         const SizedBox(height: 8),
// // // //         Text(
// // // //           remaining,
// // // //           style: TextStyle(
// // // //             fontSize: 12,
// // // //             color: Colors.grey[600],
// // // //           ),
// // // //         ),
// // // //       ],
// // // //     );
// // // //   }
// // // // }
// // //
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod/riverpod.dart';
// import 'package:intl/intl.dart';
//
// final periodStartDateProvider = StateProvider<Duration>((ref)
// {
//   final DateTime periodStartDate2 = DateTime(2023,2,24);
//   final now = DateTime.now();
//   print(now);
//   return periodStartDate2.difference(now);
// });
//
// class PeriodCountdown extends ConsumerWidget  {
//   const PeriodCountdown({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//
//         final periodStartDate = ref.read(periodStartDateProvider);
//         final now = DateTime.now();
//         final difference = periodStartDate;
//         final days = difference.inDays;
//         final hours = difference.inHours.remainder(24);
//         final minutes = difference.inSeconds.remainder(60);
//         // final remaining = DateFormat('d \'days\', HH:mm \'hours\'').format(periodStartDate);
//
//         return Column(
//           children: [
//             Text(
//               'Period in:',
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               '$periodStartDate days',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               '$hours hours',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             Text(
//               '$minutes minutes',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "remaining",
//               style: TextStyle(
//                 fontSize: 12,
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         );
//       }
//
//   }
//
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
// @freezed
// class Timings with _$Timings {
//   const factory Timings({
//     required DateTime currentTime,
//     required DateTime periodDate,
//   }) = _Timings;
//
//   factory Timings.fromJson(Map<String, Object?> json)
//   => _$TimingsFromJson(json);
// }
// class Counter extends StateNotifier<int> {
//   Counter(): super(0);
//
//   void increment() => state++;
//   void decrement() => state--;
// }
//
// class TodosNotifier extends StateNotifier<Timings> {
//   // We initialize the list of todos to an empty list
//   TodosNotifier(): super(Timings(currentTime: DateTime.now(), periodDate: DateTime.now().add(Duration(days: 4))));
//
//   // Let's allow the UI to add todos.
//   void addTodo(Todo todo) {
//     // Since our state is immutable, we are not allowed to do `state.add(todo)`.
//     // Instead, we should create a new list of todos which contains the previous
//     // items and the new one.
//     // Using Dart's spread operator here is helpful!
//     state = [...state, todo];
//     // No need to call "notifyListeners" or anything similar. Calling "state ="
//     // will automatically rebuild the UI when necessary.
//   }
//
//   // Let's allow removing todos
//   void removeTodo(String todoId) {
//     // Again, our state is immutable. So we're making a new list instead of
//     // changing the existing list.
//     state = [
//       for (final todo in state)
//         if (todo.id != todoId) todo,
//     ];
//   }
//
//   // Let's mark a todo as completed
//   void toggle(String todoId) {
//     state = [
//       for (final todo in state)
//       // we're marking only the matching todo as completed
//         if (todo.id == todoId)
//         // Once more, since our state is immutable, we need to make a copy
//         // of the todo. We're using our `copyWith` method implemented before
//         // to help with that.
//           todo.copyWith(completed: !todo.completed)
//         else
//         // other todos are not modified
//           todo,
//     ];
//   }
// }
// // @freezed
// // class Person with _$Person {
// //   const factory Person({
// //     required String firstName,
// //     required String lastName,
// //     required int age,
// //   }) = _Person;
// //
// //   factory Person.fromJson(Map<String, Object?> json)
// //   => _$PersonFromJson(json);
// // }
// // class TodosNotifier extends StateNotifier<List<Todo>> {
// //   // We initialize the list of todos to an empty list
// //   TodosNotifier(): super([]);
// //
// //   // Let's allow the UI to add todos.
// //   void addTodo(Todo todo) {
// //     // Since our state is immutable, we are not allowed to do `state.add(todo)`.
// //     // Instead, we should create a new list of todos which contains the previous
// //     // items and the new one.
// //     // Using Dart's spread operator here is helpful!
// //     state = [...state, todo];
// //     // No need to call "notifyListeners" or anything similar. Calling "state ="
// //     // will automatically rebuild the UI when necessary.
// //   }
// //
// //   // Let's allow removing todos
// //   void removeTodo(String todoId) {
// //     // Again, our state is immutable. So we're making a new list instead of
// //     // changing the existing list.
// //     state = [
// //       for (final todo in state)
// //         if (todo.id != todoId) todo,
// //     ];
// //   }
// //
// //   // Let's mark a todo as completed
// //   void toggle(String todoId) {
// //     state = [
// //       for (final todo in state)
// //       // we're marking only the matching todo as completed
// //         if (todo.id == todoId)
// //         // Once more, since our state is immutable, we need to make a copy
// //         // of the todo. We're using our `copyWith` method implemented before
// //         // to help with that.
// //           todo.copyWith(completed: !todo.completed)
// //         else
// //         // other todos are not modified
// //           todo,
// //     ];
// //   }
// // }
// //
// // // Finally, we are using StateNotifierProvider to allow the UI to interact with
// // // our TodosNotifier class.
// // final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) {
// //   return TodosNotifier();
// // });



class CountdownTimer extends StateNotifier<Duration> {
  final int seconds;
  late Timer _timer;

  CountdownTimer(this.seconds) : super(Duration(seconds: seconds));

  void start() {
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      state = state - Duration(seconds: 4);
      if (state.inSeconds <= 0) {
        _timer.cancel();
      }
    });
  }

  void stop() {
    _timer.cancel();
  }
}

final countdownTimerProvider = StateNotifierProvider.autoDispose<CountdownTimer, Duration>(
        (ref) => CountdownTimer(60)..start()
);

class CountdownTimerWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final duration = ref.watch(countdownTimerProvider);

    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Text('$minutes:$seconds');
  }
}
