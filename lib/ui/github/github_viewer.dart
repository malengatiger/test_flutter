import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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


  bool _showFrontEndRepo = true;
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    _setWebView();

  }

  void _setWebView() {
    String url = '';
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
      ..loadRequest(Uri.parse(url));

  }
  @override
  Widget build(BuildContext context) {
    var url = _showFrontEndRepo? frontEndUrl: backEndUrl;
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub Viewer'),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              _showFrontEndRepo = !_showFrontEndRepo;
            });
          }, icon:  Icon(_showFrontEndRepo? Icons.flip_to_front: Icons.back_hand)),
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
