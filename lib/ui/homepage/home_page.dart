import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../components/chart/chart.dart';
import '../../components/datepicker/date_picker_2.dart';
import '../../components/datepicker/period_date_picker.dart';
import '../auth/login_page.dart';

final loginProvider =
    ChangeNotifierProvider<LoginProvider>((ref) => LoginProvider());

class HomePage extends ConsumerWidget {
  final DateTime periodStartDate2 = DateTime(2023, 2, 24);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          MdiIcons.ribbon,
          color: Color(0xff9C4141),
        ),
        backgroundColor: const Color(0xffFFF8F8),
      ),
      // backgroundColor: const Color(0xffFFDAD8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 11),
            'periodt'),
        leading: IconButton(
          icon: const Icon(Icons.local_florist, color: Color(0xffFFA7A7)),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Color(0xffFFA7A7),
            ),
            onPressed: () async {
             await ref.read(loginProvider).logout();
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DatePickerExample(),
              Center(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: HorizontalDatePicker(),
              )),
              SearchBar(),
              NewCard(
                height: 0.342417061611374,
                width: 0.856410256410256,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Mensus Prediction',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: const Color(0xffe59595),
                          fontSize: 20),
                    ),
                    Expanded(
                        child: SizedBox(
                            width: 213, height: 213, child: ChartScreen())),
                  ],
                ),
              ),
              NewCard(
                  height: 0.139810426540284,
                  width: 0.856410256410256,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.book,
                            size: 20,
                            color: Color(0xffe59595),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Goddess Gossip',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffE59595),
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.center,
                              'You are most fertile during the 5-6 day period leading up to and including ovulation.',
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: const Color(0xffe59595)),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              NewCard(
                  height: 0.139810426540284,
                  width: 0.856410256410256,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.book,
                            size: 20,
                            color: Color(0xffe59595),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Goddess Gossip',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffE59595),
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.center,
                              'You are most fertile during the 5-6 day period leading up to and including ovulation.',
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: const Color(0xffe59595)),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              NewCard(
                  height: 0.139810426540284,
                  width: 0.856410256410256,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.book,
                            size: 20,
                            color: Color(0xffe59595),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Goddess Gossip',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffE59595),
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.center,
                              'You are most fertile during the 5-6 day period leading up to and including ovulation.',
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: const Color(0xffe59595)),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
              NewCard(
                  height: 0.139810426540284,
                  width: 0.856410256410256,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.book,
                            size: 20,
                            color: Color(0xffe59595),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Goddess Gossip',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                color: const Color(0xffE59595),
                                fontSize: 20),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              textAlign: TextAlign.center,
                              'You are most fertile during the 5-6 day period leading up to and including ovulation.',
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: const Color(0xffe59595)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}


class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color: const Color(0xffFFF8F8),
      child: SizedBox(
        height: screenHeight * 0.06635071,
        width: screenWidth * 0.856410256410256,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Container(
                // padding: EdgeInsets.all(2),
                width: screenHeight * 0.05,
                height: screenHeight * 0.05,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(MdiIcons.ribbon, color: Color(0xffCE9F9F)),
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Color(0xffCE9F9F))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewCard extends StatelessWidget {
  // add two parameters
  final double height;
  final double width;
// add a parameter for the child widget
  final Widget child;
  // add two parameters to the constructor
  NewCard({required this.height, required this.width, required this.child});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color: const Color(0xffFFF8F8),
      child: SizedBox(
        height: screenHeight * height,
        width: screenWidth * width,
        child: child,
      ),
    );
  }
}
