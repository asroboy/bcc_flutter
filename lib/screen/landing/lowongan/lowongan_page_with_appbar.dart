import 'package:bcc/screen/landing/lowongan/lowongan_list_screen.dart';
import 'package:flutter/material.dart';

class LowonganPageWithAppBar extends StatelessWidget {
  const LowonganPageWithAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lowongan Kerja'),
      ),
      body: const LowonganListScreen(),
    );
  }
}
