import 'dart:convert';

import 'package:ez_flutter/models/create.category.response.model.dart';
import 'package:ez_flutter/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaymentProvider extends ChangeNotifier {
  PaymentProvider() {
    init();
  }

  var userSecretkey = '0tr6p5m2-j7ds-8gr2-5unc-48lw3c941z6s';
  String? categoryCode;
  String? status;
  var createCategoryUrl =
      Uri.parse('https://dev.toyyibpay.com/index.php/api/createCategory');
  var createBillUrl =
      Uri.parse('https://dev.toyyibpay.com/index.php/api/createBill');

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

  Future<void> createBill() async {
    var request = http.MultipartRequest('POST', createBillUrl);

    request.fields['catname'] = 'EZFlutter${AppUser.instance.user!.uid}';
    request.fields['catdescription'] =
        'Category for all transaction from user id ${AppUser.instance.user!.uid}';
    request.fields['userSecretKey'] = userSecretkey;

    var response = await request.send();

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

  void getBillTransactions() {}

  void getCategory() {}
}
