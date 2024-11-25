import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/bcc_subheader_label.dart';
import 'package:flutter/material.dart';

class UbahBiodata extends StatefulWidget {
  const UbahBiodata({super.key, this.biodataPencaker});

  final dynamic biodataPencaker;

  @override
  State<UbahBiodata> createState() => _UbahBiodataState();
}

class _UbahBiodataState extends State<UbahBiodata> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ktpController = TextEditingController();
  final TextEditingController _notelpController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _tahunLulusController = TextEditingController();

  String? jenisKelamin;
  String? agama;
  String? warganegara;
  String? statusPerkawinan;
  String? statusBekerja;

  List<dynamic> pendidikanTerakhirObj = [];
  List<String> pendidikanTerakhirListString = [];
  dynamic selectedPendidikanTerakhir;
  String? selectedPendidikanTerakhirString;

  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  _fetchPendidikanTerakhir() {
    Future<dynamic> req =
        _apiCall.getDataPendukung(Constants.pathPendidikanTerakhir);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          context: context,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                pendidikanTerakhirObj.addAll(response['data']);
                for (dynamic d in pendidikanTerakhirObj) {
                  pendidikanTerakhirListString.add(d['name']);
                }
              });
            }
          });
    });
  }

  @override
  void initState() {
    _fetchPendidikanTerakhir();

    if (widget.biodataPencaker != null) {
      log('${widget.biodataPencaker}');
      _usernameController.text = widget.biodataPencaker['username'];
      _emailController.text = widget.biodataPencaker['email'];
      _ktpController.text = widget.biodataPencaker['ktp_number'];
      _notelpController.text = widget.biodataPencaker['phone_number'];
      _tempatLahirController.text = widget.biodataPencaker['place_of_birth'];
      _tanggalLahirController.text = widget.biodataPencaker['date_of_birth'];
      _tahunLulusController.text = widget.biodataPencaker['graduation_year'];

      jenisKelamin = widget.biodataPencaker['gender'];
      agama = widget.biodataPencaker['religion'];
      warganegara = widget.biodataPencaker['nationality'];
      statusPerkawinan = widget.biodataPencaker['marital_status'];
      statusBekerja = widget.biodataPencaker['work_status'];
      statusBekerja = widget.biodataPencaker['work_status'];

      selectedPendidikanTerakhirString =
          widget.biodataPencaker['master_degree_name'];

      selectedPendidikanTerakhir = {
        'id': widget.biodataPencaker['master_degree_id'],
        'name': widget.biodataPencaker['master_degree_name']
      };
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Biodata Pencari Kerja')),
      body: ListView(
        children: [
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
                    label: 'INFORMASI BIODATA DIRI',
                  ),
                  BccTextFormFieldInput(
                    hint: 'Username',
                    controller: _usernameController,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Email',
                    controller: _emailController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Nama lengkap',
                    controller: _emailController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'KTP',
                    controller: _ktpController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Nomor Telpon',
                    controller: _notelpController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Tempat Lahir',
                    controller: _tempatLahirController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Tanggal Lahir',
                    controller: _tanggalLahirController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  const BccRowLabel(label: 'Jenis Kelamin'),
                  BccDropDownString(
                    value: jenisKelamin,
                    hint: const Text('Jenis Kelamin'),
                    data: const ['LAKI LAKI', 'PEREMPUAN'],
                    onChanged: (value) {
                      setState(() {
                        jenisKelamin = value;
                      });
                    },
                  ),
                  const BccRowLabel(label: 'Agama'),
                  BccDropDownString(
                    value: agama,
                    hint: const Text('Agama'),
                    data: const [
                      'BUDHA',
                      'HINDU',
                      'ISLAM',
                      'KRISTEN',
                      'KATOLIK',
                      'KATOLIK',
                      'KONGHUCHU',
                      'LAINNYA'
                    ],
                    onChanged: (value) {
                      setState(() {
                        agama = value;
                      });
                    },
                  ),
                  const BccRowLabel(label: 'Kewarganegaraan'),
                  BccDropDownString(
                    value: warganegara,
                    hint: const Text('Kewarganegaraan'),
                    data: const ['WNI', 'WNA'],
                    onChanged: (value) {
                      setState(() {
                        warganegara = value;
                      });
                    },
                  ),
                  const BccRowLabel(label: 'Status Pernikahan'),
                  BccDropDownString(
                    value: statusPerkawinan,
                    hint: const Text('Status Pernikahan'),
                    data: const [
                      'BELUM KAWIN',
                      'KAWIN',
                      'CERAI MATI',
                      'CERAI HIDUP'
                    ],
                    onChanged: (value) {
                      setState(() {
                        warganegara = value;
                      });
                    },
                  ),
                  const BccRowLabel(label: 'Status Bekerja'),
                  BccDropDownString(
                    value: statusBekerja,
                    hint: const Text('Status Bekerja'),
                    data: const [
                      'BELUM BEKERJA',
                      'SUDAH BEKERJA',
                      'SEDANG PELATIHAN'
                    ],
                    onChanged: (value) {
                      setState(() {
                        warganegara = value;
                      });
                    },
                  ),
                  const BccRowLabel(label: 'Pendidikan Terakhir'),
                  BccDropDownString(
                    value: selectedPendidikanTerakhirString,
                    hint: const Text('Pendidikan Terakhir*'),
                    data: pendidikanTerakhirListString,
                    onChanged: (value) {
                      setState(() {
                        selectedPendidikanTerakhirString = value;
                        selectedPendidikanTerakhir = pendidikanTerakhirObj
                            .singleWhere((element) => element['name'] == value);
                      });
                    },
                  ),
                  BccTextFormFieldInput(
                    hint: 'Tahun Lulus',
                    controller: _tahunLulusController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  const BccTextFormFieldInput(
                    hint: 'Tinggi Badan',
                    // controller: _tahunLulusController,
                    padding: EdgeInsets.only(top: 15),
                  ),
                  const BccTextFormFieldInput(
                    hint: 'Berat Badan',
                    // controller: _tahunLulusController,
                    padding: EdgeInsets.only(top: 15),
                  ),
                  const BccTextFormFieldInput(
                    hint: 'No BPJS Kesehatan',
                    // controller: _tahunLulusController,
                    padding: EdgeInsets.only(top: 15),
                  ),
                  const BccTextFormFieldInput(
                    hint: 'No BPJS Ketenaga Kerjaan',
                    // controller: _tahunLulusController,
                    padding: EdgeInsets.only(top: 15),
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
        ],
      ),
    );
  }
}
