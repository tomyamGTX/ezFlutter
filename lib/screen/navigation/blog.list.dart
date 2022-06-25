import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ez_flutter/providers/wordpress.provider.dart';
import 'package:ez_flutter/style/text/text.dart';
import 'package:flutter/material.dart';
import 'package:learning_text_recognition/learning_text_recognition.dart';
import 'package:provider/provider.dart';

import '../blog/html.view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  RecognizedText? result;

  @override
  Widget build(BuildContext context) {
    return Consumer<WordpressProvider>(builder: (context, wp, child) {
      if (wp.post.isEmpty) {
        return const Scaffold(
          body: Center(child: Text('No Post available')),
        );
      } else {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Blog Fetch Wordpress',
                      textAlign: TextAlign.start,
                      textStyle: titleTextStyle(),
                      speed: const Duration(milliseconds: 200),
                    ),
                  ],
                  totalRepeatCount: 4,
                  pause: const Duration(milliseconds: 500),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                ),
              ),
              Flexible(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: wp.post.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = wp.post[index];
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
              ),
            ],
          ),
        );
      }
    });
  }
}