import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';

class BccButtonCari extends StatelessWidget {
  const BccButtonCari({super.key, this.onPressed, this.child, this.size});
  final Function()? onPressed;
  final Widget? child;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          fixedSize: size ?? const Size(60, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          foregroundColor: Colors.white,
          backgroundColor: Constants.colorBiruGelap),
      child: child,
    );
  }
}
