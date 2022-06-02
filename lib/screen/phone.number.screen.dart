import 'dart:async';

import 'package:ez_flutter/screen/home.dart';
import 'package:ez_flutter/style/text/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../providers/auth.provider.dart';

class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  final _phone = TextEditingController();

  final _code = TextEditingController();

  String? verId;

  bool _visible = false;

  String? code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppUser.instance.user!.phoneNumber ?? 'Not link yet'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: _phone,
                decoration:
                    const InputDecoration(label: Text('Insert Phone Number')),
              ),
              Visibility(
                visible: _visible,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text('Insert Code Receive Here..',
                      style: titleTextStyle()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: Visibility(
                  visible: _visible,
                  child: PinCodeTextField(
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: false),
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.white,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    backgroundColor: Colors.blue.shade50,
                    enableActiveFill: true,
                    controller: _code,
                    onCompleted: (v) {
                      setState(() {});
                      code = v;
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    beforeTextPaste: (text) {
                      print("Allowing to paste $text");
                      //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                      //but you can show anything you want here, like your pop up saying wrong paste format or etc
                      return true;
                    },
                    appContext: (context),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () async {
                      if (!_visible) {
                        if (_phone.text.isNotEmpty) {
                          getOtp(_phone.text);
                          setState(() {});
                          _visible = !_visible;
                        }
                      } else if (verId != null && code != null) {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: verId!, smsCode: code!);
                        await AppUser.instance.user!
                            .updatePhoneNumber(credential);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()));
                      }
                    },
                    child: _visible
                        ? const Text('Submit')
                        : const Text('Get Code')),
              )
            ],
          ),
        ));
  }

  Future<void> getOtp(String text) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: text,
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
          // Handle other errors
        },
        codeSent: (String verificationId, int? resendToken) async {
          setState(() {});
          verId = verificationId;
          // Update the UI - wait for the user to enter the SMS code

          // Create a PhoneAuthCredential with the code
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(minutes: 2));
  }
}
