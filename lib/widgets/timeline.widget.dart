import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

import '../style/text/text.dart';

class TimelineWidget extends StatelessWidget {
  const TimelineWidget({
    Key? key,
    required this.url,
    required this.color,
    required this.text,
  }) : super(key: key);

  final List<String> url;
  final List<MaterialAccentColor> color;
  final List<String> text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 120),
          child: Text(
            'Planet Evolution',
            style: basicTextStyle(),
          ),
        ),
        for (int i = 0; i < 3; i++)
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.3,
            endChild: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                width: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      url[i],
                    ),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  color: color[i],
                ),
                constraints: const BoxConstraints(
                  minHeight: 120,
                ),
              ),
            ),
            startChild: Center(
                child: Text(
              text[i],
              textAlign: TextAlign.center,
            )),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 160),
          child: Text(
            'End',
            style: basicTextStyle(),
          ),
        ),
      ],
    );
  }
}
