import 'dart:async';




import '../models/mode_and_color.dart';
import '../util/prefs.dart';

class DarkLightControl {
  DarkLightControl(this.prefs);

   final StreamController<ModeAndColor> _streamController =
      StreamController.broadcast();

   Stream<ModeAndColor> get darkLightStream => _streamController.stream;
  final Prefs prefs;

  setDarkMode( int colorIndex) async {
    prefs.saveColorIndex(colorIndex);
    var mc = ModeAndColor(mode: mDARKMode, colorIndex: colorIndex);
    _streamController.sink.add(mc);
    prefs.saveModeAndColor(mc);
  }

  setLightMode( int colorIndex) async {
    prefs.saveColorIndex(colorIndex);
    var mc = ModeAndColor(mode: mLIGHTMode, colorIndex: colorIndex);
    _streamController.sink.add(mc);
    prefs.saveModeAndColor(mc);
  }
}




const mDARKMode = 0;
const mLIGHTMode = 1;
