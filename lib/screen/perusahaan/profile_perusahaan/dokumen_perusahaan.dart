import 'package:flutter/material.dart';

class DokumenPerusahaan extends StatefulWidget {
  const DokumenPerusahaan({super.key});

  @override
  State<DokumenPerusahaan> createState() => _DokumenPerusahaanState();
}

class _DokumenPerusahaanState extends State<DokumenPerusahaan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dokumen Perusahaan'),
      ),
    );
  }
}
