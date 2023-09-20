import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:flutter/material.dart';

class RiwayatLamaran extends StatefulWidget {
  const RiwayatLamaran({super.key});

  @override
  State<RiwayatLamaran> createState() => _RiwayatLamaranState();
}

class _RiwayatLamaranState extends State<RiwayatLamaran> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Lamaran')),
      body: const BccNoDataInfo(),
    );
  }
}
