import 'package:flutter/material.dart';

class BccNoDataInfo extends StatelessWidget {
  const BccNoDataInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Text('Tidak ada data'),
      ),
    );
  }
}
