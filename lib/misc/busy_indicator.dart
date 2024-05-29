import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';

import '../util/gaps.dart';
import '../util/styles.dart';

class BusyIndicator extends StatefulWidget {
  final String? caption;
  final Color? color;
  final double? elevation;
  final bool? showElapsedTime;
  final bool? showClock;
  final bool? showTimerOnly;

  final double? textSize, width, height;

  const BusyIndicator(
      {super.key,
      this.caption,
      this.color = Colors.blue,
      this.elevation = 8.0,
      this.showClock = true,
      this.showElapsedTime = true,
      this.showTimerOnly = false,
      this.width = 300,
      this.textSize = 14, this.height});

  @override
  State<BusyIndicator> createState() => _BusyIndicatorState();
}

class _BusyIndicatorState extends State<BusyIndicator> {
  String elapsedTime = '';

  @override
  void initState() {
    super.initState();
    _runTimer();
  }

  late Timer timer;

  void _runTimer() {
    int milliseconds = 0;
    timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      milliseconds += 1000;
      int seconds = (milliseconds / 1000).truncate();
      int minutes = (seconds / 60).truncate();
      seconds %= 60;

      String minutesStr = minutes.toString().padLeft(2, '0');
      String secondsStr = seconds.toString().padLeft(2, '0');

      setState(() {
        elapsedTime = '$minutesStr:$secondsStr';
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = widget.height ?? 240.0;
    var width = widget.width ?? 300.0;

    var show = false;
    if (widget.showClock != null) {
      if (widget.showClock!) {
        height = widget.height == null? 440: widget.height! + 120;
        show = widget.showClock!;
      }
    }

    if (widget.showTimerOnly != null && widget.showTimerOnly!) {
      width = widget.width == null ? 100 : widget.width!;
      height = widget.height ?? 100;
      return SizedBox(
        height: height,
        width: width,
        child: Card(
          elevation: widget.elevation == null ? 8 : widget.elevation!,
          // color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(
              height: height,
              child: Column(
                children: [
                  gapH8,
                  const SizedBox(
                    height: 12,
                    width: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 4,
                      backgroundColor: Colors.deepOrange,
                    ),
                  ),
                  gapH8,
                  Flexible(
                    child: Text(
                      elapsedTime,
                      style: myTextStyle(
                        context,
                        Theme.of(context).primaryColor,
                        widget.textSize!,
                        FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      width: width,
      child: Card(
          elevation: widget.elevation,
          child: Center(
            child: SizedBox(
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    gapH16,
                    const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.pink,
                        strokeWidth: 4.0,
                      ),
                    ),
                    gapH16,
                    widget.caption == null
                        ? gapW8
                        : Text(widget.caption!,
                            style: myTextStyleSmall(context)),
                    gapH16,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Elapsed Time: '),
                        gapW16,
                        Text(
                          elapsedTime,
                          style: myTextStyle(
                            context,
                            Theme.of(context).primaryColor,
                            18,
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    gapH16,
                    show
                        ? Expanded(
                            child: SizedBox(
                              height: 100,
                              width: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: AnalogClock(
                                  secondHandColor: Colors.red,
                                  dateTime: DateTime.now(),
                                  dialBorderColor: Colors.green,
                                  isKeepTime: true,
                                  child: const Align(
                                    alignment: FractionalOffset(0.5, 0.75),
                                    child: Text(
                                      'GMT+2',
                                    ), //todo - use country db to set this
                                  ),
                                ),
                              ),
                            ),
                          )
                        : gapW8,
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
