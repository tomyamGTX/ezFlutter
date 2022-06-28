import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:learning_text_recognition/learning_text_recognition.dart';

class TextBlockList extends StatefulWidget {
  final RecognizedText? textRecognizer;

  const TextBlockList({required this.textRecognizer, Key? key})
      : super(key: key);

  @override
  State<TextBlockList> createState() => _TextBlockListState();
}

class _TextBlockListState extends State<TextBlockList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text Recognition'),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: TabBar(
              tabs: [Tab(text: 'Full text'), Tab(text: 'Text Per Block')],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.all(16),
                    child: Center(child: Text(widget.textRecognizer!.text))),
                ElevatedButton.icon(
                  onPressed: () {
                    FlutterClipboard.copy(widget.textRecognizer!.text).then(
                        (value) => ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Text Copied'))));
                  },
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy text to Clipboard'),
                )
              ],
            ),
            Center(
              child: ListView(
                padding: const EdgeInsets.all(32),
                children: [
                  const Text(
                    'Long Press to copy',
                    textAlign: TextAlign.center,
                  ),
                  if (widget.textRecognizer != null)
                    for (var item in widget.textRecognizer!.blocks)
                      InkWell(
                        onLongPress: () {
                          FlutterClipboard.copy(item.text).then((value) =>
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Text Copied'))));
                        },
                        child: Card(
                          margin: const EdgeInsets.all(8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              item.text,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
