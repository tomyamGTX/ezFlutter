import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.provider.dart';
import '../screen/getapi.dart';
import '../screen/phone.number.screen.dart';
import '../screen/timeline.dart';
import '../style/text/text.dart';

Drawer buildDrawer(BuildContext context) {
  return Drawer(
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
                    AppUser.instance.user!.email!.substring(0, 1).toUpperCase(),
                    style: basicTextStyle(),
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => GetApi()));
          },
        ),
        ListTile(
          trailing: const Icon(Icons.navigate_next),
          title: const Text('Planet Timeline'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Timeline()));
          },
        ),
        if (AppUser.instance.user?.phoneNumber == null)
          ListTile(
            trailing: const Icon(Icons.navigate_next),
            subtitle: const Text('Link Your Phone Number'),
            title: const Text('Go to Phone number screen'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PhoneNumberScreen()));
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
  );
}
