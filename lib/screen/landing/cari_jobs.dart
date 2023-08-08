import 'package:bcc/bccwidgets/bcc_button_cari.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field.dart';
import 'package:flutter/material.dart';

class CariJobs extends StatelessWidget {
  const CariJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 0),
          child: BccTextFormField(
            hint: '',
            radius: 5,
            textAlign: TextAlign.left,
          ),
        ),
        Positioned(
            right: 20,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              BccButtonCari(
                onPressed: () {},
                child: const Text('Cari'),
              )
            ]))
      ],
    );
  }
}
