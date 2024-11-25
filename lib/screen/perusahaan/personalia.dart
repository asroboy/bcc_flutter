import 'package:flutter/material.dart';

class Personalia extends StatefulWidget {
  const Personalia({super.key});

  @override
  State<Personalia> createState() => _PersonaliaState();
}

class _PersonaliaState extends State<Personalia> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Personil'),
      ),
    );
  }
}
