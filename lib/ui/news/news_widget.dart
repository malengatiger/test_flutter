import 'dart:async';

import 'package:busha_app/misc/busy_indicator.dart';
import 'package:busha_app/models/news/news.dart';
import 'package:busha_app/services/news_service.dart';
import 'package:busha_app/util/news_refresh_listener.dart';
import 'package:busha_app/util/styles.dart';
import 'package:busha_app/util/toasts.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:badges/badges.dart' as bd;
import '../../util/functions.dart';
import '../../util/gaps.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({super.key, required this.onArticleRequested});

  final Function(String) onArticleRequested;

  @override
  NewsWidgetState createState() => NewsWidgetState();
}

class NewsWidgetState extends State<NewsWidget> {
  NewsService newsService = GetIt.instance<NewsService>();
  NewsRefreshListener newsRefreshListener =
      GetIt.instance<NewsRefreshListener>();

  late StreamSubscription<bool> newsSub;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _listen();
    _getNews();
  }

  void _listen() {
    newsSub = newsRefreshListener.refreshStream.listen((onData) {
      pp('... listener fired, should refresh the news: $onData');
      if (mounted) {
        _getNews();
      }
    });
  }

  @override
  void dispose() {
    newsSub.cancel();
    super.dispose();
  }

  News? news;

  void _getNews() async {
    setState(() {
      _busy = true;
    });
    try {
      news = await newsService.getNews('bitcoin, crypto');
    } catch (e, s) {
      pp('$e $s');
      if (mounted) {
        showErrorDialog(message: '$e', context: context);
      }
    }

    setState(() {
      _busy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      child: GestureDetector(
        onTap: (){
          pp('... newsRefreshListener.setRefresh ... ');
          newsRefreshListener.setRefresh();
        },
        child: bd.Badge(
          badgeContent: news == null
              ?const Text('0')
              : Text(
                  '${news!.results!.length}',
                  style: const TextStyle(color: Colors.white),
                ),
          badgeStyle: const bd.BadgeStyle(
              padding: EdgeInsets.all(12), badgeColor: Colors.blue),
          child: _busy
              ? const Center(
                  child: BusyIndicator(
                    caption: 'Refreshing the news ...',
                  ),
                )
              : ListView.builder(
                  itemCount: news == null ? 0 : news!.results!.length,
                  itemBuilder: (_, index) {
                    var result = news!.results!.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        if (result.link != null) {
                          widget.onArticleRequested(result.link!);
                        } else {
                          showToast(
                              message: 'This news item has no link',
                              context: context,
                              duration: const Duration(milliseconds: 2000));
                        }
                      },
                      child: Card(
                        child: NewsItem(
                          result: result,
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.result});

  final Results result;

  @override
  Widget build(BuildContext context) {
    pp(' 💜 imageUrl: ${result.imageUrl} \n 💜link: ${result.link} \n 💜 title:  ${result.title}');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: result.imageUrl == null ? 80 : 300,
        child: Column(
          children: [
            result.imageUrl == null
                ? gapH16
                : Image.network(
                    '${result.imageUrl}',
                    height: 200,
                  ),
            result.title == null
                ? gapH16
                : Flexible(
                    child: Text(
                    '${result.title}',
                    style: myTextStyleSmallBold(context),
                  )),
          ],
        ),
      ),
    );
  }
}
