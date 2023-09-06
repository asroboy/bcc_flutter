import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:flutter/material.dart';

class PreneurScreen extends StatefulWidget {
  const PreneurScreen({super.key});

  @override
  State<PreneurScreen> createState() => _PreneurScreenState();
}

class _PreneurScreenState extends State<PreneurScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BCC Preneur')),
      body: const BccNoDataInfo(),
    );
  }
}
