import 'package:flutter/material.dart';

class BadanHukumUsaha extends StatefulWidget {
  const BadanHukumUsaha({super.key});

  @override
  State<BadanHukumUsaha> createState() => _BadanHukumUsahaState();
}

class _BadanHukumUsahaState extends State<BadanHukumUsaha> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Badan Hukum Perusahaan'),
      ),
    );
  }
}
