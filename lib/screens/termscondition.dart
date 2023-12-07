import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class  TermsConditionsScreen extends StatefulWidget {
  const  TermsConditionsScreen({super.key});

  @override
  TermsConditionsScreenState createState() => TermsConditionsScreenState();
}

class TermsConditionsScreenState extends State< TermsConditionsScreen> {
  late WebViewController _controller;
  Color mycolor = const Color.fromARGB(255, 18, 54, 52);

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://www.freeprivacypolicy.com/live/25b8eaba-1d99-4ae8-abc9-3eda7904cd5c'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon( Icons.arrow_back_ios,color: Colors.white,)),
        title: const Text('Terms & condition',
        style: TextStyle(color: Colors.white),
      ),centerTitle: true,
      backgroundColor: mycolor,
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}