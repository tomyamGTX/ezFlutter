import 'package:ez_flutter/providers/notification.provider.dart';
import 'package:ez_flutter/style/text/text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({Key? key}) : super(key: key);

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(builder: (context, noti, child) {
      final f = DateFormat('dd MMMM yyyy, hh:mm a');
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Notification receive at ' + f.format(noti.dateTime!),
            textAlign: TextAlign.center,
            style: titleTextStyle(),
          ),
          AlertDialog(
            title: Text(noti.titleReceive!),
            content: Text(noti.bodyReceive!),
            actions: [
              ElevatedButton.icon(
                onPressed: () {
                  var dateTime = DateTime.now();
                  var afterFiveMin = DateTime(dateTime.year, dateTime.month,
                      dateTime.day, dateTime.hour, dateTime.minute + 5);
                  Provider.of<NotificationProvider>(context, listen: false)
                      .scheduleNotification(
                          channelName: noti.titleReceive!,
                          channelDesc: noti.bodyReceive!,
                          title:
                              '5 minutes before due date. Finish your task now!!',
                          body:
                              '${noti.titleReceive!}, ${f.format(afterFiveMin)}',
                          dateTime: afterFiveMin);
                },
                icon: const Icon(Icons.snooze),
                label: const Text('Snooze 5 minutes'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Provider.of<NotificationProvider>(context, listen: false)
                      .receiveNotification();
                },
                icon: const Icon(Icons.check),
                label: const Text('Mark As Done'),
              )
            ],
          ),
        ],
      );
    });
  }
}
