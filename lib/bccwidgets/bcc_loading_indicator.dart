import 'package:flutter/material.dart';

class BccLoadingIndicator extends StatelessWidget {
  const BccLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 100),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
