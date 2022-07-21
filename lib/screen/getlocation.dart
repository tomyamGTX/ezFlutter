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
    return loading
        ? const Center(
            child: Padding(
            padding: EdgeInsets.all(16.0),
            child: CircularProgressIndicator(),
          ))
        : Center(
            child: Consumer<LocationProvider>(builder: (context, gps, child) {
              if (gps.lastSync == null) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                  onPressed: () async =>
                      Provider.of<LocationProvider>(context, listen: false)
                          .remove(),
                  icon: const Icon(Icons.delete),
                  label: const Text('Delete Location'),
                ),
              );
            }),
          );
  }
}
