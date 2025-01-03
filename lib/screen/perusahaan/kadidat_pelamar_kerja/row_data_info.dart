import 'package:flutter/material.dart';

class RowDataInfo extends StatelessWidget {
  const RowDataInfo(
      {super.key, required this.label, required this.info, this.infoColor});

  final String label;
  final String info;
  final Color? infoColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.25,
          child: Text(label),
        ),
        Flexible(
          child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                info,
                textAlign: TextAlign.end,
                style: TextStyle(color: infoColor ?? Colors.black),
              )),
        )
      ],
    );
  }
}
