import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:ez_flutter/providers/payment.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.provider.dart';
import '../widgets/drawer.home.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var index = 0;

  var name = ['Add category', 'Display All Category', 'Make Payment'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        title: Text('Welcome ${AppUser.instance.user?.email!.split('@')[0]}'),
        actions: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.shopping_cart_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.local_mall))
        ],
      ),
      body: DoubleBackToCloseApp(
        child: Consumer<PaymentProvider>(builder: (context, pay, child) {
          return ListView(
            children: [
              ListTile(
                title: const Text('Category Code'),
                subtitle:
                    Text(pay.categoryCode ?? 'No category code available'),
              ),
              ListTile(
                title: const Text('Status'),
                subtitle: Text(pay.status ?? 'No status'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Add New Bill')),
                  ElevatedButton(
                      onPressed: () {}, child: const Text('List All Bill'))
                ],
              )
            ],
          );
        }),
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
      ),
    ));
  }
}
