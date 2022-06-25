import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../style/text/text.dart';

class WebViewDisplay extends StatefulWidget {
  final String url;
  final String title;
  const WebViewDisplay({required this.url, required this.title, Key? key})
      : super(key: key);

  @override
  State<WebViewDisplay> createState() => _WebViewDisplayState();
}

class _WebViewDisplayState extends State<WebViewDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: widget.url == ''
          ? Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  size: 80,
                  color: Theme.of(context).primaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Url Not found',
                    style: basicTextStyle(),
                  ),
                ),
              ],
            ))
          : WebView(
              javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.url,
            ),
    );
  }
}
