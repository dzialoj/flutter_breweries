import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'colors/colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'colors/colors.dart';

class CameraModal extends StatefulWidget {
  final Function imageCallback;
  CameraModal({this.imageCallback});

  @override
  _CameraModalState createState() => _CameraModalState();
}

class _CameraModalState extends State<CameraModal> {
  CameraController controller;
  CameraDescription cameraDescription;
  String filePath;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.initializeCamera();
  }

  Future initializeCamera() async {
    List<CameraDescription> cameras = await availableCameras();
    for (CameraDescription c in cameras) {
      if (c.lensDirection == CameraLensDirection.back) {
        controller = new CameraController(
          c,
          ResolutionPreset.medium,
          enableAudio: false,
        );
      }
    }
    await controller.initialize();
  }

  void takePhoto() async {
    String path = join(
      (await getTemporaryDirectory()).path,
      '${DateTime.now()}.png',
    );
    try {
      await controller.takePicture(path);
      setState(() {
        filePath = path;
      });
    } catch (e) {
      print(e);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initializeCamera(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (filePath == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 9 / 16.0,
                  child: CameraPreview(controller),
                ),
                RaisedButton(
                  onPressed: takePhoto,
                  child: Icon(Icons.camera),
                  color: appColor,
                )
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AspectRatio(
                  aspectRatio: 9 / 16.0,
                  child: Image.file(
                    new File(filePath),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      RaisedButton(
                        onPressed: null,
                        color: appColor,
                        child: Text('Retake'),
                      ),
                      RaisedButton(
                        onPressed: null,
                        color: appColor,
                        child: Text('Use'),
                      )
                    ],
                  ),
                )
              ],
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: appBackgroundColor,
            ),
          );
        }
      },
    );
  }
}
