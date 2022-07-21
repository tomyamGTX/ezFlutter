import 'package:analog_clock/analog_clock.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:ez_flutter/providers/local.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/notification.provider.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  var name;
  var date;
  var desc;

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalProvider>(builder: (context, local, _) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Todo List'),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: () async {
                date = null;
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(builder: (context, setState) {
                      var now = DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          DateTime.now().hour,
                          DateTime.now().minute + 2);
                      return AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text('Back')),
                          ElevatedButton(
                              onPressed: () {
                                if (date == null) {
                                  setState(() {
                                    date = now;
                                  });
                                }
                                if (date != null &&
                                    name != null &&
                                    desc != null) {
                                  local.addTaskList({
                                    "name": name,
                                    "desc": desc,
                                    "date": date.toString(),
                                    "value": false,
                                  });
                                  Navigator.pop(context);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Please Fill all fields')));
                                }
                              },
                              child: const Text('Add'))
                        ],
                        title: const Text('ADD TODO LIST'),
                        content: SizedBox(
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Name',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32))),
                                onChanged: (v) {
                                  setState(() {
                                    name = v;
                                  });
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Description',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(32))),
                                onChanged: (v) {
                                  setState(() {
                                    desc = v;
                                  });
                                },
                              ),
                              DateTimePicker(
                                type: DateTimePickerType.dateTimeSeparate,
                                dateMask: 'd MMM, yyyy',
                                initialValue: now.toString(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                icon: const Icon(Icons.event),
                                dateLabelText: 'Date',
                                timeLabelText: "Hour",
                                selectableDayPredicate: (date) {
                                  // Disable weekend days to select from the calendar
                                  if (date.weekday == 6 || date.weekday == 7) {
                                    return false;
                                  }

                                  return true;
                                },
                                onChanged: (val) => setState(() {
                                  date = val;
                                }),
                                validator: (val) {
                                  print(val);
                                  return null;
                                },
                                onSaved: (val) => setState(() {
                                  date = val;
                                }),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  },
                );
              },
              child: const Icon(Icons.add)),
          body: Column(
            children: [
              ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: local.taskList.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = local.taskList[index];
                  return Card(
                    child: ListTile(
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm to delete?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                ElevatedButton(
                                    onPressed: () {
                                      local.deleteTaskList(data);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Yes'))
                              ],
                            );
                          },
                        );
                      },
                      trailing: DateTime.now()
                              .difference(DateTime.parse(data['date']))
                              .isNegative
                          ? Switch(
                              value: data['value'],
                              onChanged: (bool value) {
                                local.updateTaskList(index, data['name'],
                                    data['desc'], data['date'], value);
                                if (value) {
                                  Provider.of<NotificationProvider>(context,
                                          listen: false)
                                      .scheduleNotification(context,
                                          channelDesc:
                                              'Notification for ${data['name']}',
                                          channelName: data['name'],
                                          body:
                                              data['name'] + ' ' + data['desc'],
                                          title: 'Do your task now!',
                                          dateTime:
                                              DateTime.parse(data['date']));
                                }
                              },
                            )
                          : IconButton(
                              onPressed: () {
                                local.deleteTaskList(data);
                              },
                              icon: const Icon(Icons.delete)),
                      leading: GestureDetector(
                        onTap: () async {
                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              var date = DateTime.parse(data['date']);
                              return Scaffold(
                                appBar: AppBar(
                                    title: Text(
                                        ' ${date.hour}:${date.minute}, ${date.day}/${date.month}/${date.year}')),
                                body: Container(
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: AnalogClock(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2.0, color: Colors.black),
                                          color: Colors.transparent,
                                          shape: BoxShape.circle),
                                      isLive: false,
                                      hourHandColor: Colors.black,
                                      minuteHandColor: Colors.black,
                                      showSecondHand: false,
                                      numberColor: Colors.black87,
                                      showNumbers: true,
                                      showAllNumbers: true,
                                      textScaleFactor: 2,
                                      showTicks: true,
                                      showDigitalClock: true,
                                      datetime: DateTime.parse(data['date']),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: AnalogClock(
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 2.0, color: Colors.black),
                              color: Colors.transparent,
                              shape: BoxShape.circle),
                          width: 50.0,
                          isLive: true,
                          hourHandColor: Colors.black,
                          minuteHandColor: Colors.black,
                          showSecondHand: false,
                          numberColor: Colors.black87,
                          showNumbers: true,
                          showAllNumbers: false,
                          textScaleFactor: 2,
                          showTicks: false,
                          showDigitalClock: true,
                          datetime: DateTime.parse(data['date']),
                        ),
                      ),
                      title: Text(data['name']),
                      subtitle: Text(data['desc']),
                    ),
                  );
                },
              ),
            ],
          ));
    });
  }
}
