import 'dart:convert';

import 'package:busha_app/models/news/news.dart';
import 'package:busha_app/services/net.dart';
import 'package:busha_app/util/functions.dart';

import 'auth.dart';

class NewsService {
  static const mm = '🥬🥬🥬 NewsService 🥬';
  Future<News> getNews(String keyword) async {
    String mUrl = AuthService.localUrl;
    late News news;

    try {
      var resp = await Net.get('news/getNews?keyword=$keyword');
      if (resp.statusCode == 200) {
        pp('$mm... we doing good with News Corp, Jackson!');
        var json = jsonDecode(resp.body);
        news = News.fromJson(json);
      } else {
        var msg = 'Bad response from News Corp!';
        pp('ERROR: $msg - ${resp.body}');
        throw Exception(msg);
      }
      pp('$mm news received: ${news.results?.length} results');
    } catch (e, s) {
      pp('$e $s');
      throw Exception('No news for you, Joe! - $e');
    }
    return news;
  }
}
