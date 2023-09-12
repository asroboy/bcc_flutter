import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:flutter/material.dart';

class AntrianOnline extends StatefulWidget {
  const AntrianOnline({super.key});

  @override
  State<AntrianOnline> createState() => _AntrianOnlineState();
}

class _AntrianOnlineState extends State<AntrianOnline> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antrian Online'),
      ),
      body: const BccNoDataInfo(),
    );
  }
}
