import 'package:flutter/material.dart';
import '../providers/auth.provider.dart';
import '../widgets/drawer.home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
          drawer: buildDrawer(context),
          appBar: AppBar(
            title: Text('Welcome ${AppUser.instance.user?.email}'),
          ),
          body: Center(
            child: Column(
              children: [],
            ),
          )),
    );
  }
}
