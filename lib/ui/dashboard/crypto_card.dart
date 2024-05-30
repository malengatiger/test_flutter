import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CryptoCard extends StatelessWidget {
  const CryptoCard(
      {super.key,
      required this.name,
      required this.ticker,
      required this.imagePath,
      required this.upArrow,
      required this.amount,
      required this.percentage});

  final String name, ticker, imagePath;
  final bool upArrow;
  final int amount;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    var nf = NumberFormat('##,###,###,###');
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            SizedBox(height: 96,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    imagePath,
                    height: 56,
                    width: 56,
                  ),
                ]
              ),
            ),
            gapW16,
            SizedBox(
              height: 96,
              width: 240,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  gapH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: myTextStyleMediumBold(context),
                      ),
                      Text(nf.format(amount), style: myTextStyleLarge(context),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ticker,
                        style: myTextStyleMediumGrey(context),
                      ),
                      SuffixWidget(
                        upArrow: upArrow,
                        percentage: percentage, fontSize: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SuffixWidget extends StatelessWidget {
  const SuffixWidget(
      {super.key, required this.upArrow, required this.percentage, required this.fontSize});

  final bool upArrow;
  final double percentage, fontSize;

  @override
  Widget build(BuildContext context) {
    var br = MediaQuery.of(context).platformBrightness;
    Color containerColor = Colors.transparent;
    Color arrowBackgroundColor = Colors.transparent;
    if (br == Brightness.dark) {
      containerColor = Colors.transparent;
      if (upArrow) {
        arrowBackgroundColor = Colors.green.shade800;
      } else {
        arrowBackgroundColor = Colors.red.shade800;

      }
    } else {
      containerColor = Colors.green.shade50;
      if (upArrow) {
        arrowBackgroundColor = Colors.green.shade800;
      } else {
        arrowBackgroundColor = Colors.red.shade800;

      }
    }
    var st = GoogleFonts.lato(
      textStyle: Theme.of(context).textTheme.headlineMedium,
      fontWeight: FontWeight.w900,
      fontSize: fontSize ?? 18.0,
      color: arrowBackgroundColor,
    );
    return Container(
      width: 120,
      color: containerColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              upArrow ? Icons.arrow_upward : Icons.arrow_downward,
              color: arrowBackgroundColor,
            ),
            Text(
              '$percentage %',
              style: st,
            ),
          ],
        ),
      ),
    );
  }
}
