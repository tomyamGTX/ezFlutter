import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/wordpress.provider.dart';
import 'html.view.dart';

class PintarHubPost extends StatefulWidget {
  const PintarHubPost({
    Key? key,
  }) : super(key: key);

  @override
  State<PintarHubPost> createState() => _PintarHubPostState();
}

class _PintarHubPostState extends State<PintarHubPost> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WordpressProvider>(builder: (context, wp, child) {
      return Flexible(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: wp.postPintarHub.length,
          itemBuilder: (BuildContext context, int index) {
            var data = wp.postPintarHub[index];
            return Card(
              child: ListTile(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HtmlView(
                              url: '',
                              content: data.content!,
                              title: data.title!)));
                },
                title: Text(data.title!),
                subtitle: Text(
                  '\n' +
                      data.excerpt!
                          .replaceAll('<p>', '')
                          .replaceAll('</p>', ''),
                  textAlign: TextAlign.justify,
                ),
                isThreeLine: true,
              ),
            );
          },
        ),
      );
    });
  }
}
