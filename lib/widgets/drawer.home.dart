import 'package:ez_flutter/screen/animation.dart';
import 'package:ez_flutter/screen/sandbox.payment.dart';
import 'package:ez_flutter/widgets/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

import '../providers/auth.provider.dart';
import '../screen/getapi.dart';
import '../screen/getlocation.dart';
import '../screen/phone.number.screen.dart';
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
            child: AdvancedAvatar(
              name: AppUser.instance.user!.displayName,
              statusColor: Colors.green,
              foregroundDecoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Theme.of(context).primaryColorDark,
                  width: 5.0,
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
        ListTile(
          trailing: const Icon(Icons.navigate_next),
          title: const Text('Get Current Location'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const GetLocation()));
          },
        ),
        ListTile(
          trailing: const Icon(Icons.navigate_next),
          title: const Text('Rive Animation'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AnimationScreen()));
          },
        ),
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
        ListTile(
          trailing: const Icon(Icons.navigate_next),
          title: const Text('SandBox Payment'),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SandBoxPayment()));
          },
        ),
        ListTile(
          trailing: const Icon(Icons.logout),
          title: const Text('Logout'),
          onTap: () async {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Loading2()));
          },
        ),
      ],
    ),
  );
}
