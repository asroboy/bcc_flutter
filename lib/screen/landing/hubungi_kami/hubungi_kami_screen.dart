import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:flutter/material.dart';

class HubungiKamiScreen extends StatefulWidget {
  const HubungiKamiScreen({super.key});

  @override
  State<HubungiKamiScreen> createState() => _HubungiKamiScreenState();
}

class _HubungiKamiScreenState extends State<HubungiKamiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hubungi Kami'),
      ),
      body: const BccNoDataInfo(),
    );
  }
}
