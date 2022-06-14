import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List list = ['No Task', 'No Task'];
  List date = [
    DateTime.now(),
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              setState(() {});
              list.add('New Task');
              date.add(DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day + 1));
            },
            label: const Text('Add Task')),
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return TimelineTile(
              afterLineStyle: LineStyle(color: Theme.of(context).primaryColor),
              beforeLineStyle: LineStyle(color: Theme.of(context).primaryColor),
              indicatorStyle: IndicatorStyle(
                  color: Theme.of(context).primaryColorDark, drawGap: true),
              isFirst: index == 0 ? true : false,
              isLast: index == list.length - 1 ? true : false,
              hasIndicator: true,
              alignment: TimelineAlign.center,
              lineXY: 0.3,
              endChild: index % 2 != 0
                  ? detailWidget(list: list, index: index)
                  : dateWidget(
                      date: date[index],
                    ),
              startChild: index % 2 != 0
                  ? dateWidget(
                      date: date[index],
                    )
                  : detailWidget(list: list, index: index),
            );
          },
        ));
  }
}

class dateWidget extends StatelessWidget {
  final DateTime date;

  const dateWidget({
    required this.date,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Theme.of(context).secondaryHeaderColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8)),
      child: Center(
          child: Text(
        '${date.day} -' + date.month.toString() + '-' + date.year.toString(),
        textAlign: TextAlign.center,
      )),
    );
  }
}

class detailWidget extends StatelessWidget {
  final int index;

  const detailWidget({
    Key? key,
    required this.index,
    required this.list,
  }) : super(key: key);

  final List list;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).primaryColorLight,
        ),
        constraints: const BoxConstraints(
          minHeight: 50,
        ),
        child: Center(child: Text(list[index])),
      ),
    );
  }
}
