import 'package:flutter/material.dart';

class BccCircleLoadingIndicator extends StatefulWidget {
  const BccCircleLoadingIndicator({super.key});

  @override
  State<BccCircleLoadingIndicator> createState() =>
      _BccCircleLoadingIndicatorState();
}

class _BccCircleLoadingIndicatorState extends State<BccCircleLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
