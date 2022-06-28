import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ez_flutter/providers/auth.provider.dart';
import 'package:ez_flutter/screen/profile/phone.number.screen.dart';
import 'package:ez_flutter/screen/profile/update.name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_avatar/flutter_advanced_avatar.dart';

import '../../style/text/text.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Update Profile',
                textAlign: TextAlign.center,
                textStyle: titleTextStyle(),
                speed: const Duration(milliseconds: 200),
              ),
            ],
            totalRepeatCount: 4,
            pause: const Duration(milliseconds: 500),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ),
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
        Card(
          child: ListTile(
            trailing: Icon(Icons.navigate_next),
            title: const Text('Change Name'),
            subtitle:
                Text(AppUser.instance.user!.displayName ?? 'Name not set yet'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const UpdateName())),
          ),
        ),
        Card(
          child: ListTile(
            trailing: const Icon(Icons.navigate_next),
            title: Text(AppUser.instance.user!.phoneNumber != null
                ? 'Change Phone Number'
                : 'Link Phone Number'),
            subtitle:
                Text(AppUser.instance.user!.phoneNumber ?? 'Not link yet'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PhoneNumberScreen())),
          ),
        )
      ],
    ));
  }
}
