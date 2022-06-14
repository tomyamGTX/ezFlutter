import 'dart:async';

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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(scale),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor),
                              child: Center(
                                  child: Text(
                                '^_^',
                                style: titleTextStyle(),
                              )),
                            ),
                          ),
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
