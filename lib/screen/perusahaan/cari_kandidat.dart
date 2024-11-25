import 'package:flutter/material.dart';

class CariKandidat extends StatefulWidget {
  const CariKandidat({super.key});

  @override
  State<CariKandidat> createState() => _CariKandidatState();
}

class _CariKandidatState extends State<CariKandidat> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Kandidat'),
      ),
    );
  }
}
