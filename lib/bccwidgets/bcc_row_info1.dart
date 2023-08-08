import 'package:flutter/material.dart';

class BccRowInfo1 extends StatelessWidget {
  const BccRowInfo1({super.key, required this.assetName, required this.info});

  final String assetName;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(assetName),
        const Padding(padding: EdgeInsets.only(right: 10)),
        Flexible(
            child: Text(
          info,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 14,
            fontFamily: 'Jost',
            fontWeight: FontWeight.normal,
            letterSpacing: -0.10,
          ),
        )),
      ],
    );
  }
}
