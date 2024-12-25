import 'package:flutter/material.dart';

class DetailRiwayatLamaranSaya extends StatefulWidget {
  const DetailRiwayatLamaranSaya({super.key, this.lamaran});

  final dynamic lamaran;

  @override
  State<DetailRiwayatLamaranSaya> createState() =>
      _DetailRiwayatLamaranSayaState();
}

class _DetailRiwayatLamaranSayaState extends State<DetailRiwayatLamaranSaya> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lamaran Saya'),
      ),
    );
  }
}
