import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/wordpress.provider.dart';
import 'html.view.dart';

class IsignPost extends StatefulWidget {
  const IsignPost({
    Key? key,
  }) : super(key: key);

  @override
  State<IsignPost> createState() => _IsignPostState();
}

class _IsignPostState extends State<IsignPost> {
  @override
  Widget build(BuildContext context) {
    return Consumer<WordpressProvider>(builder: (context, wp, child) {
      return Flexible(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: wp.postIsign.length,
          itemBuilder: (BuildContext context, int index) {
            var data = wp.postIsign[index];
            var image = wp.url[index].imageUrl;
            var video = wp.url[index].videoUrl;
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(image),
                ),
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HtmlView(
                              url: video,
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
