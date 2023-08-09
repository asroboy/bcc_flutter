import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/bcc_subheader_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class PengalamanBekerja extends StatefulWidget {
  const PengalamanBekerja({super.key});

  @override
  State<PengalamanBekerja> createState() => _PengalamanBekerjaState();
}

class _PengalamanBekerjaState extends State<PengalamanBekerja> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengalaman Bekerja'),
      ),
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
                  label: 'Tambah Pengalaman Bekerja',
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
