import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:periodt/components/widgets/circle_widget.dart';
import '../components/text/text_body.dart';
import 'loginpage.dart';

final loginProvider = ChangeNotifierProvider<LoginProvider>((ref) => LoginProvider());
// class HomePage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Home"),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.exit_to_app),
//             onPressed: () {
//               ref.read(loginProvider).logout();
//               Navigator.pushReplacementNamed(context, "/");
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           Center(
//             child: Text("Welcome!"),
//           ),
//           Text(ref.read(loginProvider).loginToken()!)
//         ],
//       ),
//     );
//   }
// }
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xffFFDAD8),
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
          ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.favorite), label: Text("Like")),

          Center(
            child: Text("Welcome!"),
          ),
          Center(child: Text(ref.read(loginProvider).loginToken()!)),
           Text("Hello", style: GoogleFonts.openSans(
             fontWeight: FontWeight.w500
           )),

          ElevatedButton(onPressed: (){
            Navigator.pushNamed(context, "/animated");
          }, child: Text("Press me")),
          CustomTextField("hello world", textStyle: GoogleFonts.lato(
            color: Colors.white,
            fontWeight: FontWeight.bold


          ),),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, "/example");
            },
              child: CircleWithText(radius: 50, text: "test"))
        ],
      ),
    );
  }
}

