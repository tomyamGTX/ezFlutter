import 'package:ez_flutter/providers/location.provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import '../providers/auth.provider.dart';
import '../style/button/button1.dart';
import '../widgets/drawer.home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Position? location;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: buildDrawer(context),
          appBar: AppBar(
            title: Text('Welcome ${AppUser.instance.user?.email}'),
          ),
          body: Center(
            child: Column(
              children: [
                Consumer<LocationProvider>(builder: (context, gps, child) {
                  if (gps.position == null) {
                    return const SizedBox(
                      height: 100,
                      child: Center(child: Text('Location unavailable')),
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
                          title: const Text('Your position altitude '),
                          subtitle: Text('${gps.position!.altitude}'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Your position floor '),
                          subtitle: Text('${gps.position!.floor}'),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text('Your position floor'),
                          subtitle: Text('${gps.position!.floor}'),
                        ),
                      ),
                    ],
                  );
                }),
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
            ),
          )),
    );
  }
}
