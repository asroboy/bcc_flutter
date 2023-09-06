import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:flutter/material.dart';

class InformasiPublik extends StatefulWidget {
  const InformasiPublik({super.key});

  @override
  State<InformasiPublik> createState() => _InformasiPublikState();
}

class _InformasiPublikState extends State<InformasiPublik> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informasi Publik')),
      body: const BccNoDataInfo(),
    );
  }
}
