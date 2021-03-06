import 'package:ez_flutter/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

import '../providers/auth.provider.dart';
import '../screen/getapi.dart';
import '../screen/getlocation.dart';
import '../screen/profile/phone.number.screen.dart';
import '../screen/timeline.dart';

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
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AdvancedAvatar(
                  image: AppUser.instance.user!.photoURL != null
                      ? NetworkImage(AppUser.instance.user!.photoURL!)
                      : null,
                  size: 60,
                  name: AppUser.instance.user!.photoURL != null
                      ? null
                      : AppUser.instance.user!.displayName ?? 'User',
                  statusColor: Colors.green,
                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Theme.of(context).primaryColorDark,
                      width: 5.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    AppUser.instance.user!.email ?? 'Email User',
                    style:
                        TextStyle(color: Theme.of(context).primaryColorLight),
                  ),
                ),
              ],
            ),
          ),
        ),
        ListTile(
          trailing: const Icon(Icons.navigate_next),
          title: const Text('Prayer Time in Malaysia'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GetApi()));
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
        ListTile(
          trailing: const Icon(Icons.navigate_next),
          title: const Text('Get Current Location'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GetLocation()));
          },
        ),
        // ListTile(
        //   trailing: const Icon(Icons.navigate_next),
        //   title: const Text('Rive Animation'),
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => const AnimationScreen()));
        //   },
        // ),
        ListTile(
          trailing: const Icon(Icons.navigate_next),
          subtitle: AppUser.instance.user?.phoneNumber != null
              ? Text(AppUser.instance.user!.phoneNumber!)
              : const Text('Link Your Phone Number'),
          title: AppUser.instance.user?.phoneNumber != null
              ? const Text('Your Phone Number')
              : const Text('Go to Phone number screen'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PhoneNumberScreen()));
          },
        ),
        // ListTile(
        //   trailing: const Icon(Icons.navigate_next),
        //   title: const Text('SandBox Payment'),
        //   onTap: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => const SandBoxPayment()));
        //   },
        // ),
        ListTile(
          trailing: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () async {
            await Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Loading2()));
          },
        ),
      ],
    ),
  );
}
