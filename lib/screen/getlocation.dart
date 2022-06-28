import 'package:ez_flutter/providers/location.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../style/button/button1.dart';

class GetLocation extends StatefulWidget {
  const GetLocation({Key? key}) : super(key: key);

  @override
  State<GetLocation> createState() => _GetLocationState();
}

class _GetLocationState extends State<GetLocation> {
  bool loading = false;

  @override
  void initState() {
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
                    loading = !loading;
                    await Provider.of<LocationProvider>(context, listen: false)
                        .determinePosition();
                    setState(() {});
                    loading = !loading;
                  },
                  icon: const Icon(Icons.cached))
            ],
          ),
          body: loading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Consumer<LocationProvider>(
                      builder: (context, gps, child) {
                    if (gps.lastSync == null) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Center(child: Text('Location unavailable')),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton.icon(
                              style: buttonStyle(),
                              onPressed: () async {
                                setState(() {});
                                loading = !loading;
                                await Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .determinePosition();
                                setState(() {});
                                loading = !loading;
                              },
                              icon: const Icon(Icons.location_on_sharp),
                              label: const Text('Get Current Location'),
                            ),
                          )
                        ],
                      );
                    }
                    return Column(
                      children: [
                        Card(
                          child: ListTile(
                            title: const Text('Address line 1'),
                            subtitle: Text('${gps.address1}'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: const Text('Address line 2'),
                            subtitle: Text('${gps.address2}'),
                          ),
                        ),
                        Card(
                          child: ListTile(
                            title: const Text('Address line 3'),
                            subtitle: Text('${gps.address3}'),
                          ),
                        ),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: ElevatedButton.icon(
                            onPressed: () async =>
                                Provider.of<LocationProvider>(context,
                                        listen: false)
                                    .remove(),
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete Location'),
                          ),
                        )
                      ],
                    );
                  }),
                )),
    );
  }
}
