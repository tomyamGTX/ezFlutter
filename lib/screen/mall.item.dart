import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_pickers/image_pickers.dart';
import 'package:provider/provider.dart';

import '../providers/db.provider.dart';
import '../widgets/tile.dart';

class MallItem extends StatefulWidget {
  const MallItem({Key? key}) : super(key: key);

  @override
  State<MallItem> createState() => _MallItemState();
}

class _MallItemState extends State<MallItem> {
  CollectionReference items = FirebaseFirestore.instance.collection('items');

  final _name = TextEditingController();
  final _desc = TextEditingController();
  final _price = TextEditingController();
  final storageRef = FirebaseStorage.instance.ref();

  String? path;

  bool upload = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EZFlutter Products'),
        centerTitle: true,
        actions: [
          ///todo:change visibility if want to add product
          Visibility(
              visible: false,
              child: IconButton(
                  onPressed: () => addItem(), icon: const Icon(Icons.add)))
        ],
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: items.get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          print('read data..');
          if (snapshot.hasError) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return const Center(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('No Item available'),
            ));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            var data = snapshot.data!.docs;
            return StaggeredGrid.count(
              crossAxisCount: 4,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: [
                for (var item in data)
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: item['pic-url'] != 'No Data' ? 2 : 1,
                    child: Tile(
                      index: int.parse(item['price']),
                      bottomSpace: 30,
                      url: item['pic-url'],
                      name: item['name'],
                      paymentUrl: item['link'],
                    ),
                  ),
              ],
            );
          }

          return const Center(
              child: CircularProgressIndicator(
            color: Colors.redAccent,
          ));
        },
      ),
    );
  }

  addItem() async {
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: const Text('Add product'),
            content: SizedBox(
              height: 300,
              width: 400,
              child: ListView(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Name')),
                    controller: _name,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(label: Text('Description')),
                    controller: _desc,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Price')),
                    controller: _price,
                    keyboardType: TextInputType.number,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ElevatedButton(
                        onPressed: path == null
                            ? () async {
                                var pic = await ImagePickers.pickerPaths(
                                    galleryMode: GalleryMode.image,
                                    selectCount: 1,
                                    showGif: false,
                                    showCamera: true,
                                    compressSize: 500,
                                    uiConfig: UIConfig(
                                        uiThemeColor: const Color(0xffff0f50)),
                                    cropConfig: CropConfig(
                                        enableCrop: false,
                                        width: 2,
                                        height: 1));
                                setState(() {
                                  path = pic.first.path;
                                });
                              }
                            : () {
                                ImagePickers.previewImage(path ?? '');
                              },
                        child: Text(
                            path == null ? 'Upload Picture' : 'View Picture')),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      path = null;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  onPressed: () async {
                    if (_name.text.isNotEmpty &&
                        _desc.text.isNotEmpty &&
                        _price.text.isNotEmpty &&
                        path != null) {
                      var url = await uploadImage(context);
                      if (_desc.text.isNotEmpty && _price.text.isNotEmpty) {
                        Provider.of<DB>(context, listen: false)
                            .addItem(_name.text, _desc.text, _price.text, url);
                      }
                      Navigator.pop(context);
                    } else if (_name.text.isNotEmpty &&
                        _desc.text.isNotEmpty &&
                        _price.text.isNotEmpty) {
                      Provider.of<DB>(context, listen: false).addItem(
                          _name.text, _desc.text, _price.text, 'No Data');
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                    }
                  },
                  child: const Text('Add Product'))
            ],
          );
        });
      },
    );
  }

  Future<String> uploadImage(BuildContext context) async {
    final mountainImagesRef = storageRef.child("img/${_name.text}.jpg");
    File file = File(path!);
    var url;
    try {
      await mountainImagesRef.putFile(file);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('upload success')),
      );
      url = mountainImagesRef.getDownloadURL();
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message!)),
      );
      url = 'No Data';
    }
    return url;
  }

  getUrl() {
    if (path != null) {
      final mountainImagesRef = storageRef.child("img/${_name.text}.jpg");
      return mountainImagesRef.getDownloadURL();
    } else {
      return 'No data';
    }
  }
}
