import 'dart:convert';

import 'package:ez_flutter/models/zone.model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/azan.model.dart';
import '../models/state.model.dart';

class AzanProvider extends ChangeNotifier {
  List<String> time = [];
  String date = '';
  String dateHijri = '';
  String utc = '';
  String source = '';
  ZoneModel? zone;
  StateModel? state;
  AzanModel? azanModel;
  Future<List<String>> getZone(String states) async {
    var url = Uri.parse(
        'https://waktu-solat-api.herokuapp.com/api/v1/states.json?negeri=$states');
    var response = await http.get(url);
    zone = ZoneModel.fromJson(jsonDecode(response.body));
    notifyListeners();
    return zone!.data!.negeri!.zon!;
  }

  Future<List<String>> getState() async {
    var url =
        Uri.parse('https://waktu-solat-api.herokuapp.com/api/v1/states.json');
    var response = await http.get(url);
    state = StateModel.fromJson(jsonDecode(response.body));
    notifyListeners();
    return state!.data!.negeri!;
  }

  Future<void> getAzan(String zone) async {
    azanModel = null;
    var url = Uri.parse(
        'https://waktu-solat-api.herokuapp.com/api/v1/prayer_times.json?zon=$zone');
    var response = await http.get(url);
    azanModel = AzanModel.fromJson(jsonDecode(response.body));
    notifyListeners();
  }
}
