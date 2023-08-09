import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TambahPendidikan extends StatefulWidget {
  const TambahPendidikan({super.key});

  @override
  State<TambahPendidikan> createState() => _TambahPendidikanState();
}

class _TambahPendidikanState extends State<TambahPendidikan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendidikan'),
      ),
    );
  }
}
