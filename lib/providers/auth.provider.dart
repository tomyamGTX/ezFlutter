import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

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

  void getName() {
    name = AppUser.instance.user!.displayName ?? 'No Data';
  }
}
