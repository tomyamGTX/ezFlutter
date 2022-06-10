import 'package:flutter/material.dart';

class BottomUI extends StatefulWidget {
  const BottomUI({Key? key}) : super(key: key);

  @override
  State<BottomUI> createState() => _BottomUIState();
}

class _BottomUIState extends State<BottomUI> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.amber,
    );
  }
}
