import 'package:busha_app/misc/busy_indicator.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../util/functions.dart';
import '../../util/gaps.dart';

class GithubViewer extends StatefulWidget {
  const GithubViewer({super.key, required this.gitHubIndex});

  @override
  GithubViewerState createState() => GithubViewerState();
  final int gitHubIndex;
}

class GithubViewerState extends State<GithubViewer> {

  static const frontEndUrl = 'https://github.com/malengatiger/test_flutter';
  static const backEndUrl = 'https://github.com/malengatiger/test_backend';
  static const profileUrl = 'https://github.com/malengatiger';

  static const mm = 'GitHub Viewer';
  bool _busy = true;
  bool _showFrontEndRepo = true;
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    _setWebView();

  }

  void _setWebView() {
    String url = frontEndUrl;
    switch(widget.gitHubIndex) {
      case 0:
        url = frontEndUrl;
        break;
      case 1:
        url = backEndUrl;
        break;
      case 2:
        url = profileUrl;
        break;
    }
    pp('... loading $url ... ');
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {
            pp('page onPageStarted: $url');
          },
          onPageFinished: (String url) {
            pp('page onPageFinished: $url');
            setState(() {
              _busy = false;
            });
          },
          onHttpError: (HttpResponseError error) {
            pp('page HttpResponseError: ${error.response?.statusCode}');
          },
          onWebResourceError: (WebResourceError error) {
            pp('page onWebResourceError: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            pp('page onNavigationRequest');
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )

      ..loadRequest(Uri.parse(url));

  }
  @override
  Widget build(BuildContext context) {
    var url = _showFrontEndRepo? frontEndUrl: backEndUrl;
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Viewer'),
        actions: [
          _busy? const SizedBox(height: 14, width: 14, child: CircularProgressIndicator(
            strokeWidth: 4, backgroundColor: Colors.pink,
          ),): gapW8,
          gapW16,
          const CircleAvatar(
            radius: 18.0,
            backgroundImage: AssetImage('assets/busha_logo.jpeg'),
          ),
          gapW8,
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
