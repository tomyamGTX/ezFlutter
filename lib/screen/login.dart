import 'package:ez_flutter/screen/navigation.dart';
import 'package:ez_flutter/screen/register.dart';
import 'package:ez_flutter/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../style/button/button1.dart';

import '../providers/auth.provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return load
        ? Loading()
        : Scaffold(
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Welcome to EzFlutter',
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
                                  isPhone: false,
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const Navigation(1)));
                                } catch (e) {
                                  setState(() {});
                                  load = !load;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(e
                                            .toString()
                                            .replaceAll(
                                                '[firebase_auth/invalid-email]',
                                                '')
                                            .replaceAll(
                                                '[firebase_auth/too-many-requests]',
                                                ''))),
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
                                      builder: (context) => const Register()));
                            },
                            child: const Text('Register Now')),
                      )
                    ],
                  ),
                ),
              ),
            ));
  }
}
