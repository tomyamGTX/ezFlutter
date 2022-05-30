import 'package:ez_flutter/providers/location.provider.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../style/button/button1.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({Key? key}) : super(key: key);

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<LocationProvider>(context, listen: false).readLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Get Current Location'),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {
                    setState(() {});
                    await Provider.of<LocationProvider>(context, listen: false)
                        .determinePosition();
                  },
                  icon: const Icon(Icons.cached))
            ],
          ),
          body: Center(
            child: Consumer<LocationProvider>(builder: (context, gps, child) {
              if (gps.lastSync == null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Center(child: Text('Location unavailable')),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          style: buttonStyle(),
                          onPressed: () async {
                            setState(() {});
                            await Provider.of<LocationProvider>(context,
                                    listen: false)
                                .determinePosition();
                          },
                          child: const Text('Get Current Location')),
                    )
                  ],
                );
              }
              return Column(
                children: [
                  Card(
                    child: ListTile(
                      title: const Text('Your position accuracy '),
                      subtitle: Text('${gps.accuracy}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Your position longitude'),
                      subtitle: Text(gps.long!.toStringAsFixed(4)),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Your position latitude '),
                      subtitle: Text(gps.lat!.toStringAsFixed(4)),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Last sync'),
                      subtitle: Text('${gps.lastSync}'),
                    ),
                  ),
                ],
              );
            }),
          )),
    );
  }
}
