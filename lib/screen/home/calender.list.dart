import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

import '../../plugin/calender/clean_calendar_event.dart';
import '../../plugin/calender/flutter_clean_calendar.dart';

class CalendarEvent extends StatefulWidget {
  const CalendarEvent({Key? key}) : super(key: key);

  @override
  State<CalendarEvent> createState() => _CalendarEventState();
}

class _CalendarEventState extends State<CalendarEvent> {
  final Map<DateTime, List<CleanCalendarEvent>> _events = {
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
      CleanCalendarEvent('Event A',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, 12, 0),
          description: 'A special event',
          color: Colors.blue),
    ],
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
        [
      CleanCalendarEvent('Event B',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 10, 0),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 12, 0),
          color: Colors.orange),
      CleanCalendarEvent('Event C',
          startTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 14, 30),
          endTime: DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day + 2, 17, 0),
          color: Colors.pink),
    ],
  };

  final _selectedEvents = [
    CleanCalendarEvent('Event B',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 10, 0),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 12, 0),
        color: Colors.orange),
    CleanCalendarEvent('Event C',
        startTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 14, 30),
        endTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day + 2, 17, 0),
        color: Colors.pink),
  ];

  bool _hijri = false;
  var h_date = HijriCalendar.fromDate(DateTime.now());

  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(_hijri ? 'Date in Hijri' : 'Date in Masihi'),
          actions: [
            IconButton(
                onPressed: () => setState(() {
                      _hijri = !_hijri;
                    }),
                icon: Icon(_hijri ? Icons.toggle_on : Icons.toggle_off))
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Calendar(
                onMonthChanged: (date) {
                  setState(() {});
                  _date = date;
                },
                // dayBuilder: _day,
                events: _events,
                startOnMonday: true,
                weekDays: const [
                  'Isnin',
                  'Selasa',
                  'Rabu',
                  'Khamis',
                  'Jumaat',
                  'Sabtu',
                  'Ahad'
                ],
                onRangeSelected: (range) =>
                    print('Range is ${range.from}, ${range.to}'),
                onDateSelected: (date) {
                  _handleNewDate(date);
                },
                isExpandable: true,
                eventDoneColor: Colors.green,
                selectedColor: Colors.pink,
                todayColor: Colors.blue,
                eventColor: Colors.grey,
                locale: 'ms_MY',
                todayButtonText: _hijri ? 'Hijri' : 'Masihi',
                expandableDateFormat: _hijri ? 'EEEE, ' : 'EEEE, dd MMMM yyyy',
                dayOfWeekStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 11),
                isHijri: _hijri,
              ),
            ),
            // _buildEventList()
          ],
        ),
      ),
    );
  }

  void _handleNewDate(date) {
    var new_h_date = HijriCalendar.fromDate(date);
    setState(() {
      h_date = new_h_date;
    });
    print('Date selected: $date');
  }

  _day(BuildContext context, DateTime date) {
    var h_date = HijriCalendar.fromDate(date);
    var now_h_date = HijriCalendar.fromDate(_date);
    List<DateTime> event = [];
    _events.forEach((key, value) {
      event.add(key);
    });
    if (_hijri) {
      return Text(
        h_date.hDay.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: event.contains(DateTime(
          date.year,
          date.month,
          date.day,
        ))
                ? Colors.red
                : now_h_date.hMonth == h_date.hMonth
                    ? Colors.black
                    : Colors.grey),
      );
    } else {
      return Text(
        date.day.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: event.contains(DateTime(
          date.year,
          date.month,
          date.day,
        ))
                ? Colors.red
                : date.month == _date.month
                    ? Colors.black
                    : Colors.grey),
      );
    }
  }
}
