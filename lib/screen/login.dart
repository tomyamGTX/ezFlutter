import 'dart:math';

import 'package:ez_flutter/screen/register.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.provider.dart';

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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    validator: (e) {
                      if (e!.isEmpty) {
                        return 'Please insert email';
                      }
                    },
                    controller: _email,
                    decoration: const InputDecoration(label: Text('Email')),
                  ),
                  TextFormField(
                    obscureText: true,
                    validator: (e) {
                      if (e!.isEmpty) {
                        return 'Please insert password';
                      }
                    },
                    controller: _pass,
                    decoration: const InputDecoration(label: Text('Password')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              await Provider.of<AppUser>(context, listen: false)
                                  .signIn(email: _email.text,
                                  password: _pass.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Logging in')),
                              );
                            }catch(e){
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Error. Try again')),
                              );
                            }
                          }
                        },
                        child: const Text('Login')),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Register()));
                        },
                        child: const Text('Register')),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
