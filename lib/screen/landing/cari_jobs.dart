import 'package:bcc/bccwidgets/bcc_button_cari.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field.dart';
import 'package:flutter/material.dart';

class CariJobs extends StatelessWidget {
  const CariJobs({super.key, this.controller, this.hint, this.onPressed});

  final TextEditingController? controller;
  final String? hint;
  final dynamic Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 0),
          child: BccTextFormField(
            controller: controller,
            hint: hint ?? '',
            radius: 5,
            textAlign: TextAlign.left,
          ),
        ),
        Positioned(
            right: 20,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              BccButtonCari(
                onPressed: onPressed,
                child: const Text('Cari'),
              )
            ]))
      ],
    );
  }
}
