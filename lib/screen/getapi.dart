import 'package:dropdown_search/dropdown_search.dart';
import 'package:ez_flutter/providers/azan.time.provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:simple_icons/simple_icons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/notification.provider.dart';

class GetApi extends StatefulWidget {
  const GetApi({Key? key}) : super(key: key);

  @override
  State<GetApi> createState() => _GetAPIState();
}

class _GetAPIState extends State<GetApi> {
  String? state;
  String? zone;
  int? code;
  bool search = false;

  final List _value = GetStorage().read('azan') ??
      [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Consumer<AzanProvider>(builder: (context, data, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
              '${GetStorage().read('zone') ?? 'Zone'},${GetStorage().read('state') ?? 'State'}'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: DropdownSearch<String>(
                asyncItems: (String filter) => getState(filter),
                itemAsString: (v) => v.toUpperCase(),
                selectedItem: state,
                onChanged: (v) async {
                  setState(() {
                    state = v;
                    GetStorage().write('state', v!.toUpperCase());
                  });
                  await data.getZone(v!);
                },
                dropdownDecoratorProps: const DropDownDecoratorProps(
                    dropdownSearchDecoration:
                        InputDecoration(label: Text('Select State'))),
              ),
            ),
            if (state != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownSearch<String>(
                  selectedItem: zone,
                  asyncItems: (String filter) => getZone(filter),
                  itemAsString: (v) => v.toUpperCase(),
                  onChanged: (v) async {
                    data.getAzan(v!);
                    setState(() {
                      zone = v;
                      GetStorage().write('zone', v.toUpperCase());
                    });
                  },
                  dropdownDecoratorProps: const DropDownDecoratorProps(
                      dropdownSearchDecoration:
                          InputDecoration(label: Text('Select Zone'))),
                ),
              ),
            if (data.azanModel != null)
              ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  var item = data.azanModel!.data!.first.waktuSolat![index];
                  var now = DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.now().day,
                      int.parse(item.time!.split(':').first),
                      int.parse(item.time!.split(':').last));
                  bool set = _value[index];
                  if (set) {
                    Provider.of<NotificationProvider>(context, listen: false)
                        .scheduleNotification(context,
                            channelDesc: 'Notification for ${item.name!}',
                            channelName: item.name!,
                            body: 'Take wudhu and prepare for prayer now!',
                            title: 'Its time to perform ${item.name!} prayer ',
                            dateTime: now);
                  }
                  return ListTile(
                    title: Text(item.name!),
                    subtitle: Text(item.time!),
                    trailing: index != 0 && index != 2
                        ? Switch(
                            value: _value[index],
                            onChanged: (bool value) {
                              setState(() {
                                _value[index] = value;
                                GetStorage().write('azan', _value);
                              });
                              if (value) {
                                Provider.of<NotificationProvider>(context,
                                        listen: false)
                                    .scheduleNotification(context,
                                        channelDesc:
                                            'Notification for ${item.name!}',
                                        channelName: item.name!,
                                        body:
                                            'Take wudhu and prepare for prayer now!',
                                        title:
                                            'Its time to perform ${item.name!} prayer ',
                                        dateTime: now);
                              }
                            },
                          )
                        : null,
                  );
                },
                itemCount: data.azanModel!.data!.first.waktuSolat!.length,
                primary: false,
                shrinkWrap: true,
              ),
            if (data.state != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Divider(
                        thickness: 2,
                        color: Theme.of(context).primaryColor,
                      ),
                      IconButton(
                          onPressed: () {
                            launch(data.state!.about!.github!);
                          },
                          icon: const Icon(SimpleIcons.github)),
                      Text('Created by: ' + data.state!.about!.createdBy!),
                      Text('Source: ' + data.state!.about!.source!)
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  Future<List<String>> getState(String filter) async {
    return await Provider.of<AzanProvider>(context, listen: false).getState();
  }

  Future<List<String>> getZone(String filter) async {
    return await Provider.of<AzanProvider>(context, listen: false)
        .getZone(state!);
  }
}
