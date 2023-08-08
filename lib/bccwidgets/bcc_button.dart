import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';

class BccButton extends StatelessWidget {
  const BccButton(
      {super.key,
      required this.onPressed,
      required this.child,
      this.padding,
      this.size});

  final void Function()? onPressed;
  final Widget? child;
  final EdgeInsets? padding;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding ?? const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                  fixedSize: size ?? const Size(150, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  backgroundColor: Constants.colorBiruGelap),
              child: child,
            )
          ],
        ));
  }
}
