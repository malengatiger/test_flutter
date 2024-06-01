import 'package:busha_app/util/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedBushaLogo extends StatefulWidget {
  const AnimatedBushaLogo({super.key, required this.onTapped});

  final Function onTapped;

  @override
  AnimatedBushaLogoState createState() => AnimatedBushaLogoState();
}

class AnimatedBushaLogoState extends State<AnimatedBushaLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation animation;

  @override
  void initState() {
    _controller = AnimationController(
        // animate 0 to 1 over duration specified
        duration: const Duration(milliseconds: 1000),
        vsync: this);

    animation = Tween<double>(begin: 16, end: 36).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.addListener(() {
      // pp('listener started');
    });
    _controller.addStatusListener((listener) {
      pp('status listener: ${listener.name}');
    });
    _controller.repeat(min: 0.5);

    super.initState();

  }

  double size = 0.0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _setUp() {

    // if (mounted) {
    //   setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: animation.value + 12.0,
      width: animation.value + 12.0,
      child: GestureDetector(
        onTap: () {
          widget.onTapped();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.settings, size: animation.value, color: Theme.of(context).primaryColor,),
        ),
      ),
    );
  }
}
