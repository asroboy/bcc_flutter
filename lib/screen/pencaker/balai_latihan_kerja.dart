import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:flutter/material.dart';

class BalaiLatihanKerja extends StatefulWidget {
  const BalaiLatihanKerja({super.key});

  @override
  State<BalaiLatihanKerja> createState() => _BalaiLatihanKerjaState();
}

class _BalaiLatihanKerjaState extends State<BalaiLatihanKerja> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Balai Latihan Kerja')),
      body: const BccNoDataInfo(),
    );
  }
}
