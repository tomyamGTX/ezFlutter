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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text('Get Current Location'),
            centerTitle: true,
          ),
          body: Center(
            child: Consumer<LocationProvider>(builder: (context, gps, child) {
              if (gps.position == null) {
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
                      subtitle: Text('${gps.position!.accuracy}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Your position longitude'),
                      subtitle: Text('${gps.position!.longitude}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Your position latitude '),
                      subtitle: Text('${gps.position!.latitude}'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Last sync'),
                      subtitle: Text('${gps.position!.timestamp}'),
                    ),
                  ),
                ],
              );
            }),
          )),
    );
  }
}
