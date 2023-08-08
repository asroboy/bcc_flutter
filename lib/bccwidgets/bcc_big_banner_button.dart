import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';

class BccBigBannerButton extends StatelessWidget {
  const BccBigBannerButton(
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
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Constants.colorBiruGelap,
              image: const DecorationImage(
                image: AssetImage('assets/images/bg_batik.png'),
                fit: BoxFit.cover,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    iconData,
                    color: Colors.white,
                    size: 45,
                  ),
                  const Padding(padding: EdgeInsets.only(right: 5)),
                  Text(
                    label,
                    textAlign: TextAlign.start,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
