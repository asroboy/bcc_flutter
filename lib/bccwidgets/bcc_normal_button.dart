import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';

class BccNormalButton extends StatelessWidget {
  const BccNormalButton({super.key, this.onPressed, this.size, this.child});

  final Function()? onPressed;
  final Size? size;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: size ?? const Size(150, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          backgroundColor: Constants.colorBiruGelap),
      child: child,
    );
  }
}
