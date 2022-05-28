import 'package:flutter/material.dart';

import '../widgets/timeline.widget.dart';

class Timeline extends StatefulWidget {
  const Timeline({Key? key}) : super(key: key);

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  var color = [Colors.lightGreenAccent, Colors.blueAccent, Colors.redAccent];

  var url = [
    "https://qph.cf2.quoracdn.net/main-qimg-005e40dfa083a45068cb6c11a18805c8-lq",
    "https://upload.wikimedia.org/wikipedia/commons/2/2c/Rotating_earth_%28large%29.gif",
    "https://i.pinimg.com/originals/ef/62/15/ef62159fccabc474c22cdc6c73d36736.gif"
  ];

  var text = ['5 billion years ago', 'Today', 'Soon'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Planet Timeline'),
            centerTitle: true,
          ),
          body: Center(
            child: TimelineWidget(url: url, color: color, text: text),
          )),
    );
  }
}
