import 'package:flutter/material.dart';

class DetailKandidat extends StatefulWidget {
  const DetailKandidat({super.key});

  @override
  State<DetailKandidat> createState() => _DetailKandidatState();
}

class _DetailKandidatState extends State<DetailKandidat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('Pelamar Kerja'),
      ),
    );
  }
}
