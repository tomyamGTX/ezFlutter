import 'package:ez_flutter/screen/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.provider.dart';
import 'login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<AppUser>(context,listen: false).user;
    if (user != null) {
      return const Navigation(1);
    }
    return const Login();
  }
}
