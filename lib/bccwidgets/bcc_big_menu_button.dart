import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';

class BccBigMenuButton extends StatelessWidget {
  const BccBigMenuButton(
      {super.key, required this.iconData, required this.label, this.onTap});

  final IconData iconData;
  final String label;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Constants.colorBiruGelap,
              image: const DecorationImage(
                image: AssetImage('assets/images/bg_batik.png'),
                fit: BoxFit.cover,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                iconData,
                color: Colors.white,
                size: 45,
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          )),
    );
  }
}
