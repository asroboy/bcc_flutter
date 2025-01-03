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
          ? Image.network(
              imageUrl!,
              errorBuilder: (context, error, stackTrace) => const Card(
                margin: EdgeInsets.all(15),
                child: Padding(
                    padding: EdgeInsets.all(15),
                    child: SizedBox(
                      height: 130,
                      child: Column(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 32,
                            color: Colors.red,
                          ),
                          Text('Gagal memuat gambar',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          Text(
                            'Terjadi kendala saat memuat gambar, silahkan coba lagi setelah beberapa saat. Hubungi admin jika kendala masih berlanjut.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )),
              ),
            )
          : Image.file(File(imagePath!)),
    );
  }
}
