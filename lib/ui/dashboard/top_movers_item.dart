import 'package:busha_app/ui/dashboard/top_movers_carousel.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../util/styles.dart';
import 'crypto_card.dart';

class TopMoverItem extends StatelessWidget {
  const TopMoverItem({
    super.key,
    required this.carouselData,
    required this.fontSize, required this.index,
  });

  final CarouselData carouselData;
  final double fontSize;
  final int index;

  @override
  Widget build(BuildContext context) {
    var st = GoogleFonts.lato(
      textStyle: Theme.of(context).textTheme.headlineMedium,
      fontWeight: FontWeight.w900,
      fontSize: fontSize ?? 18.0,
      color: carouselData.upArrow ? Colors.green.shade800 : Colors.red.shade800,
    );
    return Card(
      elevation: 8,
      child: SizedBox(
        height: 64,
        width: 160,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              gapH8,
              Text('$index', style: myTextStyle(context, Colors.grey.shade800, 16,
                  FontWeight.w900),),
              gapH16,
              SvgPicture.asset(
                carouselData.imagePath,
                height: 48,
                width: 48,
              ),
              gapH8,
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    carouselData.name,
                    style: myTextStyleMedium(context),
                  ),
                ],
              ),
              gapH8,
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SuffixWidget(
                    upArrow: carouselData.upArrow,
                    percentage: carouselData.percentage,
                    fontSize: fontSize,
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
