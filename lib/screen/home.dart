import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:ez_flutter/providers/payment.provider.dart';
import 'package:ez_flutter/screen/webview.payment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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

  var billName = TextEditingController();

  var billDesc = TextEditingController();

  var price = TextEditingController();

  var expired = TextEditingController();

  CollectionReference bills = FirebaseFirestore.instance
      .collection('users')
      .doc(AppUser().user!.uid)
      .collection('bill');
  final _select = [];

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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Add New Bill'),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: ListView(
                                children: [
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text('Name')),
                                    controller: billName,
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text('Description')),
                                    controller: billDesc,
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                        label: Text('Price')),
                                    controller: price,
                                    keyboardType: TextInputType.number,
                                  ),
                                  TextFormField(
                                    controller: expired,
                                    decoration: const InputDecoration(
                                        label: Text('Days expired')),
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Back')),
                              TextButton(
                                  onPressed: () async {
                                    await Provider.of<PaymentProvider>(context,
                                            listen: false)
                                        .createBill(context,
                                            billName: billName.text,
                                            billDesc: billDesc.text,
                                            price: double.parse(price.text),
                                            expired: int.parse(expired.text));
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Add'))
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Add New Bill')),
              ),
              FutureBuilder<QuerySnapshot>(
                future: bills.get(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  print('read data..');
                  if (snapshot.hasError) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('No bill available'),
                    ));
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    var data = snapshot.data!.docs;

                    for (var item in data) {
                      _select.add(item['paid']);
                    }
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: data[index]['paid']
                                        ? Colors.greenAccent
                                        : Colors.redAccent,
                                    child: Icon(
                                      data[index]['paid']
                                          ? Icons.check
                                          : Icons.close,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: Text(data[index]['billName']),
                                  subtitle: Text('RM ' +
                                      data[index]['billPrice'].toString()),
                                  trailing: TextButton(
                                    onPressed: () async {
                                      // _launchUrl(data[index]['billCode']);
                                      Provider.of<PaymentProvider>(context,
                                              listen: false)
                                          .setBool(data[index]['paid']);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  WebViewExample(
                                                      data[index]['billCode'],
                                                      data[index]['paid'])));
                                    },
                                    child: Text(data[index]['paid']
                                        ? 'View Receipt'
                                        : 'Pay Now'),
                                  )));
                        },
                      ),
                    );
                  }

                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.redAccent,
                  ));
                },
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
