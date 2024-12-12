import 'package:flutter/material.dart';

class DataPelamarKerja extends StatefulWidget {
  const DataPelamarKerja({super.key, this.lowongan});

  final dynamic lowongan;
  @override
  State<DataPelamarKerja> createState() => _DataPelamarKerjaState();
}

class _DataPelamarKerjaState extends State<DataPelamarKerja> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pelamar'),
      ),
    );
  }
}
