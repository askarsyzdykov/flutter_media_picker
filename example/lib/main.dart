import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_picker/media_picker.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  List<dynamic> mediaPaths;
  @override
  initState() {
    super.initState();
  }

  pickImages() async {
    try {

      mediaPaths = await MediaPicker.pickImages(withVideo: true);

//      filter only images from mediaPaths and send them to the compressor
//      List<dynamic> listCompressed = await MediasPicker.compressImages(imgPaths: [firstPath], maxWidth: 600, maxHeight: 600, quality: 100);
//      print(listCompressed);

    } on PlatformException {

    }

    if (!mounted)
      return;

    setState(() {
      _platformVersion = mediaPaths.toString();
    });
  }

  pickVideos() async {
    try {
      mediaPaths = await MediaPicker.pickVideos(quantity: 7);
    } on PlatformException {

    }

    if (!mounted)
      return;

    setState(() {
      _platformVersion = mediaPaths.toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Plugin example app'),
        ),
        body: new Center(
          child: new Column(
            children: <Widget>[
              new Text('Running on: $_platformVersion\n'),
              new MaterialButton(
                child: new Text(
                  "Pick images and videos",
                ),
                onPressed: () {
                  pickImages();
                },
              ),
              new MaterialButton(
                child: new Text(
                  "Pick just videos",
                ),
                onPressed: () {
                  pickVideos();
                },
              ),
              new MaterialButton(
                child: new Text(
                  "Delete temp folder (automatic on ios)",
                ),
                onPressed: () async {

                  if (await MediaPicker.deleteAllTempFiles()) {
                    setState(() {
                      _platformVersion = "deleted";
                    });
                  } else {
                    setState(() {
                      _platformVersion = "not deleted";
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
