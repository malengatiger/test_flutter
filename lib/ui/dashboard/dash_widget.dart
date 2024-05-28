import 'package:busha_app/util/gaps.dart';
import 'package:flutter/material.dart';

class DashWidget extends StatefulWidget {
  const DashWidget({super.key});

  @override
  DashWidgetState createState() => DashWidgetState();
}

class DashWidgetState extends State<DashWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: const SafeArea(child: Stack(
        children: [
          Column(
            children: [
              gapH32,
              Text('TagLine here ..'),
            ],
          )
        ],
      )),
    );
  }
}
