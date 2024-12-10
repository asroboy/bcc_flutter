import 'package:flutter/material.dart';

class HeaderLabel extends StatelessWidget {
  const HeaderLabel({super.key, required this.label, this.padding});

  final String label;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Text(
        label,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );
  }
}
