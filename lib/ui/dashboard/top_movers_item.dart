import 'package:busha_app/ui/dashboard/top_movers_carousel.dart';
import 'package:busha_app/util/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../util/styles.dart';
import 'crypto_card.dart';

class TopMoverItem extends StatelessWidget {
  const TopMoverItem(
      {super.key, required this.carouselData,});

  final CarouselData carouselData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: SizedBox(
        height: 200, width: 200,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                carouselData.imagePath,
                height: 64,
                width: 64,
              ),
              gapH32,
              Text(
                carouselData.name,
                style: myTextStyleLarge(context),
              ),
              gapH16,
              SuffixWidget(upArrow: carouselData.upArrow, percentage: carouselData.percentage),
            ]),
      ),
    );
  }
}
