import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocalProvider extends ChangeNotifier {
  var box = GetStorage();
  List debtList = [];
  List taskList = [];

  LocalProvider() {
    getList();
  }

  void getList() {
    try {
      var jsonString = box.read('localDebt');
      var jsonStringTask = box.read('localTask');
      if (jsonString != null) {
        var localJson = json.decode(jsonString);
        debtList = localJson;
      } else if (jsonStringTask != null) {
        var localJsonTask = json.decode(jsonStringTask);
        taskList = localJsonTask;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void addDebtList(val) {
    debtList.add(val);
    saveDebtList();
    notifyListeners();
  }

  void addTaskList(val) {
    taskList.add(val);
    taskList.sort((a, b) =>
        DateTime.parse(a['date']).compareTo(DateTime.parse(b['date'])));
    saveTaskList();
    notifyListeners();
  }

  void saveDebtList() {
    box.write('localDebt', json.encode(debtList));
    notifyListeners();
  }

  void saveTaskList() {
    box.write('localTask', json.encode(taskList));
    notifyListeners();
  }

  void deleteList(Object val) {
    debtList.remove(val);
    saveDebtList();
    notifyListeners();
  }

  void deleteTaskList(Object val) {
    taskList.remove(val);
    saveTaskList();
    notifyListeners();
  }

  void updateDebtList(index, priceIndex, price, paid, note) {
    var oldData;
    String notes = note;
    double prices = price;
    bool paids = !paid;
    oldData = debtList[index]['amount'];
    oldData.replaceRange(priceIndex, priceIndex + 1, [
      {"note": notes, "price": prices, "paid": paids}
    ]);
    notifyListeners();
    saveDebtList();
  }

  void updateTaskList(index, name, desc, date) {
    var oldData;
    oldData = taskList[index];
    oldData.replaceRange(index, index + 1, [
      {"name": name, "date": date, "desc": desc}
    ]);
    notifyListeners();
    saveTaskList();
  }

  void updateValue(
    index,
    priceIndex,
    double price,
    String text2,
    bool isPaid,
  ) {
    var amount;
    double prices = price;
    String texts = text2;
    bool isPaids = isPaid;
    amount = debtList[index]['amount'];
    amount.replaceRange(priceIndex, priceIndex + 1, [
      {"price": prices, "paid": isPaids, "note": texts}
    ]);
    saveDebtList();
    notifyListeners();
  }

  void addValue(double price, String text2, int index) {
    for (int i = 0; i < debtList.length; i++) {
      if (i == index) {
        List amount = debtList[i]['amount'];
        amount.add({"price": price, "paid": false, "note": text2});
      }
    }
    saveDebtList();
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
