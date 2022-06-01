import 'package:ez_flutter/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DB extends ChangeNotifier {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance
      .collection('users')
      .doc(AppUser().user!.uid)
      .collection('bill');

  Future<void> addBill(code, name, price, expired) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'billCode': code, // John Doe
          'billName': name, // Stokes and Sons
          'billPrice': price, // 42
          'expired': expired,
          'paid': false
        })
        .then((value) => print("Bill Added"))
        .catchError((error) => print("Failed to add bill: $error"));
  }
}
