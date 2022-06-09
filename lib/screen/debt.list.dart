import 'package:ez_flutter/providers/local.provider.dart';
import 'package:ez_flutter/style/text/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/form.dart';

class DebtListScreen extends StatefulWidget {
  const DebtListScreen({Key? key}) : super(key: key);

  @override
  State<DebtListScreen> createState() => _DebtListScreenState();
}

class _DebtListScreenState extends State<DebtListScreen> {
  final _price = TextEditingController();
  final _note = TextEditingController();
  final _prices = TextEditingController();
  final _notes = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeys = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
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
                  Icon(
                    Icons.monetization_on,
                    color: Theme.of(context).primaryColor,
                    size: 180,
                  ),
                  Text(
                    'Good. Your debt list is empty.',
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
                String first = "${value.debtList[index]['name']}"
                    .substring(0, 1)
                    .toUpperCase();
                String back = "${value.debtList[index]['name']}"
                    .substring(1)
                    .toLowerCase();
                var name = first + back;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Theme.of(context).primaryColorLight,
                    child: Center(
                      child: ExpansionTile(
                        title: Text(
                          name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              Flexible(
                                child: IconButton(
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('New debt amount'),
                                          content: SizedBox(
                                            height: 265,
                                            width: 600,
                                            child: Form(
                                              key: _formKey,
                                              child: ListView(
                                                children: [
                                                  FormUi(
                                                    controller: _price,
                                                    hint: 'Price',
                                                    isPhone: false,
                                                    type: const TextInputType
                                                            .numberWithOptions(
                                                        decimal: true),
                                                  ),
                                                  FormUi(
                                                    controller: _note,
                                                    hint: 'Note',
                                                    isPhone: false,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            Provider.of<LocalProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .addValue(
                                                                    double.parse(
                                                                        _price
                                                                            .text),
                                                                    _note.text,
                                                                    index);
                                                            _note.clear();
                                                            _price.clear();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              const SnackBar(
                                                                  content: Text(
                                                                      'Adding debt amount...')),
                                                            );
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        },
                                                        child:
                                                            const Text('Add')),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ),
                              Flexible(
                                child: IconButton(
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Confirm Delete'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Provider.of<LocalProvider>(
                                                          context,
                                                          listen: false)
                                                      .deleteList(value
                                                          .debtList[index]);
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    const SnackBar(
                                                        content: Text(
                                                            'Debtor deleted')),
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'YES',
                                                  style: TextStyle(
                                                      color: Colors.green),
                                                )),
                                            TextButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text(
                                                  'NO',
                                                  style: TextStyle(
                                                      color: Colors.redAccent),
                                                ))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ),
                            ],
                          ),
                        ),
                        subtitle: Text(
                          "${value.debtList[index]['amount'].length} debt(s)",
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        children: <Widget>[
                          for (var item in value.debtList[index]['amount'])
                            ListTile(
                                tileColor:
                                    Theme.of(context).secondaryHeaderColor,
                                leading: CircleAvatar(
                                  child: Icon(
                                    item['paid'] ? Icons.check : Icons.close,
                                    color:
                                        Theme.of(context).secondaryHeaderColor,
                                  ),
                                  backgroundColor: item['paid']
                                      ? Colors.green
                                      : Theme.of(context).errorColor,
                                ),
                                title: Text(
                                  'RM ' + item['price'].toStringAsFixed(2),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                subtitle: Text(
                                  item['note'],
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor),
                                ),
                                trailing: SizedBox(
                                  width: 130,
                                  child: Row(
                                    children: [
                                      TextButton(
                                          onPressed: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Choose action'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Provider.of<LocalProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .updateList(
                                                                  value.debtList[
                                                                      index],
                                                                  index,
                                                                  item,
                                                                  item['price'],
                                                                  item['paid'],
                                                                  item['note']);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Debt status updated')),
                                                          );
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          !item['paid']
                                                              ? 'MARK AS PAID'
                                                              : 'MARK AS UNPAID',
                                                          style: TextStyle(
                                                              color: !item[
                                                                      'paid']
                                                                  ? Colors.green
                                                                  : Colors.red),
                                                        )),
                                                    TextButton(
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                          await showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    'Update Debt Detail'),
                                                                content:
                                                                    SizedBox(
                                                                  height: 265,
                                                                  width: 600,
                                                                  child: Form(
                                                                    key:
                                                                        _formKeys,
                                                                    child:
                                                                        ListView(
                                                                      children: [
                                                                        Text(
                                                                          'Old Price: RM ' +
                                                                              item['price'].toStringAsFixed(2),
                                                                        ),
                                                                        FormUi(
                                                                          controller:
                                                                              _prices,
                                                                          hint:
                                                                              'New Price',
                                                                          isPhone:
                                                                              false,
                                                                          type:
                                                                              const TextInputType.numberWithOptions(decimal: true),
                                                                        ),
                                                                        Text(
                                                                          'Old Note: ' +
                                                                              item['note'],
                                                                        ),
                                                                        FormUi(
                                                                          controller:
                                                                              _notes,
                                                                          hint:
                                                                              'New Note',
                                                                          isPhone:
                                                                              false,
                                                                        ),
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child: ElevatedButton(
                                                                              onPressed: () {
                                                                                if (_formKeys.currentState!.validate()) {
                                                                                  bool isPaid = item['paid'];
                                                                                  Provider.of<LocalProvider>(context, listen: false).updateValue(double.parse(_prices.text), _notes.text, isPaid, item);
                                                                                  _notes.clear();
                                                                                  _prices.clear();
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    const SnackBar(content: Text('Updating debt detail...')),
                                                                                  );
                                                                                  Navigator.pop(context);
                                                                                } else {
                                                                                  bool isPaid = item['paid'];
                                                                                  String note = item['note'];
                                                                                  double price = item['price'];
                                                                                  if (_prices.text.isEmpty && _notes.text.isEmpty) {
                                                                                    Provider.of<LocalProvider>(context, listen: false).updateValue(price, note, isPaid, item);
                                                                                  } else if (_prices.text.isNotEmpty && _notes.text.isEmpty) {
                                                                                    Provider.of<LocalProvider>(context, listen: false).updateValue(double.parse(_prices.text), note, isPaid, item);
                                                                                  } else if (_prices.text.isEmpty && _notes.text.isNotEmpty) {
                                                                                    Provider.of<LocalProvider>(context, listen: false).updateValue(price, _notes.text, isPaid, item);
                                                                                  }
                                                                                  _notes.clear();
                                                                                  _prices.clear();
                                                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                                                    const SnackBar(content: Text('Updating debt detail...')),
                                                                                  );
                                                                                  Navigator.pop(context);
                                                                                }
                                                                              },
                                                                              child: const Text('Save Changes')),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                        child: const Text(
                                                          'EDIT',
                                                        ))
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: const Text('Update')),
                                      TextButton(
                                          onPressed: () async {
                                            await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Confirm Delete'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () async {
                                                          Provider.of<LocalProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .deletePrice(
                                                                  item);
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                            const SnackBar(
                                                                content: Text(
                                                                    'Debt deleted')),
                                                          );
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'YES',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.green),
                                                        )),
                                                    TextButton(
                                                        onPressed: () async {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'NO',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .redAccent),
                                                        ))
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: const Text('Delete')),
                                    ],
                                  ),
                                )),
                        ],
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
