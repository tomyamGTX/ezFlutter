import 'dart:async';
import 'dart:io';

import 'package:ez_flutter/style/text/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../providers/payment.provider.dart';

class WebViewExample extends StatefulWidget {
  final String billcode;
  final bool status;

  const WebViewExample(this.billcode, this.status, {Key? key})
      : super(key: key);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  late var timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!widget.status) {
        Provider.of<PaymentProvider>(context, listen: false)
            .getBillTransactions(context, widget.billcode);
      }
    });

    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.status ? 'WebView Receipt' : 'WebView Payment'),
        centerTitle: true,
        actions: [
          if (widget.status)
            IconButton(onPressed: () {}, icon: const Icon(Icons.download))
        ],
      ),
      body: Consumer<PaymentProvider>(builder: (context, bill, child) {
        return bill.paid
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Payment success',
                    style: titleTextStyle(),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.greenAccent,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 80,
                      ),
                    ),
                  )
                ],
              ))
            : WebView(
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: 'https://dev.toyyibpay.com/${widget.billcode}',
              );
      }),
    );
  }
}
