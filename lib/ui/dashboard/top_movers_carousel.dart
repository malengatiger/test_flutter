import 'package:busha_app/ui/dashboard/top_movers_item.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class TopMoversCarousel extends StatelessWidget {
  const TopMoversCarousel({super.key, required this.carouselData, required this.carouselController});

  final List<CarouselData> carouselData;
  final CarouselController carouselController;
  @override
  Widget build(BuildContext context) {
    var options = CarouselOptions();

    return SizedBox(
      height: 200,
      child: ListView.builder(
          itemCount: carouselData.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_,index){
        var cd = carouselData.elementAt(index);
        return TopMoverItem(carouselData: cd, fontSize: 20, index: index + 1,);
      }),
    );
  }
}

class CarouselData {
  final String imagePath, name;
  final bool upArrow;
  final double percentage;

  CarouselData(
      {required this.imagePath,
      required this.name,
      required this.upArrow,
      required this.percentage});
}
