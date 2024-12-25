import 'dart:async';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_search.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/bcc_subheader_label.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class PengalamanBekerja extends StatefulWidget {
  const PengalamanBekerja({super.key});

  @override
  State<PengalamanBekerja> createState() => _PengalamanBekerjaState();
}

class _PengalamanBekerjaState extends State<PengalamanBekerja> {
  dynamic loginData = GetStorage().read(Constants.loginInfo);

  final TextEditingController _tahunMulaiController = TextEditingController();
  final TextEditingController _tahunSampaiController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _namaPerusahaan = TextEditingController();
  dynamic selectedPerusahaan;

  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  String? bulanMulai;
  String? bulanSampai;
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

  List<String> tipePekerjaan = [];
  List<dynamic> tipePekerjaanObj = [];
  String? selectedTipePekerjaan;
  String? masihBekerjaSampaiSekarang;

  _fetchTipePegawai() {
    Future<dynamic> req =
        _apiCall.getDataPendukung(Constants.pathTipePegawai + ('?type=BCC'));
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          context: context,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                List<dynamic> dataResponse = response['data'];
                tipePekerjaanObj.addAll(dataResponse);
                for (dynamic d in dataResponse) {
                  tipePekerjaan.add(d['name']);
                }
              });
            }
          });
    });
  }

  _fetchDataPerusahaanByName(String filter) {
    String token = loginData['data']['token'];
    var completer = Completer<List<dynamic>>();
    Future<dynamic> req = _apiCall.getDataPendukung(Constants.pathCompany +
        ('?name=') +
        filter +
        ('&limit=20') +
        ('&token=$token'));
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          context: context,
          onSuccess: (response) {
            completer.complete(response['data']);
          });
    });
    return completer.future;
  }

  @override
  void initState() {
    _fetchTipePegawai();
    super.initState();
  }

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
                BccTextFormFieldInput(
                  hint: 'Judul Pekerjaan *',
                  controller: _titleController,
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                ),
                const BccRowLabel(label: 'Perusahaan *'),
                BccDropdownSearch(
                    hint: "Cari Perusahaan",
                    itemAsString: (dynamic u) => u['name'],
                    asyncItems: (String filter) =>
                        _fetchDataPerusahaanByName(filter),
                    onChange: (dynamic data) {
                      setState(() {
                        _namaPerusahaan.text = data['name'];
                        selectedPerusahaan = data;
                      });
                    }),
                BccTextFormFieldInput(
                  hint: 'Nama Perusahaan *',
                  padding: const EdgeInsets.only(bottom: 5, top: 10),
                  controller: _namaPerusahaan,
                ),
                const BccRowLabel(label: 'Jenis Pekerjaan'),
                BccDropDownString(
                    value: selectedTipePekerjaan,
                    data: tipePekerjaan,
                    hint: const Text('Jenis Pekerjaan'),
                    onChanged: (value) {
                      setState(() {
                        selectedTipePekerjaan = value;
                      });
                    }),
                const BccRowLabel(label: 'Masih bekerja sampai sekarang?'),
                BccDropDownString(
                    value: masihBekerjaSampaiSekarang,
                    data: const ['Ya', 'Tidak'],
                    onChanged: (value) {
                      setState(() {
                        masihBekerjaSampaiSekarang = value;
                      });
                    }),
                const BccRowLabel(label: 'Bulan mulai'),
                BccDropDownString(
                    value: bulanMulai,
                    data: bulans,
                    onChanged: (value) {
                      setState(() {
                        bulanMulai = value;
                      });
                    }),
                BccTextFormFieldInput(
                  hint: 'Tahun mulai',
                  padding: const EdgeInsets.only(top: 10),
                  controller: _tahunMulaiController,
                ),
                const BccRowLabel(label: 'Bulan sampai'),
                BccDropDownString(
                    value: bulanSampai,
                    data: bulans,
                    onChanged: (value) {
                      setState(() {
                        bulanSampai = value;
                      });
                    }),
                BccTextFormFieldInput(
                  hint: 'Tahun sampai',
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  controller: _tahunSampaiController,
                ),
                BccTextFormFieldInput(
                  hint: 'Deskripsi',
                  padding: EdgeInsets.zero,
                  controller: _descriptionController,
                  textInputType: TextInputType.multiline,
                ),
                BccButton(
                  onPressed: () {
                    String judulPekerjaan = _titleController.text;
                    String namaPerusahaan = _namaPerusahaan.text;
                    String tahunMulai = _tahunMulaiController.text;
                    String tahunSampai = _tahunSampaiController.text;
                    String deskripsi = _descriptionController.text;

                    if (judulPekerjaan == '') {
                      showAlertDialog('Harap isi judul pekerjaan', context);
                      return;
                    }

                    if (namaPerusahaan == '' && selectedPerusahaan == null) {
                      showAlertDialog(
                          'Harap pilih salah satu perusahaan atau isi nama perusahaan',
                          context);
                      return;
                    }

                    if (selectedTipePekerjaan == null) {
                      showAlertDialog('Harap pilih jenis pekerjaan', context);
                      return;
                    }

                    if (masihBekerjaSampaiSekarang == null) {
                      showAlertDialog(
                          'Pilih dulu opsi "Masih bekerja sampai sekaranr?"',
                          context);
                      return;
                    }

                    if (bulanMulai == null) {
                      showAlertDialog('Pilih bulan mulai', context);
                      return;
                    }
                    if (tahunMulai == '') {
                      showAlertDialog('Pilih tahun mulai', context);
                      return;
                    }

                    if (bulanSampai == null) {
                      showAlertDialog('Pilih bulan samapi', context);
                      return;
                    }
                    if (tahunSampai == '') {
                      showAlertDialog('Pilih tahun sampai', context);
                      return;
                    }

                    // log('data $loginData');
                    String token = loginData['data']['token'];
                    String jobseekerId = loginData['data']['id'];

                    dynamic jenisPekerjaanSelected =
                        tipePekerjaanObj.singleWhere((element) =>
                            element['name'] == selectedTipePekerjaan);

                    var dataPengalamanBekerta = {
                      'title': judulPekerjaan,
                      'master_employment_type_id': jenisPekerjaanSelected['id'],
                      'company_id': selectedPerusahaan != null
                          ? selectedPerusahaan['id']
                          : null,
                      'is_currently_working':
                          masihBekerjaSampaiSekarang == 'Ya' ? '1' : '0',
                      'company_name': namaPerusahaan,
                      'start_month': bulanMulai,
                      'start_year': _tahunMulaiController.text,
                      'end_month': bulanSampai,
                      'end_year': _tahunSampaiController.text,
                      'description': deskripsi,
                      'jobseeker_id': jobseekerId,
                    };

                    showDialog(
                        // The user CANNOT close this dialog  by pressing outsite it
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return const Dialog(
                            // The background color
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // The loading indicator
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // Some text
                                  Text('Loading...')
                                ],
                              ),
                            ),
                          );
                        });

                    _apiCall
                        .simpanPengalamanBekerja(dataPengalamanBekerta, token)
                        .then((value) {
                      if (!mounted) return;
                      Navigator.of(context).pop();

                      _apiHelper.apiCallResponseHandler(
                          response: value,
                          context: context,
                          onSuccess: (response) {
                            Navigator.of(context).pop(response);
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const RegisterComplete()),
                            //   (Route<dynamic> route) => false,
                            // );
                          });
                    });
                  },
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
