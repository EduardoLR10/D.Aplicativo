import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' show join;
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription> cameras;

Future<void> avaCam() async {
  cameras = await availableCameras();
}

class TakePicture extends StatefulWidget{
  TakePicture({Key key, @required this.camera}) : super(key: key);
  final CameraDescription camera;
  @override
  TakePictureState createState() => TakePictureState();
}

class TakePictureState extends State<TakePicture>{
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
        widget.camera,
        ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
      ),
      floatingActionButton:  FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () async {
          try{
            await _initializeControllerFuture;
            final path = join(
                (await getTemporaryDirectory()).path,
              '${DateTime.now()}.png',
            );
            await _controller.takePicture(path);

            Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => DisplayPictureScreen(imagePath: path),
              ),
            );
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }
}

class DisplayPictureScreen extends StatelessWidget{
  DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the picture'),),
      body: Image.file(File(imagePath)),
    );
  }
}