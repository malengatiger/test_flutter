import 'package:busha_app/util/gaps.dart';
import 'package:busha_app/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CryptoCard extends StatefulWidget {
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
  State<CryptoCard> createState() => _CryptoCardState();
}

class _CryptoCardState extends State<CryptoCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation animation;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000),
        reverseDuration: const Duration(milliseconds: 500),
        vsync: this);

    animation = Tween<double>(begin: 0, end: 48).animate(_controller)
      ..addListener(() {
        if (mounted) {
          setState(() {});
        }
      });
    super.initState();
    _startAnimation();
  }

  Future<void> _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var nf = NumberFormat('##,###,###,###');
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            SizedBox(
              height: animation.value,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      widget.imagePath,
                      height: animation.value,
                      width: animation.value,
                    ),
                  ]),
            ),
            gapW16,
            SizedBox(
              height: 96,
              width: 240,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  gapH16,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.name,
                        style: myTextStyleMediumBold(context),
                      ),
                      Text(
                        nf.format(widget.amount),
                        style: myTextStyleLarge(context),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.ticker,
                        style: myTextStyleMediumGrey(context),
                      ),
                      SuffixWidget(
                        upArrow: widget.upArrow,
                        percentage: widget.percentage,
                        fontSize: 16, width: 100,
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
      {super.key,
      required this.upArrow,
      required this.percentage,
      required this.fontSize, required this.width});

  final bool upArrow;
  final double percentage, fontSize, width;

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
      width: width,
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
