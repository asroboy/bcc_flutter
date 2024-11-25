import 'package:flutter/material.dart';

class DetailLowongan extends StatefulWidget {
  const DetailLowongan({super.key});

  @override
  State<DetailLowongan> createState() => _DetailLowonganState();
}

class _DetailLowonganState extends State<DetailLowongan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lowongan'),
      ),
    );
  }
}
