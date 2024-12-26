import 'package:flutter/material.dart';

class BccTextFormFieldInput extends StatelessWidget {
  const BccTextFormFieldInput(
      {super.key,
      required this.hint,
      this.onChanged,
      this.onTap,
      this.controller,
      this.padding,
      this.radius,
      this.textAlign,
      this.textInputType,
      this.validator,
      this.autofocus,
      this.label,
      this.readOnly = false});

  final Function(String)? onChanged;
  final Function()? onTap;
  final String hint;
  final String? label;
  final bool? autofocus;
  final TextEditingController? controller;
  final EdgeInsets? padding;
  final double? radius;
  final TextAlign? textAlign;
  final TextInputType? textInputType;
  final String? validator;

  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(left: 15, right: 15),
      child: SizedBox(
          child: TextFormField(
        onTap: onTap,
        validator: (value) => validator,
        readOnly: readOnly,
        keyboardType: textInputType ?? TextInputType.emailAddress,
        minLines: textInputType == TextInputType.multiline ? 5 : 1,
        maxLines: textInputType == TextInputType.multiline ? 5 : 1,
        autofocus: autofocus ?? false,
        obscureText:
            textInputType == TextInputType.visiblePassword ? true : false,
        textAlign: textAlign ?? TextAlign.start,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          errorText: validator,
          hintText: hint,
          filled: true,
          labelText: label ?? hint,
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          alignLabelWithHint: true,
          floatingLabelAlignment: FloatingLabelAlignment.start,
          fillColor: readOnly
              ? const Color.fromARGB(255, 229, 238, 243)
              : Colors.white,
          contentPadding: const EdgeInsets.all(10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(radius ?? 10.0),
              borderSide: const BorderSide(width: 0.05)),
        ),
      )),
    );
  }
}
