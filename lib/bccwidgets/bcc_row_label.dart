import 'package:flutter/material.dart';

class BccRowLabel extends StatelessWidget {
  const BccRowLabel({super.key, required this.label, this.padding});

  final String label;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.only(left: 10, top: 10),
          child: Text(
            label,
            textAlign: TextAlign.start,
          ),
        )
      ],
    );
  }
}
