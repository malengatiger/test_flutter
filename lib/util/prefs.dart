import 'dart:convert';

import 'package:busha_app/misc/dark_light_control.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/mode_and_color.dart';
import '../models/user.dart';
import 'functions.dart';

class Prefs {
  final SharedPreferences sharedPreferences;
  static const mm = '💜 Prefs 💜 💜';

  Prefs(this.sharedPreferences);

  Future saveUser(User user) async {
    pp('$mm ... User to be cached: ${user.toJson()}');

    Map mJson = user.toJson();
    var jx = json.encode(mJson);
    sharedPreferences.setString('user', jx);
    pp('$mm ... User saved OK');
  }

  User? getUser() {
    var string = sharedPreferences.getString('user');
    if (string == null) {
      return null;
    }
    var jx = json.decode(string);
    var user = User.fromJson(jx);
    pp('$mm ... User found OK: ${user.name}');
    return user;
  }

  void saveModeAndColor(ModeAndColor mode) {
    var json = jsonEncode(mode);
    sharedPreferences.setString('modeAndColor', json);
    pp('$mm ModeAndColor cached, json string: $json');

  }

  ModeAndColor getModeAndColor() {
    var modeJson = sharedPreferences.getString('modeAndColor');
    if (modeJson == null) {
      pp('$mm ... mode not found, returning 1 = mLIGHTMode');
      return  ModeAndColor(colorIndex: 0, mode: mDARKMode);
    }
    var ma = ModeAndColor.fromJson(jsonDecode(modeJson));
    pp('$mm ModeAndColor retrieved: ${ma.toJson()}');
    return ma;
  }

  void saveColorIndex(int index) async {
    sharedPreferences.setInt('color', index);
    return null;
  }

  int getColorIndex() {
    var color = sharedPreferences.getInt('color');
    if (color == null) {
      return 0;
    }
    return color;
  }
}