import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:flutter/material.dart';

class PekerjaanDisimpan extends StatefulWidget {
  const PekerjaanDisimpan({super.key});

  @override
  State<PekerjaanDisimpan> createState() => _PekerjaanDisimpanState();
}

class _PekerjaanDisimpanState extends State<PekerjaanDisimpan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pekerjaan Disimpan'),
      ),
      body: const BccNoDataInfo(),
    );
  }
}
