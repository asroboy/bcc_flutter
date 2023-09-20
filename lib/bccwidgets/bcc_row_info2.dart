import 'package:flutter/material.dart';

class BccRowInfo2 extends StatelessWidget {
  const BccRowInfo2({super.key, required this.icon, required this.info});

  final Icon? icon;
  final String info;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        icon ?? const Center(),
        const Padding(padding: EdgeInsets.only(right: 10)),
        Flexible(
            child: Text(
          info,
          textAlign: TextAlign.justify,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 12,
            fontFamily: 'Jost',
            fontWeight: FontWeight.normal,
            letterSpacing: -0.10,
          ),
        )),
      ],
    );
  }
}
