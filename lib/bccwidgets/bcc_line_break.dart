import 'package:flutter/material.dart';

class BccLineSparator extends StatelessWidget {
  const BccLineSparator({super.key, this.padding, this.margin});

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: 0.75,
      color: const Color.fromARGB(255, 109, 105, 105),
    );
  }
}
