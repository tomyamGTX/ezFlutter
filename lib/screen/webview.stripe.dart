import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../style/text/text.dart';

class StripeWebView extends StatefulWidget {
  final String url;

  const StripeWebView({required this.url, Key? key}) : super(key: key);

  @override
  State<StripeWebView> createState() => _StripeWebViewState();
}

class _StripeWebViewState extends State<StripeWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Product'),
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
