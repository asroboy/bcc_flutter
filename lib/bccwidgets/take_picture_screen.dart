import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePhoto extends StatefulWidget {
  // final CameraDescription? camera;
  const TakePhoto({Key? key}) : super(key: key);

  @override
  State<TakePhoto> createState() => _TakePhotoState();
}

class _TakePhotoState extends State<TakePhoto> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  late CameraDescription cameraDescription;

  bool isInit = true;

  @override
  void initState() {
    super.initState();

    availableCameras().then((cameras) {
      final camera = cameras
          .where((camera) => camera.lensDirection == CameraLensDirection.front)
          .toList()
          .first;
      setState(() {
        cameraDescription = camera;
        _controller = CameraController(
          // Get a specific camera from the list of available cameras.
          camera,
          // Define the resolution to use.
          ResolutionPreset.medium,
        );

        // Next, initialize the controller. This returns a Future.
        _initializeControllerFuture = _controller.initialize();
        isInit = false;
      });
    }).catchError((err) {
      log('Terjadi kendala ambil kamera $err');
    });
  }

  Future<XFile?> takePicture() async {
    if (_controller.value.isTakingPicture) {
      return null;
    }

    try {
      XFile file = await _controller.takePicture();
      return file;
    } on CameraException catch (e) {
      log('Error $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          takePicture().then(
            (file) => _exit(file),
          );
        },
        child: const Icon(Icons.camera_alt),
      ),
      body: isInit
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the Future is complete, display the preview.
                  return
                      // Container(
                      //   alignment: Alignment.topCenter,
                      //   decoration: const BoxDecoration(color: Colors.black),
                      //   height: MediaQuery.of(context).size.height,
                      // child:

                      CameraPreview(_controller);
                  // );
                } else {
                  // Otherwise, display a loading indicator.
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
    );
  }

  _exit(XFile? file) {
    Navigator.of(context).pop(file?.path);
  }
}
