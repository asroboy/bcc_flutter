import 'package:bcc/bccwidgets/bcc_text_form_field.dart';
import 'package:flutter/material.dart';

class CariLokasi extends StatelessWidget {
  const CariLokasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 0),
          child: BccTextFormField(
            hint: 'Lokasi',
            radius: 5,
            textAlign: TextAlign.left,
          ),
        ),
        Positioned(
            right: 35,
            child: Center(
                heightFactor: 2.3,
                child: Image.asset('assets/icons/akar_icons_location.png')))
      ],
    );
  }
}
