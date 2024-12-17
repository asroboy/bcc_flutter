import 'package:flutter/material.dart';

class BccTextFormField extends StatelessWidget {
  const BccTextFormField(
      {super.key,
      required this.hint,
      this.controller,
      this.padding,
      this.radius,
      this.textAlign,
      this.inputType,
      this.autoFocus});

  final String hint;
  final TextEditingController? controller;
  final EdgeInsets? padding;
  final double? radius;
  final TextAlign? textAlign;
  final TextInputType? inputType;
  final bool? autoFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 15, right: 15),
      child: SizedBox(
          height: 50,
          child: TextFormField(
            keyboardType: inputType ?? TextInputType.text,
            autofocus: autoFocus ?? false,
            textAlign: textAlign ?? TextAlign.center,
            controller: controller,
            obscureText:
                inputType == TextInputType.visiblePassword ? true : false,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(10.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 15.0),
                  borderSide: const BorderSide(width: 0.1)),
            ),
          )),
    );
  }
}
