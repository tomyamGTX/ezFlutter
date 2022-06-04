import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_flutter/screen/phone.number.screen.dart';
import 'package:ez_flutter/screen/update.name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var index = 0;

  var name = ['Add category', 'Display All Category', 'Make Payment'];

  var billName = TextEditingController();

  var billDesc = TextEditingController();

  var price = TextEditingController();

  var expired = TextEditingController();

  CollectionReference bills = FirebaseFirestore.instance
      .collection('users')
      .doc(AppUser().user!.uid)
      .collection('bill');

  var _visible = true;

  @override
  Widget build(BuildContext context) {
    Provider.of<AppUser>(context, listen: false).getName();
    return SafeArea(
        child: Scaffold(
            body: ListView(
      children: [
        if (AppUser.instance.user?.displayName == null)
          Visibility(
            visible: _visible,
            child: InkWell(
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const UpdateName())),
              child: ListTile(
                trailing: IconButton(
                  onPressed: () {
                    setState(() {});
                    _visible = !_visible;
                  },
                  icon: const Icon(Icons.clear),
                ),
                title: const Text('Username not set'),
                subtitle: const Text('Click to update now!'),
                tileColor: Colors.yellow[200],
              ),
            ),
          ),
        if (AppUser.instance.user?.phoneNumber == null)
          Visibility(
            visible: _visible,
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PhoneNumberScreen())),
              child: ListTile(
                trailing: IconButton(
                  onPressed: () {
                    setState(() {});
                    _visible = !_visible;
                  },
                  icon: const Icon(Icons.clear),
                ),
                title: const Text('Phone Number not set'),
                subtitle: const Text('Click to update now!'),
                tileColor: Colors.yellow[200],
              ),
            ),
          ),
      ],
    )));
  }
}
