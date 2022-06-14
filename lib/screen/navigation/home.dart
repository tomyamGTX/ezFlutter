import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ez_flutter/screen/navigation/todo.list.dart';
import 'package:ez_flutter/screen/phone.number.screen.dart';
import 'package:ez_flutter/screen/update.name.dart';
import 'package:ez_flutter/style/text/text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../providers/auth.provider.dart';
import 'debt.list.dart';

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

  final _icon = [Icons.attach_money, Icons.task, Icons.man, Icons.access_alarm];
  final _label = ['Debt List', 'Todo List', 'Location', 'Reminder'];

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
        Container(
          margin: const EdgeInsets.all(16),
          child: Text(
            'Date Today ' +
                DateTime.now().day.toString() +
                '/' +
                DateTime.now().month.toString() +
                '/' +
                DateTime.now().year.toString(),
            textAlign: TextAlign.center,
            style: titleTextStyle(),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              borderRadius: BorderRadius.circular(8)),
          height: 80,
          child: GridView.builder(
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  if (index == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DebtListScreen()));
                  } else if (index == 1) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TodoList()));
                  } else if (index == 2) {
                    Fluttertoast.showToast(
                        msg: "Feature not available",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColorLight,
                        fontSize: 16.0);
                  } else {
                    Fluttertoast.showToast(
                        msg: "Feature not available",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColorLight,
                        fontSize: 16.0);
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _icon[index],
                      color: Theme.of(context).primaryColorDark,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _label[index],
                        style: TextStyle(color: Theme.of(context).hintColor),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        )
      ],
    )));
  }
}
