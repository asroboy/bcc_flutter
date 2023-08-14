import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BccLineSparator extends StatelessWidget {
  const BccLineSparator({super.key, this.padding, this.margin});

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      height: 0.5,
      color: Colors.grey,
    );
  }
}
