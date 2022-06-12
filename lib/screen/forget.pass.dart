import 'package:ez_flutter/style/text/text.dart';
import 'package:ez_flutter/widgets/form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  var errorMessage = '';
  final _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        appBar: AppBar(
          title: const Text('Reset Password'),
          centerTitle: true,
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Enter your current email',
                style: titleTextStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FormUi(controller: _email, hint: 'Email', canEmpty: false),
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(email: _email.text)
                      .whenComplete(
                          () => ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Password reset link had send to your email')),
                              ))
                      .onError((error, stackTrace) => setState(() {
                            errorMessage = error.toString().split(']')[1];
                          }));
                },
                child: const Text('Reset Password')),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                errorMessage,
                style: const TextStyle(color: Colors.redAccent),
              ),
            )
          ],
        )));
  }
}
