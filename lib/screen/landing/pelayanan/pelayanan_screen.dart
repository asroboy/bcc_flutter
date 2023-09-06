import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:flutter/material.dart';

class PelayananScreen extends StatefulWidget {
  const PelayananScreen({super.key});

  @override
  State<PelayananScreen> createState() => _PelayananScreenState();
}

class _PelayananScreenState extends State<PelayananScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pelayanan')),
      body: const BccNoDataInfo(),
    );
  }
}
