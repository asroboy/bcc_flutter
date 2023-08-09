import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_drop_down.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_search.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
import 'package:bcc/bccwidgets/bcc_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/bcc_subheader_label.dart';
import 'package:flutter/material.dart';

class TambahPendidikan extends StatefulWidget {
  const TambahPendidikan({super.key});

  @override
  State<TambahPendidikan> createState() => _TambahPendidikanState();
}

class _TambahPendidikanState extends State<TambahPendidikan> {
  String? bulan;
  List<String> bulans = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendidikan'),
      ),
      body: ListView(children: [
        Center(
          child: Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Constants.boxColorBlueTrans),
            child: Column(
              children: [
                const BccSubheaderLabel(
                  label: 'Tambah Riwayat Pendidikan',
                ),
                const BccDropdownSearch(
                  hint: 'Sekolah/Perguruan Tinggi',
                ),
                const BccDropdownSearch(
                  hint: 'Tingkat Pendidikan',
                ),
                const Center(
                  child: BccLabel(
                    label: 'Mulai Bulan',
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                  ),
                ),
                BccDropDownString(
                    value: bulan,
                    data: bulans,
                    onChanged: (value) {
                      setState(() {
                        bulan = value;
                      });
                    }),
                const Center(
                  child: BccLabel(
                    label: 'Tahun Mulai',
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                  ),
                ),
                const BccTextFormFieldInput(
                  hint: '-- Tahun --',
                  padding: EdgeInsets.zero,
                ),
                const Center(
                  child: BccLabel(
                    label: 'Mulai Sampai',
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                  ),
                ),
                BccDropDownString(
                    value: bulan,
                    data: bulans,
                    onChanged: (value) {
                      setState(() {
                        bulan = value;
                      });
                    }),
                const Center(
                  child: BccLabel(
                    label: 'Tahun Sampai',
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                  ),
                ),
                const BccTextFormFieldInput(
                  hint: '-- Tahun --',
                  padding: EdgeInsets.zero,
                ),
                const Center(
                  child: BccLabel(
                    label: 'Deskripsi',
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                  ),
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
