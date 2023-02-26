import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:periodt/components/chart/chart.dart';
import 'package:periodt/components/widgets/circle_widget.dart';
import '../../../components/text/text_body.dart';
import '../../loginpage.dart';
import 'countdown.dart';

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
// class HomePage extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFFDAD8),
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
//           ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.favorite), label: Text("Like")),
//
//           Center(
//             child: Text("Welcome!"),
//           ),
//           Center(child: Text(ref.read(loginProvider).loginToken()!)),
//            Text("Hello", style: GoogleFonts.openSans(
//              fontWeight: FontWeight.w500
//            )),
//
//           ElevatedButton(onPressed: (){
//             Navigator.pushNamed(context, "/animated");
//           }, child: Text("Press me")),
//           CustomTextField("hello world", textStyle: GoogleFonts.lato(
//             color: Colors.white,
//             fontWeight: FontWeight.bold
//
//
//           ),),
//           InkWell(
//             onTap: (){
//               Navigator.pushNamed(context, "/example");
//             },
//               child: CircleWithText(radius: 50, text: "test"))
//         ],
//       ),
//     );
//   }
// }
//
//
// class HomePage extends ConsumerWidget {
//   final DateTime periodStartDate2 = DateTime(2023,2,24);
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       backgroundColor: const Color(0xffFFDAD8),
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
//           ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.favorite), label: Text("Like")),
//
//           Center(
//             child: Text("Welcome!"),
//           ),
//           Center(child: Text(ref.read(loginProvider).loginToken()!)),
//           Text("Hello", style: GoogleFonts.openSans(
//               fontWeight: FontWeight.w500
//           )),
//
//           ElevatedButton(onPressed: (){
//             Navigator.pushNamed(context, "/animated");
//           }, child: Text("Press me")),
//           CustomTextField("hello world", textStyle: GoogleFonts.lato(
//               color: Colors.white,
//               fontWeight: FontWeight.bold
//
//
//           ),),
//           Expanded(child: CountdownTimerWidget())
// ,
//           InkWell(
//               onTap: (){
//                 Navigator.pushNamed(context, "/example");
//               },
//               child: CircleWithText(radius: 50, text: "test")),
//         ],
//
//       ),
//     );
//   }
// }
//


class HomePage extends ConsumerWidget {
  final DateTime periodStartDate2 = DateTime(2023,2,24);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(MdiIcons.ribbon),
        backgroundColor: Color(0xffFFF8F8),
      ),
      // backgroundColor: const Color(0xffFFDAD8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(style: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 11
        )
            ,"periodt"),
        leading: IconButton(
          icon: Icon(Icons.local_florist,color: Color(0xffFFA7A7)),
          onPressed: (){},
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite, color: Color(0xffFFA7A7),),
            onPressed: () {
              ref.read(loginProvider).logout();
              Navigator.pushReplacementNamed(context, "/");
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //  Expanded(
            //    child: Card(
            //     color: Color(0xffFFF8F8),
            //     child:
            //     Column(
            //       children: [
            //         Container(child:
            //           Text("${screenWidth} and ${screenHeight}"),)
            //       ],
            //     ),
            // ),
            //  ),
            // ElevatedButton.icon(onPressed: (){}, icon: Icon(Icons.favorite), label: Text("Like")),
//  Card(
//   color: Color(0xffFFF8F8),
//   child: SizedBox(
//     // iphone is 844x390
//     height: screenHeight*0.06635071,
//     width: screenWidth*0.84102664,
//     // child: Row(
//     //   crossAxisAlignment: CrossAxisAlignment.start,
//     //   mainAxisAlignment: MainAxisAlignment.values[
//     //
//     //   ],
//     //   children: [
//     //
//     //   ],
//     // ),
//   ),
// ),
            SearchBar(),
            NewCard(height: 0.342417061611374, width: 0.856410256410256,



              child: Column(

                children: [
                  SizedBox(height: 10,),
                  Text("Mensus Prediction", style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Color(0xffCE9F9F),
                      fontSize: 20
                  ),),
                  Expanded(child: SizedBox(
                      width: 213,height: 213,
                      child: ChartScreen())),
                ],
              ),),
            // Center(
            //   child: Text("Welcome!"),
            // ),
            // Center(child: Text(ref.read(loginProvider).loginToken()!)),
            // Text("Hello", style: GoogleFonts.openSans(
            //     fontWeight: FontWeight.w500
            // )),
            //
            // ElevatedButton(onPressed: (){
            //   Navigator.pushNamed(context, "/animated");
            // }, child: Text("Press me")),
            // CustomTextField("hello world", textStyle: GoogleFonts.lato(
            //     color: Colors.white,
            //     fontWeight: FontWeight.bold
            //
            //
            // ),),
            // Expanded(child: CountdownTimerWidget())
            // ,
            // InkWell(
            //     onTap: (){
            //       Navigator.pushNamed(context, "/example");
            //     },
            //     child: CircleWithText(radius: 50, text: "test")),
          ],

        ),
      ),
    );
  }
}



// class SearchBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     return Card(
//       color: Color(0xffFFF8F8),
//       child: SizedBox(
//         height: screenHeight * 0.06635071,
//         width: screenWidth * 0.84102664,
//         child: Padding(
//           padding: EdgeInsets.all(8),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.baseline,
//             textBaseline: TextBaseline.alphabetic,
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: IconButton(
//                   icon: Icon(Icons.hourglass_bottom, color: Color(0xffAE7474) ,),
//                   onPressed: () {},
//                 ),
//               ),
//               Expanded(
//                 child: TextField(
//                   decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Search',
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color: Color(0xffFFF8F8),
      child: SizedBox(
        height: screenHeight * 0.06635071,
        width: screenWidth * 0.856410256410256,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                // padding: EdgeInsets.all(2),
                width: screenHeight * 0.05,
                height: screenHeight * 0.05,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(MdiIcons.ribbon, color: Color(0xffCE9F9F)),
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Color(0xffCE9F9F))
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class NewCard extends StatelessWidget{
  // add two parameters
  final double height;
  final double width;
// add a parameter for the child widget
  final Widget child;
  // add two parameters to the constructor
  NewCard({required this.height, required this.width, required this.child});
  @override
  Widget build(BuildContext context){
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color:Color(0xffFFF8F8) ,
      child: SizedBox(
        height: screenHeight*height,
        width: screenWidth*width,
        child: child,
      ),
    );

  }
}