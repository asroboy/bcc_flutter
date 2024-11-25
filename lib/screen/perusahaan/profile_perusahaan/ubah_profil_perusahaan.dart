import 'package:flutter/material.dart';

class UbahProfilPerusahaan extends StatefulWidget {
  const UbahProfilPerusahaan({super.key});

  @override
  State<UbahProfilPerusahaan> createState() => _UbahProfilPerusahaanState();
}

class _UbahProfilPerusahaanState extends State<UbahProfilPerusahaan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Profil Perusahaan'),
      ),
    );
  }
}
