import 'dart:io';
import 'dart:typed_data';

import 'package:clipboard/clipboard.dart';
import 'package:ez_flutter/screen/phone.number.screen.dart';
import 'package:ez_flutter/screen/update.name.dart';
import 'package:ez_flutter/style/text/text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_ml_vision/google_ml_vision.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_input_image/learning_input_image.dart';
import 'package:learning_text_recognition/learning_text_recognition.dart';
import 'package:provider/provider.dart';
import 'package:text_to_speech/text_to_speech.dart';

import '../../providers/auth.provider.dart';
import '../../widgets/icon.animation.dart';
import 'debt.list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  var index = 0;
  late AnimationController animationController;
  List<ImageLabel> labels = [];
  var name = ['Add category', 'Display All Category', 'Make Payment'];

  var _visible = true;

  final _icon = [Icons.attach_money, Icons.task, Icons.mic, Icons.camera];
  final _label = [
    'Debt\n List',
    'Todo\n List',
    'Text to Speech',
    'Image Recognition'
  ];

  Uint8List? image_value;

  Uint8List data =
      Uint8List.fromList([102, 111, 114, 116, 121, 45, 116, 119, 111, 0]);

  String? path;

  List<Face> faces = [];

  RecognizedText? result;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..forward()
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<AppUser>(context, listen: false).getName();
    return SafeArea(
        child: Scaffold(
            body: ListView(
      children: [
        if (AppUser.instance.user?.displayName == null)
          Visibility(
            visible: _visible,
            child: InkWell(
              onTap: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const UpdateName())),
              child: ListTile(
                trailing: IconButton(
                  onPressed: () {
                    setState(() {});
                    _visible = !_visible;
                  },
                  icon: const Icon(Icons.clear),
                ),
                title: const Text('Username not set'),
                subtitle: const Text('Click to update now!'),
                tileColor: Colors.yellow[200],
              ),
            ),
          ),
        if (AppUser.instance.user?.phoneNumber == null)
          Visibility(
            visible: _visible,
            child: InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const PhoneNumberScreen())),
              child: ListTile(
                trailing: IconButton(
                  onPressed: () {
                    setState(() {});
                    _visible = !_visible;
                  },
                  icon: const Icon(Icons.clear),
                ),
                title: const Text('Phone Number not set'),
                subtitle: const Text('Click to update now!'),
                tileColor: Colors.yellow[200],
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.all(16),
          child: Text(
            'Date Today ' +
                DateTime.now().day.toString() +
                '/' +
                DateTime.now().month.toString() +
                '/' +
                DateTime.now().year.toString(),
            textAlign: TextAlign.center,
            style: titleTextStyle(),
          ),
        ),
        Container(
          height: 100,
          child: GridView.builder(
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {
                  if (index == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DebtListScreen()));
                  } else if (index == 1) {
                    Fluttertoast.showToast(
                        msg: "Feature not available",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Theme.of(context).primaryColor,
                        textColor: Theme.of(context).primaryColorLight,
                        fontSize: 16.0);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const TodoList()));
                  } else if (index == 2) {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        var value;
                        return AlertDialog(
                          title: const Text('Insert text'),
                          content: TextField(
                            onChanged: (e) {
                              value = e;
                            },
                          ),
                          actions: [
                            IconButton(
                                onPressed: () async {
                                  try {
                                    TextToSpeech tts = TextToSpeech();
                                    tts.speak(value);
                                  } catch (e) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content:
                                                Text('Please insert text')));
                                  }
                                },
                                icon: const Icon(Icons.volume_up)),
                          ],
                        );
                      },
                    );
                  } else {
                    try {
                      await getImageFile();
                    } catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  }
                },
                child: AnimationIcon(
                  icon: _icon[index],
                  index: index,
                  text: _label[index],
                ),
              );
            },
          ),
        ),
        Visibility(
            visible: image_value != null ? true : false,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.memory(
                image_value ?? data,
                height: 100,
              ),
            )),
        if (image_value != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                try {
                  await imageRecognition();
                } catch (e) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(e.toString())));
                }
              },
              label: const Text('Detect Image'),
              icon: const Icon(Icons.search),
            ),
          ),
        Visibility(
          visible: labels.isEmpty ? false : true,
          child: SizedBox(
              height: 120,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    for (var item in labels)
                      Chip(
                        label: Text(
                          item.text ?? 'No data',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        backgroundColor: Theme.of(context).primaryColorLight,
                      )
                  ],
                ),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: AnimatedBuilder(
              animation: animationController,
              builder: (context, child) {
                return Container(
                  padding: EdgeInsets.all(
                    16.0 * animationController.value,
                  ),
                  child: ElevatedButton(
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return InputCameraView(
                                canSwitchMode: false,
                                mode: InputCameraMode.gallery,
                                title: 'Text Recognition',
                                onImage: (InputImage image) async {
                                  TextRecognition textRecognition =
                                      TextRecognition();
                                  RecognizedText? _result =
                                      await textRecognition.process(image);
                                  setState(() {});
                                  result = _result;
                                  Navigator.pop(context);
                                },
                              );
                            });
                      },
                      child: const Text(
                        'Convert Images to Text',
                        textAlign: TextAlign.center,
                      )),
                );
              }),
        ),
        if (result != null)
          const Text(
            'Long press to copy text',
            textAlign: TextAlign.center,
          ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (result != null)
                  for (var item in result!.blocks)
                    InkWell(
                      onLongPress: () {
                        FlutterClipboard.copy(item.text).then((value) =>
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Text Copied'))));
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
        ),
      ],
    )));
  }

  Future<void> getImageFile() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    var value = await pickedFile!.readAsBytes();
    setState(() {
      labels.clear();
      image_value = value;
      path = pickedFile.path;
    });
  }

  Future<void> imageRecognition() async {
    var imageFile = File(path!);
    final GoogleVisionImage visionImage = GoogleVisionImage.fromFile(imageFile);

    final ImageLabeler labeler = GoogleVision.instance.imageLabeler();

    final _labels = await labeler.processImage(visionImage);
    setState(() {
      labels = _labels;
    });
    labeler.close();
  }
}
