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

  var billName = TextEditingController();

  var billDesc = TextEditingController();

  var price = TextEditingController();

  var expired = TextEditingController();

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
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Add New Bill'),
                              content: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
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
                                      await Provider.of<PaymentProvider>(
                                              context,
                                              listen: false)
                                          .createBill(
                                              billName: billName.text,
                                              billDesc: billDesc.text,
                                              price: price.text,
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
                  ElevatedButton(
                      onPressed: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('List All Bill'),
                              content: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Consumer<PaymentProvider>(
                                    builder: (context, bill, child) {
                                  return ListView.builder(
                                    itemCount: bill.allBill.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                        child: ListTile(
                                          title: Text(
                                              '${bill.allBill[index].billName} (${bill.allBill[index].billCode})'),
                                          subtitle: Text(bill
                                              .allBill[index].expired
                                              .toString()),
                                          trailing: Text(bill
                                              .allBill[index].billPrice
                                              .toString()),
                                        ),
                                      );
                                    },
                                  );
                                }),
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('Back')),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('List All Bill'))
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
