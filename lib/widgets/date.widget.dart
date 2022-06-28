import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateWidget extends StatelessWidget {
  final DateTime date;

  const DateWidget({
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final f = DateFormat('dd MMMM yyyy, hh:mm a');
    return Center(
        child: Chip(
      backgroundColor: date.difference(DateTime.now()).isNegative
          ? Colors.grey
          : Colors.greenAccent,
      label: Text(f.format(date)),
    ));
  }
}
