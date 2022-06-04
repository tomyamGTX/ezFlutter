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

  void updateList(val, index) {
    var newData = {
      'name': val['name'],
      'note': val['note'],
      'price': val['price'],
      'paid': !val['paid']
    };
    debtList.replaceRange(index, index + 1, [newData]);
    notifyListeners();
    saveList();
  }
}
