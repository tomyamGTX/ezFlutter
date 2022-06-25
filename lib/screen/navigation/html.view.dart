import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HtmlView extends StatefulWidget {
  var content;
  final String title;
  final String url;

  HtmlView(
      {required this.content, required this.url, Key? key, required this.title})
      : super(key: key);

  @override
  State<HtmlView> createState() => _HtmlViewState();
}

class _HtmlViewState extends State<HtmlView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Flexible(
              child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: widget.url,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(16),
              child: HtmlWidget(
                widget.content,
                webViewJs: true,
                webView: true,
                webViewMediaPlaybackAlwaysAllow: false,
                onTapUrl: (url) {
                  return launchUrl(Uri.parse(url));
                },
                // factoryBuilder: () => InstagramWidgetFactory(),
              ),
            ),
          ],
        ));
  }
}
