import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import '../screen/navigation/navigation.dart';

class AppUser extends ChangeNotifier {
  String? name;
  Random random = Random();
  var box = GetStorage();

  AppUser._() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      notifyListeners();
    });
  }

  User? get user => FirebaseAuth.instance.currentUser;

  factory AppUser() => AppUser._();
  String role = 'None';

  static AppUser get instance => AppUser();

  signOut() async {
    GetStorage().remove('lat');
    GetStorage().remove('long');
    GetStorage().remove('acc');
    GetStorage().remove('sync');
    GetStorage().remove('id');
    await FirebaseAuth.instance.signOut();
    name = null;
    role = '';
    notifyListeners();
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await registerOneSignal();
      print('Sign in Successful');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw ('Wrong password provided for that user.');
      } else {
        throw (e.toString());
      }
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await AppUser.instance.user!.updateDisplayName(name);
      await registerOneSignal();
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateName(String text) async {
    await AppUser.instance.user!.updateDisplayName(text);
    getName();
    notifyListeners();
  }

  Future<void> loginFB(context) async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: [
        'public_profile',
        'email',
      ],
    ); // by default we request the email and the public profile
// or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);

      try {
        await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential);
        await registerOneSignal();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Navigation(0)));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.message.toString())));
    }
  }

  void getName() {
    name = AppUser.instance.user!.displayName ?? 'No Data';
  }

  loginGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth.idToken,
      );
      try {
        await FirebaseAuth.instance.signInWithCredential(credential);
        await registerOneSignal();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Navigation(0)));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> registerOneSignal() async {
    var id = box.read('osID');
    if (id == null) {
      int randomNumber = random.nextInt(123456789);
      var externalUserId = randomNumber.toString();
      box.write('osID', externalUserId);
      OneSignal.shared.setExternalUserId(externalUserId);
      OneSignal().setEmail(email: AppUser().user!.email!);
      linkPhoneNumber();
      notifyListeners();
    }
  }

  void linkPhoneNumber() {
    if (AppUser.instance.user!.phoneNumber != null) {
      OneSignal.shared
          .setSMSNumber(smsNumber: AppUser.instance.user!.phoneNumber!);
    }
  }
}
