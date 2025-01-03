import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPictureScreen extends StatelessWidget {
  final String? imagePath;
  final String? imageUrl;
  final String? title;

  const DisplayPictureScreen(
      {super.key, this.imagePath, this.imageUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title ?? 'Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: imageUrl != null
          ? Image.network(imageUrl!)
          : Image.file(File(imagePath!)),
    );
  }
}
