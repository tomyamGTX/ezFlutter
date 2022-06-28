import 'package:date_time_picker/date_time_picker.dart';
import 'package:ez_flutter/providers/local.provider.dart';
import 'package:ez_flutter/style/text/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../../providers/notification.provider.dart';
import '../../widgets/date.widget.dart';
import '../../widgets/detail.widget.dart';
import 'notification.screen.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LocalProvider>(builder: (context, local, child) {
      return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                String name = '';
                String desc = '';
                String dateTime = '';
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    var date = DateTime.now();
                    return AlertDialog(
                      title: const Text('Add task'),
                      content: SizedBox(
                        height: 200,
                        child: Column(
                          children: [
                            TextField(
                              decoration:
                                  const InputDecoration(hintText: 'Task Name'),
                              onChanged: (value) {
                                setState(() {
                                  name = value;
                                });
                              },
                            ),
                            TextField(
                              decoration: const InputDecoration(
                                  hintText: 'Task Description'),
                              onChanged: (value) {
                                setState(() {
                                  desc = value;
                                });
                              },
                            ),
                            DateTimePicker(
                              type: DateTimePickerType.dateTime,
                              initialValue: DateTime(
                                      date.year,
                                      date.month,
                                      date.day,
                                      date.hour,
                                      DateTime.now().minute + 10)
                                  .toString(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100),
                              dateLabelText: 'Date',
                              onChanged: (val) {
                                setState(() {});
                                dateTime = val;
                              },
                              validator: (val) {
                                print(val);
                                return null;
                              },
                              onSaved: (val) {
                                setState(() {});
                                dateTime = val!;
                              },
                            )
                          ],
                        ),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              if (name != '' && desc != '') {
                                _addData(
                                    desc: desc,
                                    context: context,
                                    dateTime: dateTime == ''
                                        ? DateTime(
                                            date.year,
                                            date.month,
                                            date.day,
                                            date.hour,
                                            DateTime.now().minute + 10)
                                        : DateTime.parse(dateTime),
                                    name: name);
                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please input all fields')));
                              }
                            },
                            child: const Text('Submit'))
                      ],
                    );
                  },
                );
              },
              label: const Text('Add Task')),
          appBar: AppBar(
            title: const Text('Todo List'),
          ),
          body: Consumer<NotificationProvider>(builder: (context, noti, child) {
            if (local.taskList.isEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Icon(
                    Icons.task,
                    color: Theme.of(context).primaryColor,
                    size: 120,
                  )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No Task Available',
                      style: basicTextStyle(),
                    ),
                  ),
                ],
              );
            }
            if (noti.bodyReceive == null &&
                noti.titleReceive == null &&
                noti.dateTime == null) {
              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 48, horizontal: 8),
                itemCount: local.taskList.length,
                itemBuilder: (BuildContext context, int index) {
                  return TimelineTile(
                    afterLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    beforeLineStyle:
                        LineStyle(color: Theme.of(context).primaryColor),
                    indicatorStyle: IndicatorStyle(
                        color: Theme.of(context).primaryColor, drawGap: true),
                    isFirst: index == 0 ? true : false,
                    isLast: index == local.taskList.length - 1 ? true : false,
                    alignment: TimelineAlign.center,
                    lineXY: 0.3,
                    endChild: index % 2 != 0
                        ? DetailWidget(
                            name: local.taskList[index]['name'],
                            desc: local.taskList[index]['desc'],
                            date: DateTime.parse(local.taskList[index]['date']),
                          )
                        : DateWidget(
                            date: DateTime.parse(local.taskList[index]['date']),
                          ),
                    startChild: index % 2 != 0
                        ? DateWidget(
                            date: DateTime.parse(local.taskList[index]['date']),
                          )
                        : DetailWidget(
                            name: local.taskList[index]['name'],
                            desc: local.taskList[index]['desc'],
                            date: DateTime.parse(local.taskList[index]['date']),
                          ),
                  );
                },
              );
            }
            return const NotificationList();
          }));
    });
  }

  Future<void> _addData(
      {required BuildContext context,
      required String name,
      required String desc,
      required DateTime dateTime}) async {
    final f = DateFormat('dd MMMM yyyy, hh:mm a');
    var date = dateTime.toString();
    Provider.of<LocalProvider>(context, listen: false)
        .addTaskList({"name": name, "desc": desc, "date": date});
    var timebefore = DateTime(dateTime.year, dateTime.month, dateTime.day,
        dateTime.hour, dateTime.minute - 5);
    await Provider.of<NotificationProvider>(context, listen: false)
        .scheduleNotification(
            channelName: name,
            channelDesc: desc,
            title: '5 minutes before due date. Finish your task now!!',
            body: '$name, ${f.format(dateTime)}',
            dateTime: timebefore);
  }
}
