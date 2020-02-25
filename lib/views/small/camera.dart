import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class TakePicture extends StatefulWidget {
  final String id;

  const TakePicture({
    Key key,
    @required this.id
  }): super(key: key);

  @override
  _TakePictureState createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  CameraController _controller;
  Future<void> _setupFuture;

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();

    _controller = CameraController(
      cameras.first,
      ResolutionPreset.medium
    );

    await _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CAPTURE"), centerTitle: true,),
      body: FutureBuilder(
        future: _setupFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_enhance),
        onPressed: () async {
          try {
            await _setupFuture;

            String path = join((await getApplicationDocumentsDirectory()).path,
                widget.id + ".jpg");

            File file = File(path);
            if (await file.exists()) await file.delete();

            await _controller.takePicture(path);

            Navigator.pop(context);
          } catch (e) {
            print(e);
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _setupFuture = _initializeCamera();
  }
}
