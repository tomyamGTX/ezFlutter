import 'package:ez_flutter/style/text/text.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(16), children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          'Change Theme Color',
          style: titleTextStyle(),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            radius: 20,
            child: const CircleAvatar(
              radius: 17,
              backgroundColor: Colors.amber,
            ),
          ),
          tileColor: Theme.of(context).primaryColorLight,
          onTap: () {
            MyApp.of(context)!.changeColor(1);
          },
          trailing: const Icon(Icons.navigate_next),
          title: const Text(
            'Change to Amber',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            radius: 20,
            child: const CircleAvatar(
              radius: 17,
              backgroundColor: Colors.red,
            ),
          ),
          tileColor: Theme.of(context).primaryColorLight,
          onTap: () {
            MyApp.of(context)!.changeColor(0);
          },
          trailing: const Icon(Icons.navigate_next),
          title: const Text(
            'Change to Red',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            radius: 20,
            child: const CircleAvatar(
              radius: 17,
              backgroundColor: Colors.purple,
            ),
          ),
          tileColor: Theme.of(context).primaryColorLight,
          onTap: () {
            MyApp.of(context)!.changeColor(2);
          },
          trailing: const Icon(Icons.navigate_next),
          title: const Text(
            'Change to Purple',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    ]);
  }
}
