import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/bcc_subheader_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TambahKeterampilan extends StatefulWidget {
  const TambahKeterampilan({super.key});

  @override
  State<TambahKeterampilan> createState() => _TambahKeterampilanState();
}

class _TambahKeterampilanState extends State<TambahKeterampilan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keterampilan')),
      body: ListView(children: [
        Center(
          child: Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Constants.boxColorBlueTrans),
            child: Column(
              children: [
                const BccSubheaderLabel(
                  label: 'Tambah Keterampilan',
                ),
                const BccTextFormFieldInput(
                  hint: '-- Deskripsi --',
                  padding: EdgeInsets.zero,
                  textInputType: TextInputType.multiline,
                ),
                BccButton(
                  onPressed: () {},
                  padding: const EdgeInsets.only(top: 20),
                  child: const Text('Simpan'),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
