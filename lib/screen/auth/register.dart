import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../providers/auth.provider.dart';
import '../../style/button/button1.dart';
import '../../style/text/text.dart';
import '../../widgets/form.dart';
import '../../widgets/loading.dart';
import '../../widgets/pass.ui.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var _value = false;

  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).secondaryHeaderColor,
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Create New Account Today',
                        style: titleTextStyle(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.person),
                            Flexible(
                              child: FormUi(
                                controller: _name,
                                hint: 'Username',
                                canEmpty: false,
                              ),
                            ),
                          ],
                        ),
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
                    Row(
                      children: <Widget>[
                        Checkbox(
                          value: _value,
                          onChanged: (bool? value) {
                            setState(() {
                              _value = !_value;
                            });
                          },
                        ), //Text
                        Flexible(
                          child: InkWell(
                            onHover: (e) => setState(() {
                              _hover = !_hover;
                            }),
                            onTap: () => launchUrl(Uri.parse(
                                'https://www.freeprivacypolicy.com/live/32bcf9cd-be26-4282-b655-6021a2ed009d')),
                            child: AutoSizeText(
                              'I agree with EZFlutter\'s privacy policy and term condition ',
                              maxLines: 2,
                              style: TextStyle(
                                  color: _hover
                                      ? Theme.of(context).primaryColor
                                      : null),
                            ),
                          ),
                        ),
                      ], //<Widget>[]
                    ), //Row
                    ElevatedButton.icon(
                        style: buttonStyle(),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if (_value == false) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Please agree privacy policy and term condition')));
                            } else {
                              try {
                                await Provider.of<AppUser>(context,
                                        listen: false)
                                    .signUp(
                                  email: _email.text,
                                  password: _pass.text,
                                  name: _name.text,
                                );
                                // Provider.of<SandBoxPaymentProvider>(context,
                                //         listen: false)
                                //     .init();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Creating new account')),
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Loading()));
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(e.toString().split(']').last)),
                                );
                              }
                            }
                          }
                        },
                        icon: const Icon(Icons.app_registration),
                        label: const Text('Register')),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
