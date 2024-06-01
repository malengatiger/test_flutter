import 'package:busha_app/util/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Net {
  static const _ipFibreDown = '192.168.86.242';
  static const _ipNormal = '192.168.86.230';
  static const bool isFibreOK = true;
  static const _devSkunkUrl =
      'http://${isFibreOK ? _ipNormal : _ipFibreDown}:8080/';
  static const _prodSkunkUrl = 'https://busha-nest-1-ajtawuiiiq-ew.a.run.app/';

  static String getBushaUrl() {
    if (kDebugMode) {
      return _prodSkunkUrl; //TODO - change back to local after test
    } else {
      return _prodSkunkUrl;
    }
  }

  static Future<http.Response> get(String path) async {
    String url = '${getBushaUrl()}$path';
    pp('$mm get: ... Calling $url');

    late http.Response resp;
    try {
      resp = await http.get(Uri.parse(url));
    } catch (e) {
      pp('ERROR: $e');
      throw Exception('Network Error: $e');
    }
    return resp;
  }

  static Future<http.Response> post(
      {required String path,
      required Map<String, dynamic> data,
      required String token}) async {
    pp('$mm post: ... Calling $path - data: $data');
    var mUrl = '${getBushaUrl()}$path';
    late http.Response resp;
    try {
      resp = await http.post(Uri.parse(mUrl), body: data);
    } catch (e) {
      pp('ERROR: $e');
      throw Exception('Network Error: $e');
    }
    return resp;
  }

  static Future sayHello() async {
    String path = '';
    var resp = await get(path);
    pp('$mm sayHello response, status: ${resp.statusCode}  🍎 body: ${resp.body} 🍎');
  }

  static const mm = '🅿️ Net';
}
