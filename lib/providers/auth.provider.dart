import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get_storage/get_storage.dart';

import '../screen/navigation/navigation.dart';

class AppUser extends ChangeNotifier {
  String? name;

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
      await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Navigation(0)));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.message.toString())));
    }
  }

  void getName() {
    name = AppUser.instance.user!.displayName ?? 'No Data';
  }
}
