import 'package:ez_flutter/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DB extends ChangeNotifier {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance
      .collection('users')
      .doc(AppUser().user!.uid)
      .collection('bill');
  CollectionReference items = FirebaseFirestore.instance.collection('items');

  Future<void> addBill(code, name, price, expired) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(code)
        .set({
          'billCode': code, // John Doe
          'billName': name, // Stokes and Sons
          'billPrice': price, // 42
          'expired': expired,
          'paid': false
        })
        .then((value) => print("Bill Added"))
        .catchError((error) => print("Failed to add bill: $error"));
  }

  Future<void> addItem(name, desc, price, url) {
    // Call the user's CollectionReference to add a new user
    return items
        .add({
          'name': name, // Stokes and Sons
          'desc': desc, // 42
          'price': price,
          'pic-url': url
        })
        .then((value) => print("Bill Added"))
        .catchError((error) => print("Failed to add bill: $error"));
  }

  Future<void> updateBill(code, bool status) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(code)
        .set({'paid': status}, SetOptions(merge: true))
        .then((value) => print("Bill Added"))
        .catchError((error) => print("Failed to add bill: $error"));
  }
}
