import 'package:flutter/material.dart';
import 'package:manage_calendar_events/manage_calendar_events.dart';

import '../../providers/auth.provider.dart';

class EventDetails extends StatefulWidget {
  final CalendarEvent activeEvent;
  final CalendarPlugin calendarPlugin;

  const EventDetails({
    required this.activeEvent,
    required this.calendarPlugin,
  });

  @override
  _EventDetailsState createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text('Swipe to the left / right to delete event')));
              },
              icon: const Icon(Icons.info))
        ],
        title: Text(widget.activeEvent.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Description: ${widget.activeEvent.description}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 20),
                  Text('Start Date: ${widget.activeEvent.startDate}'),
                  const SizedBox(height: 20),
                  Text('End Date: ${widget.activeEvent.endDate}'),
                  // SizedBox(height: 20),
                  // Text('Location: ${widget.activeEvent.location}'),
                  const SizedBox(height: 20),
                  Text('URL: ${widget.activeEvent.url}'),
                  const SizedBox(height: 20),
                  Text('All day event: ${widget.activeEvent.isAllDay}'),
                  const SizedBox(height: 20),
                  Text('Has Alarm: ${widget.activeEvent.hasAlarm}'),
                  const SizedBox(height: 20),
                  Text(
                    'Reminder: ${widget.activeEvent.reminder?.minutes}',
                  ),
                ],
              ),
            ),
            buildAttendeeList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          var name = AppUser.instance.user!.displayName!;
          var email = AppUser.instance.user!.email!;
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: TextField(
                  decoration: const InputDecoration(label: Text('Name')),
                  onChanged: (e) {
                    setState(() {
                      name = e;
                    });
                  },
                ),
                content: TextField(
                  decoration: const InputDecoration(label: Text('Email')),
                  onChanged: (e) {
                    setState(() {
                      email = e;
                    });
                  },
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        setState(() {});
                        _addAttendee(widget.activeEvent.eventId!, name, email);
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.check))
                ],
              );
            },
          );
        },
      ),
    );
  }

  buildAttendeeList() {
    return FutureBuilder<List<Attendee>?>(
      future: _getAttendees(widget.activeEvent.eventId!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text('No Attendee found'));
        }
        List<Attendee> attendees = snapshot.data!;
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            Text('Attendees: ${attendees.length}'),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: attendees.length,
              itemBuilder: (context, index) {
                Attendee attendee = attendees.elementAt(index);
                return populateListContent(attendee);
              },
            ),
          ],
        );
      },
    );
  }

  Widget populateListContent(Attendee attendee) {
    return Dismissible(
      key: Key(attendee.emailAddress),
      confirmDismiss: (direction) async {
        setState(() {
          widget.calendarPlugin.deleteAttendee(
            eventId: widget.activeEvent.eventId!,
            attendee: attendee,
          );
        });
        return false;
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
      // other side delete option
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),

      child: ListTile(
        title: Text(attendee.name),
        subtitle: Text(attendee.emailAddress),
        trailing: Text(attendee.isOrganiser ? 'Organiser' : ''),
      ),
    );
  }

  Future<List<Attendee>?> _getAttendees(String eventId) async {
    return await widget.calendarPlugin.getAttendees(eventId: eventId);
  }

  _addAttendee(String eventId, String email, String name) async {
    var newAttendee = Attendee(emailAddress: email, name: name);
    await widget.calendarPlugin
        .addAttendees(eventId: eventId, newAttendees: [newAttendee]);
  }
}
