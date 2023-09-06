import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:flutter/material.dart';

class DisnakerScreen extends StatefulWidget {
  const DisnakerScreen({super.key});

  @override
  State<DisnakerScreen> createState() => _DisnakerScreenState();
}

class _DisnakerScreenState extends State<DisnakerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Disnaker'),
      ),
      body: const BccNoDataInfo(),
    );
  }
}
