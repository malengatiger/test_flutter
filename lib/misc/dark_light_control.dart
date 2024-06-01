import 'dart:async';




import '../models/mode_and_color.dart';

class ModeListener {
  ModeListener();

   final StreamController<ModeAndColor> _streamController =
      StreamController.broadcast();

   Stream<ModeAndColor> get darkLightStream => _streamController.stream;

  setMode( ModeAndColor mc) async {
    _streamController.sink.add(mc);
  }

}




const mDARKMode = 0;
const mLIGHTMode = 1;
