import 'package:flutter/material.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';

import 'event.list.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final CalendarPlugin _myPlugin = CalendarPlugin();

  @override
  Widget build(BuildContext context) {
    Widget _futureBuilder = FutureBuilder<List<Calendar>?>(
      future: _fetchCalendars(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }
        List<Calendar> calendars = snapshot.data!;
        calendars.sort(
            (a, b) => a.name!.toLowerCase().compareTo(b.name!.toLowerCase()));
        return ListView.builder(
            itemCount: calendars.length,
            itemBuilder: (context, index) {
              Calendar calendar = calendars[index];
              return Card(
                child: ListTile(
                  title: Text(calendar.name!),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EventList(calendarId: calendar.id!);
                        },
                      ),
                    );
                  },
                ),
              );
            });
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Calender List from Google'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Calendars List',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: _futureBuilder),
          ],
        ),
      ),
    );
  }

  Future<List<Calendar>?> _fetchCalendars() async {
    _myPlugin.hasPermissions().then((value) {
      if (!value!) {
        _myPlugin.requestPermissions();
      }
    });

    return _myPlugin.getCalendars();
  }
}
