import 'package:flutter/material.dart';

class InformasiAkunPerusahaan extends StatefulWidget {
  const InformasiAkunPerusahaan({super.key});

  @override
  State<InformasiAkunPerusahaan> createState() =>
      _InformasiAkunPerusahaanState();
}

class _InformasiAkunPerusahaanState extends State<InformasiAkunPerusahaan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun Perusahaan'),
      ),
    );
  }
}
