import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PengalamanBekerja extends StatefulWidget {
  const PengalamanBekerja({super.key});

  @override
  State<PengalamanBekerja> createState() => _PengalamanBekerjaState();
}

class _PengalamanBekerjaState extends State<PengalamanBekerja> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengalaman Bekerja'),
      ),
    );
  }
}
