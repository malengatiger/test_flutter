import 'package:busha_app/util/gaps.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleViewer extends StatefulWidget {
  const ArticleViewer({super.key, required this.url});

  @override
  ArticleViewerState createState() => ArticleViewerState();
  final String url;
}

class ArticleViewerState extends State<ArticleViewer> {

  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    _setWebView();

  }

  void _setWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Viewer'),
        actions: const [
          CircleAvatar(
            radius: 18.0,
            backgroundImage: AssetImage('assets/busha_logo.jpeg'),
          ),
          gapW16,
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: controller),
          ],
        ),
      ),
    );
  }
}
