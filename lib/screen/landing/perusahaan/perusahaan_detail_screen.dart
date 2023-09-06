import 'package:flutter/material.dart';

class PerusahaanDetailScreen extends StatefulWidget {
  const PerusahaanDetailScreen({super.key});

  @override
  State<PerusahaanDetailScreen> createState() => _PerusahaanDetailScreenState();
}

class _PerusahaanDetailScreenState extends State<PerusahaanDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Perusahaan')),
    );
  }
}
