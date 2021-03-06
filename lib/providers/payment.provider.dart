import 'dart:convert';

import 'package:ez_flutter/models/bill.transaction.model.dart';
import 'package:ez_flutter/models/create.category.response.model.dart';
import 'package:ez_flutter/providers/auth.provider.dart';
import 'package:ez_flutter/providers/db.provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/Bill.model.dart';

class PaymentProvider extends ChangeNotifier {
  bool paid = false;
  List<Bill> allBill = <Bill>[];
  var userSecretkey = 'nofhlhl3-jbei-qofy-syni-98ehe992zd8y';
  String? categoryCodeDonation = '2eg9wba8';
  String? categoryCode = 'ulfgapii';
  var createBillUrl =
      Uri.parse('https://toyyibpay.com/index.php/api/createBill');
  var getBillTransaction =
      Uri.parse('https://toyyibpay.com/index.php/api/getBillTransactions');

  Future<void> createBill(
    BuildContext context, {
    required String billName,
    required String billDesc,
    required double price,
    required int expired,
  }) async {
    var request = http.MultipartRequest('POST', createBillUrl);
    request.fields['userSecretKey'] = userSecretkey;
    request.fields['categoryCode'] = categoryCode!;
    request.fields['billName'] = billName;
    request.fields['billDescription'] = billDesc;
    request.fields['billPriceSetting'] = '0';
    request.fields['billPayorInfo'] = '1';
    request.fields['billAmount'] = '${price * 100}';
    request.fields['billReturnUrl'] = '';
    request.fields['billCallbackUrl'] = '';
    request.fields['billExternalReferenceNo'] = AppUser().user!.uid;
    request.fields['billTo'] = AppUser().user!.displayName!;
    request.fields['billEmail'] = AppUser().user!.email!;
    request.fields['billPhone'] = AppUser().user!.phoneNumber!;
    request.fields['billSplitPayment'] = '1';
    request.fields['billSplitPaymentArgs'] = '';
    request.fields['billPaymentChannel'] = '2';
    request.fields['billContentEmail'] =
        'Thank you for purchasing our product!';
    request.fields['billChargeToCustomer'] = '2';
    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      print(responseData);
      Provider.of<DB>(context, listen: false).addBill(
          responseData[0]['BillCode'],
          billName,
          price,
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + expired));
      notifyListeners();
    } else {
      print("ERROR");
    }
  }

  Future<void> getBillTransactions(
      BuildContext context, String billCode) async {
    var request = http.MultipartRequest('POST', getBillTransaction);

    request.fields['billCode'] = billCode;

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);
    if (response.statusCode == 200) {
      for (var item in responseData) {
        var data = BillTransaction.fromJson(item);
        if (data.billpaymentStatus == '1') {
          Provider.of<DB>(context, listen: false).updateBill(billCode, true);
          Provider.of<PaymentProvider>(context, listen: false).updateBool();
          print('Successful transaction');
        } else if (data.billpaymentStatus == '2') {
          print('Pending transaction');
        } else if (data.billpaymentStatus == '3') {
          Provider.of<DB>(context, listen: false).updateBill(billCode, false);
          print('Unsuccessful transaction');
        } else if (data.billpaymentStatus == '4') {
          print('Pending');
        }
      }
    } else {
      print("ERROR");
    }
  }

  void getCategory() {}

  void updateBool() {
    paid = !paid;
    notifyListeners();
  }

  void setBool(data) {
    if (data) {
      paid = false;
      notifyListeners();
    }
  }
}
