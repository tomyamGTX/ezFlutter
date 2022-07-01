import 'package:date_time_picker/date_time_picker.dart';
import 'package:ez_flutter/providers/auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';

import 'event.detail.dart';

class EventList extends StatefulWidget {
  final String calendarId;

  EventList({required this.calendarId});

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  final CalendarPlugin _myPlugin = CalendarPlugin();
  var title = 'No title';
  var description = 'No Description';
  DateTime start = DateTime.now();
  DateTime? end;
  var url = '';

  @override
  initState() {
    super.initState();
    _fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Events List'),
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        'Swipe to the left to update event/ swipe to the right to delete event')));
              },
              icon: const Icon(Icons.info))
        ],
      ),
      body: FutureBuilder<List<CalendarEvent>?>(
        future: _fetchEvents(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: Text('No Events found'));
          }
          List<CalendarEvent> events = snapshot.data!;
          events.sort((a, b) => b.startDate!.compareTo(a.startDate!));
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              CalendarEvent event = events.elementAt(index);
              return Dismissible(
                key: Key(event.eventId!),
                confirmDismiss: (direction) async {
                  if (DismissDirection.startToEnd == direction) {
                    setState(() {
                      _deleteEvent(event.eventId!);
                    });

                    return true;
                  } else {
                    setState(() {
                      _updateEvent(event);
                    });

                    return false;
                  }
                },

                // delete option
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20.0),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                // update the event
                secondaryBackground: Container(
                  color: Colors.blue,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20.0),
                  child: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                  title: Text(event.title ?? 'No title'),
                  subtitle: Text(
                      event.startDate != null && event.endDate != null
                          ? DateFormat('dd MMMM yyyy').format(event.startDate!)
                          : 'No Date'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return EventDetails(
                            activeEvent: event,
                            calendarPlugin: _myPlugin,
                          );
                        },
                      ),
                    );
                  },
                  onLongPress: () {
                    _deleteReminder(event.eventId!);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: ListView(
                    children: [
                      TextField(
                        decoration: const InputDecoration(label: Text('Title')),
                        onChanged: (e) {
                          setState(() {
                            title = e;
                          });
                        },
                      ),
                      TextField(
                        decoration:
                            const InputDecoration(label: Text('Description')),
                        onChanged: (e) {
                          setState(() {
                            description = e;
                          });
                        },
                      ),
                      TextField(
                        decoration: const InputDecoration(label: Text('url')),
                        onChanged: (e) {
                          setState(() {
                            url = e;
                          });
                        },
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.dateTime,
                        initialValue: '',
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'Start Date',
                        onChanged: (val) => setState(() {
                          start = DateTime.parse(val);
                        }),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => setState(() {
                          start = DateTime.parse(val!);
                        }),
                      ),
                      DateTimePicker(
                        type: DateTimePickerType.dateTime,
                        initialValue: '',
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                        dateLabelText: 'End Date',
                        onChanged: (val) => setState(() {
                          end = DateTime.parse(val);
                        }),
                        validator: (val) {
                          print(val);
                          return null;
                        },
                        onSaved: (val) => setState(() {
                          end = DateTime.parse(val!);
                        }),
                      )
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                      onPressed: () async {
                        try {
                          setState(() {});
                          _addEvent(title, description, start, end!, url);
                          Navigator.pop(context);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())));
                        }
                      },
                      icon: const Icon(Icons.check))
                ],
              );
            },
          );
        },
        label: Text('Add Event'),
      ),
    );
  }

  Future<List<CalendarEvent>?> _fetchEvents() async {
    return _myPlugin.getEvents(calendarId: widget.calendarId);
    // return _fetchEventsByDateRange();
    // return _myPlugin.getEventsByMonth(
    //     calendarId: this.widget.calendarId,
    //     findDate: DateTime(2020, DateTime.december, 15));
    // return _myPlugin.getEventsByWeek(
    //     calendarId: this.widget.calendarId,
    //     findDate: DateTime(2021, DateTime.june, 1));
  }

  // ignore: unused_element
  Future<List<CalendarEvent>?> _fetchEventsByDateRange() async {
    DateTime endDate =
        DateTime.now().toUtc().add(const Duration(hours: 23, minutes: 59));
    DateTime startDate = endDate.subtract(const Duration(days: 3));
    return _myPlugin.getEventsByDateRange(
      calendarId: widget.calendarId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  void _addEvent(
    String title,
    String description,
    DateTime startDate,
    DateTime endDate,
    String? url,
  ) async {
    var name = AppUser.instance.user!.displayName!;
    var email = AppUser.instance.user!.email!;
    CalendarEvent _newEvent = CalendarEvent(
      title: title,
      description: description,
      startDate: startDate,
      endDate: endDate,
      location: '',
      url: url ?? '',
      attendees: Attendees(attendees: [
        Attendee(
          name: name,
          emailAddress: email,
        ),
      ]),
    );
    await _myPlugin
        .createEvent(calendarId: widget.calendarId, event: _newEvent)
        .then((evenId) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Event Id is: $evenId')));
      });
    });
  }

  void _deleteEvent(String eventId) async {
    _myPlugin
        .deleteEvent(calendarId: widget.calendarId, eventId: eventId)
        .then((isDeleted) {
      debugPrint('Is Event deleted: $isDeleted');
    });
  }

  void _updateEvent(CalendarEvent event) async {
    event.title = 'Updated from Event';
    event.description = 'Test description is updated now';
    event.attendees = Attendees(
      attendees: [
        Attendee(emailAddress: 'updatetest@gmail.com', name: 'Update Test'),
      ],
    );
    _myPlugin
        .updateEvent(calendarId: widget.calendarId, event: event)
        .then((eventId) {
      debugPrint('${event.eventId} is updated to $eventId');
    });

    if (event.hasAlarm!) {
      _updateReminder(event.eventId!, 65);
    } else {
      _addReminder(event.eventId!, -30);
    }
  }

  void _addReminder(String eventId, int minutes) async {
    _myPlugin.addReminder(
        calendarId: widget.calendarId, eventId: eventId, minutes: minutes);
  }

  void _updateReminder(String eventId, int minutes) async {
    _myPlugin.updateReminder(
        calendarId: widget.calendarId, eventId: eventId, minutes: minutes);
  }

  void _deleteReminder(String eventId) async {
    _myPlugin.deleteReminder(eventId: eventId);
  }
}
