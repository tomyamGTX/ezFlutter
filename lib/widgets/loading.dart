import 'package:ez_flutter/providers/auth.provider.dart';
import 'package:ez_flutter/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../style/text/text.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.twistingDots(
              leftDotColor: const Color(0xFF1A1A3F),
              rightDotColor: const Color(0xFFEA3799),
              size: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Logging in ...',
                style: basicTextStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Loading2 extends StatefulWidget {
  const Loading2({Key? key}) : super(key: key);

  @override
  State<Loading2> createState() => _Loading2State();
}

class _Loading2State extends State<Loading2> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      await AppUser.instance.signOut();
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Login()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingAnimationWidget.twistingDots(
              leftDotColor: const Color(0xFF1A1A3F),
              rightDotColor: const Color(0xFFEA3799),
              size: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Log out ...',
                style: basicTextStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
