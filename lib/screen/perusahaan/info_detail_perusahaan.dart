import 'package:flutter/material.dart';

class InfoDetailPerusahaan extends StatefulWidget {
  const InfoDetailPerusahaan({super.key});

  @override
  State<InfoDetailPerusahaan> createState() => _InfoDetailPerusahaanState();
}

class _InfoDetailPerusahaanState extends State<InfoDetailPerusahaan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perusahaan')),
    );
  }
}
