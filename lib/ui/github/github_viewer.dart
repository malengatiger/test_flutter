import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GithubViewer extends StatefulWidget {
  const GithubViewer({super.key});

  @override
  GithubViewerState createState() => GithubViewerState();
}

class GithubViewerState extends State<GithubViewer> {

  static const frontEndUrl = '';
  static const backEndUrl = '';

  bool _showFrontEndRepo = true;
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
      ..loadRequest(Uri.parse(_showFrontEndRepo? frontEndUrl: backEndUrl));

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
