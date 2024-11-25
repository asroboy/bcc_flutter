import 'package:flutter/material.dart';

class TambahLowongan extends StatefulWidget {
  const TambahLowongan({super.key});

  @override
  State<TambahLowongan> createState() => _TambahLowonganState();
}

class _TambahLowonganState extends State<TambahLowongan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Tambah Lowongan'),
      ),
    );
  }
}
