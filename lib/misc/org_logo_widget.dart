import 'package:flutter/material.dart';

import '../util/gaps.dart';

class BushaLogoWidget extends StatelessWidget {
  const BushaLogoWidget({
    super.key,
    this.height,
    this.width,
  });

  final double? height, width;

  @override
  Widget build(BuildContext context) {

    String? name = 'Busha Demo';
    return SizedBox(
      height: height == null ? 28 : height!,
      // width: width == null? 400: width!,
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Image.asset(
             'assets/busha.svg',
              height: height == null ? 36 : height!,
              // width: height == null ? 64*4 : (height! * 4),
            ),
          ),
          gapW16,
          Flexible(
            child: Text(
              name,
            ),
          ),
        ],
      ),
    );
  }

}

