import 'package:ez_flutter/screen/register.dart';
import 'package:ez_flutter/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../style/button/button1.dart';

import '../providers/auth.provider.dart';
import '../style/text/text.dart';
import '../widgets/form.dart';
import '../widgets/pass.ui.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              hint: 'Email', isPhone: false,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  PassUI(pass: _pass),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        style: buttonStyle(),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await Provider.of<AppUser>(context, listen: false)
                                  .signIn(
                                      email: _email.text, password: _pass.text);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Loading()));
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Error. Try again')),
                              );
                            }
                          }
                        },
                        child: const Text('Sign In')),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('OR'),
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
