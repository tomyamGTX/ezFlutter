import 'dart:async';

import 'package:animator/animator.dart';
import 'package:ez_flutter/screen/navigation/navigation.dart';
import 'package:ez_flutter/screen/register.dart';
import 'package:ez_flutter/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.provider.dart';
import '../style/button/button1.dart';
import '../style/text/text.dart';
import '../widgets/form.dart';
import '../widgets/pass.ui.dart';
import 'forget.pass.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool load = false;

  double scale = 0;
  late var time;

  @override
  void initState() {
    time = Timer.periodic(const Duration(milliseconds: 200), (timer) {
      setState(() {});
      scale = scale + 0.45;
    });
    super.initState();
  }

  @override
  dispose() {
    time.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? const Loading()
        : SafeArea(
            child: Scaffold(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              resizeToAvoidBottomInset: false,
              body: Center(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 120,
                          child: Animator<double>(
                              duration: const Duration(milliseconds: 1000),
                              cycles: 0,
                              curve: Curves.bounceIn,
                              tween: Tween<double>(begin: 30.0, end: 35.0),
                              builder: (context, animatorState, child) {
                                return CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: animatorState.value * 2.5,
                                  child: Image.asset(
                                    'asset/playstore-removebg-preview.png',
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Welcome to EZFlutter',
                            style: titleTextStyle(),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Icon(Icons.mail),
                                Flexible(
                                  child: FormUi(
                                    controller: _email,
                                    hint: 'Email',
                                    canEmpty: false,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        PassUI(pass: _pass),
                        Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextButton(
                                  onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgetPassword())),
                                  child: const Text('Forget Password')),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: buttonStyle(),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    setState(() {});
                                    load = !load;
                                    await Provider.of<AppUser>(context,
                                            listen: false)
                                        .signIn(
                                            email: _email.text.trim(),
                                            password: _pass.text);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Navigation(0)));
                                  } catch (e) {
                                    setState(() {});
                                    load = !load;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              e.toString().split(']').last)),
                                    );
                                  }
                                }
                              },
                              child: const Text('Sign In')),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Or'),
                        ),
                        LoginMethod(
                          ontap: () async {
                            await Provider.of<AppUser>(context, listen: false)
                                .loginFB(context);
                          },
                          logoWidget: const Icon(
                            Icons.facebook,
                            color: Colors.blueAccent,
                            size: 40,
                          ),
                          name: 'Facebook',
                        ),
                        LoginMethod(
                          ontap: () async {
                            await Provider.of<AppUser>(context, listen: false)
                                .loginGoogle(context);
                          },
                          logoWidget: Image.network(
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY7-ZlXeNpdFOxML6-kCHjMVnPaWS5CuRrIQ&usqp=CAU',
                              height: 35,
                              width: 35,
                              fit: BoxFit.contain),
                          name: 'Google',
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Register()));
                              },
                              child: const Text('Register Now')),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
  }
}

class LoginMethod extends StatelessWidget {
  final Function() ontap;
  final Widget logoWidget;
  final String name;

  const LoginMethod({
    required this.name,
    required this.ontap,
    required this.logoWidget,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 250,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Colors.white70),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [logoWidget, Text('Sign-in with $name')],
          ),
        ),
      ),
    );
  }
}
