import 'package:flutter/material.dart';

class TambahSertifikat extends StatefulWidget {
  const TambahSertifikat({super.key});

  @override
  State<TambahSertifikat> createState() => _TambahSertifikatState();
}

class _TambahSertifikatState extends State<TambahSertifikat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lisensi & Sertifikat'),
      ),
    );
  }
}
