import 'package:dropdown_search/dropdown_search.dart';
import 'package:ez_flutter/models/method.azan.dart';
import 'package:ez_flutter/providers/azan.time.provider.dart';
import 'package:ez_flutter/providers/location.provider.dart';
import 'package:ez_flutter/screen/getlocation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class GetApi extends StatefulWidget {
  const GetApi({Key? key}) : super(key: key);

  @override
  State<GetApi> createState() => _GetAPIState();
}

class _GetAPIState extends State<GetApi> {
  @override
  void initState() {
    if (Provider.of<LocationProvider>(context, listen: false).lat != null) {
      Provider.of<AzanProvider>(context, listen: false).getResponse(
          Provider.of<LocationProvider>(context, listen: false).lat,
          Provider.of<LocationProvider>(context, listen: false).long,
          GetStorage().read('id') ?? 3);
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const GetLocation()));
      });
    }

    super.initState();
  }

  String? status;
  int? code;
  bool search = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AzanProvider>(builder: (context, azan, child) {
      if (Provider.of<LocationProvider>(context, listen: false).lat == null) {
        return Scaffold(
            appBar: AppBar(
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const GetApi()));
                    },
                    child: const Text(
                      'Refresh',
                      style: TextStyle(color: Colors.white),
                    ))
              ],
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Please enable location,then click the refresh button to get the Prayer Time',
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
              ],
            )));
      }
      return Scaffold(
        appBar: AppBar(
          title: Text(azan.source),
          actions: [
            IconButton(
                onPressed: () async {
                  await showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      var id;
                      return AlertDialog(
                        content: DropdownSearch<MWL>(
                          asyncItems: (String filter) => getData(filter),
                          itemAsString: (MWL m) => m.name!,
                          onChanged: (MWL? data) async {
                            GetStorage().write('id', data!.id);
                            id = data.id;
                          },
                          dropdownDecoratorProps: const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  label: Text('Choose other method'))),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Back')),
                          TextButton(
                              onPressed: () {
                                Provider.of<AzanProvider>(context,
                                        listen: false)
                                    .getResponse(GetStorage().read('lat'),
                                        GetStorage().read('long'), id);
                                Navigator.pop(context);
                              },
                              child: const Text('Change'))
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(Icons.cached))
          ],
        ),
        body: Column(
          children: [
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: Card(
                        child: ListTile(
                      title: const Text('Date in Masihi'),
                      subtitle: Text(azan.date),
                    )),
                  ),
                  Flexible(
                    child: Card(
                        child: ListTile(
                      title: const Text('Date in Hijri'),
                      subtitle: Text(azan.dateHijri),
                    )),
                  ),
                ],
              ),
            ),
            Card(
                child: ListTile(
              leading: const Icon(Icons.nightlight_round),
              title: const Text('Imsak'),
              subtitle: Text(azan.time[0]),
            )),
            Card(
                child: ListTile(
              leading: const Icon(Icons.access_alarm),
              title: const Text('Fajar'),
              subtitle: Text(azan.time[1]),
            )),
            Card(
                child: ListTile(
              leading: const Icon(Icons.sunny_snowing),
              title: const Text('Sunrise'),
              subtitle: Text(azan.time[2]),
            )),
            Card(
                child: ListTile(
              leading: const Icon(Icons.sunny),
              title: const Text('Zohor'),
              subtitle: Text(azan.time[3]),
            )),
            Card(
                child: ListTile(
              leading: const Icon(Icons.sunny),
              title: const Text('Asar'),
              subtitle: Text(azan.time[4]),
            )),
            Card(
                child: ListTile(
              leading: const Icon(Icons.nightlight_round),
              title: const Text('Maghrib'),
              subtitle: Text(azan.time[5]),
            )),
            Card(
                child: ListTile(
              leading: const Icon(Icons.nightlight_round),
              title: const Text('Isya'),
              subtitle: Text(azan.time[6]),
            )),
          ],
        ),
      );
    });
  }

  Future<List<MWL>> getData(String filter) async {
    return await Provider.of<AzanProvider>(context, listen: false).getMethod();
  }
}
