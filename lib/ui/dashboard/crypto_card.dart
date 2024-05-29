import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
            SizedBox(height: 108,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    imagePath,
                    height: 48,
                    width: 48,
                  ),
                ]
              ),
            ),
            gapW16,
            SizedBox(
              height: 108,
              width: 240,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                        percentage: percentage,
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
      {super.key, required this.upArrow, required this.percentage});

  final bool upArrow;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      color: upArrow ? Colors.teal.shade50: Colors.red.shade50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              upArrow ? Icons.arrow_upward : Icons.arrow_downward,
              color: upArrow ? Colors.green.shade800 : Colors.red.shade800,
            ),
            Text(
              '$percentage %',
              style: myTextStyleMediumBoldWithColor(
                  context: context,
                  color: upArrow ? Colors.green.shade800 : Colors.red.shade800),
            ),
          ],
        ),
      ),
    );
  }
}
