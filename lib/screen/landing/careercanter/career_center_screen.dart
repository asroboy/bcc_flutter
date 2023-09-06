import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:flutter/material.dart';

class CareerCenterScreen extends StatefulWidget {
  const CareerCenterScreen({super.key});

  @override
  State<CareerCenterScreen> createState() => _CareerCenterScreenState();
}

class _CareerCenterScreenState extends State<CareerCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Career Center'),
      ),
      body: const BccNoDataInfo(),
    );
  }
}
