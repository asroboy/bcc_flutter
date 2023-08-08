import 'package:flutter/material.dart';

class BccTextFormFieldInput extends StatelessWidget {
  const BccTextFormFieldInput(
      {super.key,
      required this.hint,
      this.controller,
      this.padding,
      this.radius,
      this.textAlign,
      this.textInputType,
      this.readOnly = false});

  final String hint;
  final TextEditingController? controller;
  final EdgeInsets? padding;
  final double? radius;
  final TextAlign? textAlign;
  final TextInputType? textInputType;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 15, right: 15),
      child: SizedBox(
          height: 50,
          child: TextFormField(
            readOnly: readOnly,
            keyboardType: textInputType ?? TextInputType.emailAddress,
            autofocus: false,
            obscureText:
                textInputType == TextInputType.visiblePassword ? true : false,
            textAlign: textAlign ?? TextAlign.center,
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(10.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius ?? 10.0),
                  borderSide: const BorderSide(width: 0.05)),
            ),
          )),
    );
  }
}
