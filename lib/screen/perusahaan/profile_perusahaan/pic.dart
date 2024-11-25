import 'package:flutter/material.dart';

class Pic extends StatefulWidget {
  const Pic({super.key});

  @override
  State<Pic> createState() => _PicState();
}

class _PicState extends State<Pic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PIC'),
      ),
    );
  }
}
