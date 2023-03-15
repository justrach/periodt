
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore_for_file: *

final periodDaysProvider = StateProvider<int>((ref) => 5);
final ovulationDaysProvider = StateProvider<int>((ref) => 3);
final normalDaysProvider = StateProvider<int>((ref) => 16);

class ChartScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final periodDays = ref.watch(periodDaysProvider);
    final ovulationDays = ref.watch(ovulationDaysProvider);
    final normalDays = ref.watch(normalDaysProvider);

    final totalDays = periodDays + ovulationDays + normalDays;
    final periodPercentage = (periodDays / totalDays) * 100;
    final ovulationPercentage = (ovulationDays / totalDays) * 100;
    final normalPercentage = (normalDays / totalDays) * 100;

    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: 'Crimson tides setting in\n',
                    style: GoogleFonts.poppins(
                      fontSize: 9,
                      color: const Color(0xffe59595),
                      fontWeight: FontWeight.normal,
                    )),
                TextSpan(
                    text: '7 days',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xffe59595),
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  radius: 25,
                  value: periodPercentage,
                  color: const Color(0xffabccff),
                  title: '${periodPercentage.toStringAsFixed(1)}%',
                ),
                PieChartSectionData(
                  radius: 25,
                  value: ovulationPercentage,
                  color: const Color(0xffFFDEAB),
                  title: '${ovulationPercentage.toStringAsFixed(1)}%',
                ),
                PieChartSectionData(
                  radius: 25,
                  value: normalPercentage,
                  color: const Color(0xffFFB5AB),
                  title: '${normalPercentage.toStringAsFixed(1)}%',
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
