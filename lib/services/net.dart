import 'package:busha_app/util/functions.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:welltested_annotation/welltested_annotation.dart';
/// Utility class to handle GET and POST http network requests
@Welltested()
class Net {
  static const _ipFibreDown = '192.168.86.242';
  static const _ipNormal = '192.168.86.230';
  static const bool isFibreOK = true;
  static const _devSkunkUrl =
      'http://${isFibreOK ? _ipNormal : _ipFibreDown}:8080/';
  static const _prodSkunkUrl = 'https://busha-nest-1-ajtawuiiiq-ew.a.run.app/';

  final http.Client client;

  Net(this.client);

  static String getBushaUrl() {
    if (kDebugMode) {
      return _devSkunkUrl; //TODO - change back to local after test
    } else {
      return _prodSkunkUrl;
    }
  }

   Future<http.Response> get(String path) async {
    String url = '${getBushaUrl()}$path';
    pp('$mm get: ... Calling $url');

    late http.Response resp;
    try {
      resp = await client.get(Uri.parse(url));
    } catch (e) {
      pp('ERROR: $e');
      throw Exception('Network Error: $e');
    }
    return resp;
  }

   Future<http.Response> post(
      {required String path,
      required Map<String, dynamic> data,
      required String token}) async {
    var mUrl = '${getBushaUrl()}$path';
    pp('$mm post: ... Calling $mUrl \ndata: $data');

    late http.Response resp;
    try {
      resp = await client.post(Uri.parse(mUrl), body: data);
    } catch (e) {
      pp('ERROR: $e');
      throw Exception('Network Error: $e');
    }
    return resp;
  }

   Future sayHello() async {
    String path = '';
    var resp = await get(path);
    pp('$mm sayHello response, status: ${resp.statusCode}  🍎 body: ${resp.body} 🍎');
  }

  static const mm = '🅿️🅿️🅿️🅿️ Net 🅿️🅿️🅿️';
}
