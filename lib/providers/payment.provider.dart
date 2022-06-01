import 'dart:convert';

import 'package:ez_flutter/models/create.category.response.model.dart';
import 'package:ez_flutter/providers/auth.provider.dart';
import 'package:ez_flutter/providers/db.provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/Bill.model.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentProvider() {
    init();
  }

  List<Bill> allBill = <Bill>[];
  var userSecretkey = '0tr6p5m2-j7ds-8gr2-5unc-48lw3c941z6s';
  String? categoryCode;
  String? status;
  var createCategoryUrl =
      Uri.parse('https://dev.toyyibpay.com/index.php/api/createCategory');
  var createBillUrl =
      Uri.parse('https://dev.toyyibpay.com/index.php/api/createBill');
  var getBillTransaction =
      Uri.parse('https://dev.toyyibpay.com/index.php/api/getBillTransactions');

  void init() async {
    //for multipartrequest
    var request = http.MultipartRequest('POST', createCategoryUrl);

    // //for token
    // request.headers.addAll({"Authorization": "Bearer token"});

    //for image and videos and files
    // request.files.add(await http.MultipartFile.fromPath(
    //     "key_value_from_api", "image_path/video/path"));

    request.fields['catname'] = 'EZFlutter${AppUser.instance.user!.uid}';
    request.fields['catdescription'] =
        'Category for all transaction from user id ${AppUser.instance.user!.uid}';
    request.fields['userSecretKey'] = userSecretkey;

    //for completeing the request
    var response = await request.send();

    //for getting and decoding the response into json format
    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      print("SUCCESS");
      var data = CreateCategoryResponse.fromJson(responseData);
      categoryCode = data.categoryCode;
      status = data.status;
      notifyListeners();
    } else {
      print("ERROR");
    }
  }

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
    request.fields['billPriceSetting'] = '1';
    request.fields['billPayorInfo'] = '0';
    request.fields['billAmount'] = '${price * 100}';
    request.fields['billReturnUrl'] = 'http://bizapp.my';
    request.fields['billCallbackUrl'] = 'http://bizapp.my/paystatus';
    request.fields['billExternalReferenceNo'] = 'AFR341DFI';
    request.fields['billTo'] = AppUser().user!.email!.split('@')[0];
    request.fields['billEmail'] = AppUser().user!.email!;
    request.fields['billPhone'] = AppUser().user!.phoneNumber ?? '+60123456789';
    request.fields['billSplitPayment'] = '0';
    request.fields['billSplitPaymentArgs'] = '';
    request.fields['billPaymentChannel'] = '0';
    request.fields['billContentEmail'] =
        'Thank you for purchasing our product!';
    request.fields['billChargeToCustomer'] = '1';
    request.fields['billExpiryDays'] = '$expired';
    request.fields['billExpiryDate'] = DateTime(DateTime.now().year,
            DateTime.now().month, DateTime.now().day + expired)
        .toString();
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

  Future<void> getBillTransactions(billCode) async {
    var request = http.MultipartRequest('POST', getBillTransaction);

    request.fields['billCode'] = billCode;

    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    final responseData = json.decode(responsed.body);

    if (response.statusCode == 200) {
      print("SUCCESS");
      print(responseData);
    } else {
      print("ERROR");
    }
  }

  void getCategory() {}
}
