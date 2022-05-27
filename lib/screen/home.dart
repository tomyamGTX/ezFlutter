import 'package:ez_flutter/screen/phone.number.screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.provider.dart';
import 'getapi.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          drawer: Drawer(
            // Add a ListView to the drawer. This ensures the user can scroll
            // through the options in the drawer if there isn't enough vertical
            // space to fit everything.
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.blueGrey,
                        radius: 40,
                        child: CircleAvatar(
                          radius: 38,
                          child: Text(
                            AppUser.instance.user!.email!
                                .substring(0, 1)
                                .toUpperCase(),
                            style: buildTextStyle(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ListTile(
                  trailing: const Icon(Icons.navigate_next),
                  title: const Text('Get Azan Time API'),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => GetApi()));
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {
                    Provider.of<AppUser>(context, listen: false).signOut();
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Welcome ${AppUser.instance.user?.email}'),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Your Phone Number is ${AppUser.instance.user?.phoneNumber}'),
                if (AppUser.instance.user?.phoneNumber == null)
                  const Text('Link Your Phone Number'),
                if (AppUser.instance.user?.phoneNumber == null)
                  TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PhoneNumberScreen())),
                    child: const Text('Go to Phone number screen'),
                  ),
              ],
            ),
          )),
    );
  }

  TextStyle buildTextStyle() => const TextStyle(fontSize: 20);
}
