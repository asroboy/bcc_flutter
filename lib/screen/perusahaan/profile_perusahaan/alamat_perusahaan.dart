import 'package:flutter/material.dart';

class AlamatPerusahaan extends StatefulWidget {
  const AlamatPerusahaan({super.key});

  @override
  State<AlamatPerusahaan> createState() => _AlamatPerusahaanState();
}

class _AlamatPerusahaanState extends State<AlamatPerusahaan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Alamat Perusahaan'),
      ),
    );
  }
}
