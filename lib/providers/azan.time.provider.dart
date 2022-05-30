import 'package:ez_flutter/models/method.azan.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/azan.model.dart' as azan;

class AzanProvider extends ChangeNotifier {
  List<String> time = [];
  String date = '';
  String dateHijri = '';
  String utc = '';
  String source = '';

  Future<void> getResponse(lat, long, method) async {
    var url = Uri.parse(
        'http://api.aladhan.com/v1/timings/${DateTime.now().toIso8601String()}?latitude=${lat.toStringAsFixed(4)}&longitude=${long.toStringAsFixed(4)}&method=${method}');
    var response = await http.get(url);
    var data = azan.Azan.fromJson(json.decode(response.body));
    time.clear();
    time.add(data.data!.timings!.imsak!);
    time.add(data.data!.timings!.fajr!);
    time.add(data.data!.timings!.sunrise!);
    time.add(data.data!.timings!.dhuhr!);
    time.add(data.data!.timings!.asr!);
    time.add(data.data!.timings!.maghrib!);
    time.add(data.data!.timings!.isha!);
    date = data.data!.date!.readable!;
    dateHijri = data.data!.date!.hijri!.date!;
    utc = data.data!.meta!.timezone!;
    source = data.data!.meta!.method!.name!;
    notifyListeners();
  }

  Future<List<MWL>> getMethod() async {
    List<MWL> list = [];
    var response = await http.get(Uri.parse('https://api.aladhan.com/methods'));
    var data = Method.fromJson(json.decode(response.body));

    list.add(data.data!.eGYPT!);
    list.add(data.data!.fRANCE!);
    list.add(data.data!.gULF!);
    list.add(data.data!.iSNA!);
    list.add(data.data!.kARACHI!);
    list.add(data.data!.kUWAIT!);
    list.add(data.data!.mAKKAH!);
    list.add(data.data!.mWL!);
    list.add(data.data!.qATAR!);
    list.add(data.data!.rUSSIA!);
    list.add(data.data!.sINGAPORE!);
    list.add(data.data!.tEHRAN!);
    list.add(data.data!.tURKEY!);

    return list;
  }
}
