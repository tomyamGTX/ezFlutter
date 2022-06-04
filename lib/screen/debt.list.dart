import 'package:ez_flutter/providers/local.provider.dart';
import 'package:ez_flutter/style/text/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebtListScreen extends StatefulWidget {
  const DebtListScreen({Key? key}) : super(key: key);

  @override
  State<DebtListScreen> createState() => _DebtListScreenState();
}

class _DebtListScreenState extends State<DebtListScreen> {
  @override
  void initState() {
    super.initState();
    // Provider.of<LocalProvider>(context, listen: false).getList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Text(
          'List of debt',
          style: titleTextStyle(),
        ),
      ),
      Consumer<LocalProvider>(
        builder: (BuildContext context, value, Widget? child) {
          if (value.debtList.isEmpty) {
            return SizedBox(
              height: 400,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(
                    Icons.monetization_on,
                    color: Colors.amberAccent,
                    size: 180,
                  ),
                  Text(
                    'Good. No Debtor.',
                    style: const TextTheme().titleLarge,
                  ),
                ],
              ),
            );
          }
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
              itemCount: value.debtList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  color: !value.debtList[index]['paid']
                      ? Colors.amberAccent
                      : Colors.green,
                  child: Center(
                    child: ListTile(
                      leading: Icon(Icons.manage_accounts,
                          color: !value.debtList[index]['paid']
                              ? Colors.black
                              : Colors.white),
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Choose action'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Provider.of<LocalProvider>(context,
                                              listen: false)
                                          .updateList(
                                              value.debtList[index], index);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      !value.debtList[index]['paid']
                                          ? 'MARK AS PAID'
                                          : 'MARK AS UNPAID',
                                      style: TextStyle(
                                          color: !value.debtList[index]['paid']
                                              ? Colors.green
                                              : Colors.amber),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Provider.of<LocalProvider>(context,
                                              listen: false)
                                          .deleteList(value.debtList[index]);
                                      Navigator.pop(context);
                                    },
                                    child: const Text(
                                      'DELETE',
                                      style: TextStyle(color: Colors.redAccent),
                                    ))
                              ],
                            );
                          },
                        );
                      },
                      trailing: Text(
                        "RM ${value.debtList[index]['price']}",
                        style: TextStyle(
                            color: !value.debtList[index]['paid']
                                ? Colors.black
                                : Colors.white),
                      ),
                      subtitle: Text(
                        "${value.debtList[index]['note']}",
                        style: TextStyle(
                            color: !value.debtList[index]['paid']
                                ? Colors.black
                                : Colors.white),
                      ),
                      title: Text(
                        "${value.debtList[index]['name']}",
                        style: TextStyle(
                            color: !value.debtList[index]['paid']
                                ? Colors.black
                                : Colors.white),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      )
    ]);
  }
}
