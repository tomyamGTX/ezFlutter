import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {
  final String name;
  final String desc;
  final DateTime date;
  const DetailWidget({
    Key? key,
    required this.name,
    required this.desc,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: date.difference(DateTime.now()).isNegative
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColorLight,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                name,
                style: TextStyle(
                    color: !date.difference(DateTime.now()).isNegative
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).primaryColorLight),
              ),
              subtitle: Text(
                desc,
                style: TextStyle(
                    color: !date.difference(DateTime.now()).isNegative
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).primaryColorLight),
              ),
            ),
          )),
    );
  }
}
