import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'loginpage.dart';

final loginProvider = ChangeNotifierProvider<LoginProvider>((ref) => LoginProvider());

// class HomePage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final token = ref.watch(loginProvider).token;
//     print(token);
//     final decodedToken = JwtDecoder.decode(token!);
//     final email = decodedToken["email"];
//
//     return Scaffold(
//       appBar: AppBar(title: Text("Home")),
//       body: Center(
//         child: Scaffold(
//           body: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text("Logged in as $email"),
//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   ref.read(loginProvider).logout();
//                   Navigator.pushReplacementNamed(context, "/login");
//                 },
//                 child: Text("Log out"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              ref.read(loginProvider).logout();
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text("Welcome!"),
          ),
          Text(ref.read(loginProvider).loginToken()!)
        ],
      ),
    );
  }
}