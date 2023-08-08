import 'package:flutter/widgets.dart';

class BccLabel extends StatelessWidget {
  const BccLabel({super.key, required this.label, this.padding, this.margin});

  final String label;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      child: Text(label),
    );
  }
}
