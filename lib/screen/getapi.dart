import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/azan.model.dart';

class GetApi extends StatefulWidget {
  const GetApi({Key? key}) : super(key: key);

  @override
  State<GetApi> createState() => _GetAPIState();
}

class _GetAPIState extends State<GetApi> {
  String? fajr;

  String? imsak;

  String? sunrise;

  String? dhuhr;

  String? asr;

  String? maghrib;

  String? isha;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String _state = 'Select state';
  String? status;
  int? code;
  bool search = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Get Azan Time API'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownSearch(
                  items: const [
                    "Johor",
                    "Kedah",
                    "Kelantan",
                    'Melaka',
                    'Negeri Sembilan',
                    'Pahang',
                    'Pulau Pinang',
                    'Perak',
                    'Perlis',
                    'Sabah',
                    'Sarawak',
                    'Selangor',
                    'Terengganu',
                    'Kuala Lumpur',
                    'Labuan',
                    'Putrajaya',
                  ],
                  dropdownSearchDecoration:
                      const InputDecoration(labelText: "Choose State"),
                  onChanged: (String? state) {
                    setState(() {
                      _state = state!;
                    });
                    var item;
                    search = true;
                    if (state == 'Johor') {
                      item = [2, 2, 0, 1, 0, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Kedah') {
                      item = [3, 3, -1, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Kelantan') {
                      item = [2, 2, 0, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Melaka') {
                      item = [2, 2, 0, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Negeri Sembilan') {
                      item = [3, 3, 0, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Pahang') {
                      item = [2, 2, 0, 1, 0, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Pulau Pinang') {
                      item = [2, 2, 0, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Perak') {
                      item = [3, 3, 0, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Perlis') {
                      item = [3, 3, 0, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Sabah') {
                      item = [2, 2, 0, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Sarawak') {
                      item = [2, 2, 0, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Selangor') {
                      item = [3, 3, 1, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Terengganu') {
                      item = [2, 2, 0, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Kuala Lumpur') {
                      item = [2, 2, 0, 0, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Labuan') {
                      item = [2, 2, 0, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    } else if (state == 'Putrajaya') {
                      item = [2, 2, 0, 1, 1, 1, 0, 1, 0];
                      getResponse(state!, 'Malaysia', item);
                    }
                  },
                  selectedItem: _state,
                ),
              ),
              Visibility(
                visible: search,
                child: Column(
                  children: [
                    Card(
                        child: ListTile(
                      leading: const Icon(Icons.nightlight_round),
                      title: const Text('Imsak'),
                      subtitle: Text('$imsak'),
                    )),
                    Card(
                        child: ListTile(
                      leading: const Icon(Icons.access_alarm),
                      title: const Text('Fajar'),
                      subtitle: Text('$fajr'),
                    )),
                    Card(
                        child: ListTile(
                      leading: const Icon(Icons.sunny_snowing),
                      title: const Text('Sunrise'),
                      subtitle: Text('$sunrise'),
                    )),
                    Card(
                        child: ListTile(
                      leading: const Icon(Icons.sunny),
                      title: const Text('Zohor'),
                      subtitle: Text('$dhuhr'),
                    )),
                    Card(
                        child: ListTile(
                      leading: const Icon(Icons.sunny),
                      title: const Text('Asar'),
                      subtitle: Text('$asr'),
                    )),
                    Card(
                        child: ListTile(
                      leading: const Icon(Icons.nightlight_round),
                      title: const Text('Maghrib'),
                      subtitle: Text('$maghrib'),
                    )),
                    Card(
                        child: ListTile(
                      leading: const Icon(Icons.nightlight_round),
                      title: const Text('Isya'),
                      subtitle: Text('$isha'),
                    )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> getResponse(String city, String country, List tune) async {
    var url = Uri.parse(
        'https://api.aladhan.com/v1/timingsByCity?city=$city&country=$country&method=1&tune=${tune[0]},${tune[1]},${tune[2]},${tune[3]},${tune[4]},${tune[5]},${tune[6]},${tune[7]},${tune[8]}');
    var response = await http.get(url);
    var data = Azan.fromJson(json.decode(response.body));
    setState(() {});
    status = data.status;
    code = data.code;
    fajr = data.data!.timings!.fajr;
    imsak = data.data!.timings!.imsak;
    sunrise = data.data!.timings!.sunrise;
    dhuhr = data.data!.timings!.dhuhr;
    asr = data.data!.timings!.asr;
    maghrib = data.data!.timings!.maghrib;
    isha = data.data!.timings!.isha;
  }
}
