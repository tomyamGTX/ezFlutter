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
  Map<DateTime, List<CleanCalendarEvent>> _events = {
    // DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day): [
    //   CleanCalendarEvent('Event A',
    //       startTime: DateTime(DateTime.now().year, DateTime.now().month,
    //           DateTime.now().day, 10, 0),
    //       endTime: DateTime(DateTime.now().year, DateTime.now().month,
    //           DateTime.now().day, 12, 0),
    //       description: 'A special event',
    //       color: Colors.blue),
    // ],
    // DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2):
    //     [
    //   CleanCalendarEvent('Event B',
    //       startTime: DateTime(DateTime.now().year, DateTime.now().month,
    //           DateTime.now().day + 2, 10, 0),
    //       endTime: DateTime(DateTime.now().year, DateTime.now().month,
    //           DateTime.now().day + 2, 12, 0),
    //       color: Colors.orange),
    //   CleanCalendarEvent('Event C',
    //       startTime: DateTime(DateTime.now().year, DateTime.now().month,
    //           DateTime.now().day + 2, 14, 30),
    //       endTime: DateTime(DateTime.now().year, DateTime.now().month,
    //           DateTime.now().day + 2, 17, 0),
    //       color: Colors.pink),
    // ],
  };

  var h_date = HijriCalendar.fromDate(DateTime.now());

  var _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () async {
        //     var event;
        //     await showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return AlertDialog(
        //           title: const Text('Add event'),
        //           content: TextField(
        //             onChanged: (e) {
        //               setState(() {
        //                 event = e;
        //               });
        //             },
        //           ),
        //           actions: [
        //             IconButton(
        //                 onPressed: () {
        //                   Navigator.pop(context);
        //                 },
        //                 icon: const Icon(Icons.close)),
        //             IconButton(
        //                 onPressed: () {
        //                   setState(() {});
        //                   _events = {
        //                     _date: [
        //                       CleanCalendarEvent(event,
        //                           startTime: DateTime(
        //                               DateTime.now().year,
        //                               DateTime.now().month,
        //                               DateTime.now().day,
        //                               10,
        //                               0),
        //                           endTime: DateTime(
        //                               DateTime.now().year,
        //                               DateTime.now().month,
        //                               DateTime.now().day,
        //                               12,
        //                               0),
        //                           description: 'New event',
        //                           color: Colors.blue),
        //                     ]
        //                   };
        //                   Navigator.pop(context);
        //                 },
        //                 icon: const Icon(Icons.check))
        //           ],
        //         );
        //       },
        //     );
        //   },
        // ),
        appBar: AppBar(
          title: const Text('Calendar'),
          actions: [],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Calendar(
                onMonthChanged: (date) {
                  setState(() {});
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
                isExpanded: true,
                isExpandable: true,
                eventDoneColor: Colors.green,
                selectedColor: Colors.pink,
                todayColor: Colors.blue,
                eventColor: Colors.grey,
                locale: 'ms_MY',
                todayButtonText: 'Masihi',
                expandableDateFormat: 'EEEE, dd MMMM yyyy',
                dayOfWeekStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 11),
                isHijri: false,
              ),
            ),
            // _buildEventList()
          ],
        ),
      ),
    );
  }

  Future<void> _handleNewDate(date) async {
    setState(() {
      _date = date;
    });
  }
}
