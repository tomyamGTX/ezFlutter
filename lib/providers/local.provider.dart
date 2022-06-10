import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocalProvider extends ChangeNotifier {
  var box = GetStorage();
  List debtList = [];

  LocalProvider() {
    getList();
  }

  void getList() {
    try {
      var jsonString = box.read('localDebt');
      var localJson = json.decode(jsonString);
      debtList = localJson;
    } catch (e) {
      box.remove('localDebt');
      print(e.toString());
    }
  }

  void addList(val) {
    debtList.add(val);
    saveList();
    notifyListeners();
  }

  void saveList() {
    box.write('localDebt', json.encode(debtList));
    notifyListeners();
  }

  void deleteList(Object val) {
    debtList.remove(val);
    saveList();
    notifyListeners();
  }

  void updateList(index, priceIndex, price, paid, note) {
    var oldData;
    String notes = note;
    double prices = price;
    bool paids = !paid;
    oldData = debtList[index]['amount'];
    oldData.replaceRange(priceIndex, priceIndex + 1, [
      {"note": notes, "price": prices, "paid": paids}
    ]);
    notifyListeners();
    saveList();
  }

  void updateValue(index, priceIndex,double price, String text2, bool isPaid,) {
    var amount;
    double prices = price;
    String texts = text2;
    bool isPaids = isPaid;
    amount = debtList[index]['amount'];
    amount.replaceRange(priceIndex, priceIndex + 1, [
      {"price": prices, "paid": isPaids, "note": texts}
    ]);
    saveList();
    notifyListeners();
  }

  void addValue(double price, String text2, int index) {
    for (int i = 0; i < debtList.length; i++) {
      if (i == index) {
        List amount = debtList[i]['amount'];
        amount.add({"price": price, "paid": false, "note": text2});
      }
    }
    saveList();
    notifyListeners();
  }

  void deletePrice(item) {
    debtList.forEach((element) {
      List amount = element['amount'];
      amount.remove(item);
      notifyListeners();
    });
  }
}
