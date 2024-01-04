import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget{
  final String url;
  const WebViewPage({super.key, required this.url});
  
  @override 
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(widget.url));
    return Scaffold(
      appBar: AppBar(
        
        title: Text("Navtern"),
        actions: <Widget>[
          IconButton(
            onPressed: () async {
              if (await controller.canGoBack()) {
                controller.goBack();
              }
            },
            icon: const Icon(Icons.arrow_back),
          ),
          IconButton(
            onPressed: () async {
              if (await controller.canGoForward()) {
                controller.goForward();
              }
            },
            icon: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body:WebViewWidget(
        controller: controller,
      )
    );
  }
}