import 'package:bcc/bccwidgets/bcc_text_form_field.dart';
import 'package:flutter/material.dart';

class CariPerusahaan extends StatelessWidget {
  const CariPerusahaan({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 0),
          child: BccTextFormField(
            hint: 'Nama Perusahaan',
            radius: 5,
            textAlign: TextAlign.left,
          ),
        ),
        Positioned(
            right: 35,
            child: Center(
              heightFactor: 2,
              child: Image.asset('assets/icons/uil_bag_alt.png'),
            ))
      ],
    );
  }
}
