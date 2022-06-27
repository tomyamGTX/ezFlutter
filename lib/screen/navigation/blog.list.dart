import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ez_flutter/providers/wordpress.provider.dart';
import 'package:ez_flutter/screen/blog/isign.post.dart';
import 'package:ez_flutter/style/text/text.dart';
import 'package:flutter/material.dart';
import 'package:learning_text_recognition/learning_text_recognition.dart';
import 'package:provider/provider.dart';

import '../blog/pintarhub.post.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  RecognizedText? result;
  bool _toogle = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<WordpressProvider>(builder: (context, wp, child) {
      if (wp.postIsign.isEmpty && wp.postPintarHub.isEmpty) {
        return const Scaffold(
          body: Center(child: Text('No Post available')),
        );
      } else if (wp.postIsign.isNotEmpty) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                  onPressed: () => setState(() {
                        _toogle = !_toogle;
                      }),
                  icon: Icon(_toogle ? Icons.toggle_off : Icons.toggle_on)),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      _toogle
                          ? 'Blog Fetch iSign Wordpress'
                          : 'Blog Fetch PintarHub Wordpress',
                      textAlign: TextAlign.center,
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
              _toogle ? const IsignPost() : const PintarHubPost(),
            ],
          ),
        );
      } else {
        return const Center(child: Text('Error'));
      }
    });
  }
}
