import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({Key? key}) : super(key: key);

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  File? _image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Future getImage(ImageSource imageSource) async {
      final pickedFile = await picker.getImage(source: imageSource);

      setState(() {
        _image = File(pickedFile.path ?? "");
      });
    }

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              getImage(ImageSource.camera);
            },
            child: const Text(
              'Camera',
              style: TextStyle(fontSize: 25),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              getImage(ImageSource.gallery);
            },
            child: const Text(
              'Gallery',
              style: TextStyle(fontSize: 25),
            ),
          ),
          showImage(),
        ],
      )),
    );
  }

  Widget showImage() {
    if (_image == null) {
      return Container();
    } else {
      return Image.file(_image!);
    }
  }
}
