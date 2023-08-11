import 'dart:async';
import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_search.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
import 'package:bcc/bccwidgets/bcc_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/bcc_subheader_label.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TambahPendidikan extends StatefulWidget {
  const TambahPendidikan({super.key, this.riwayatPendidikanEdit});

  final dynamic riwayatPendidikanEdit;

  @override
  State<TambahPendidikan> createState() => _TambahPendidikanState();
}

class _TambahPendidikanState extends State<TambahPendidikan> {
  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  TextEditingController _tahunMulaiController = TextEditingController();
  TextEditingController _tahunSampaiController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<dynamic> pendidikanTerakhirObj = [];
  List<String> pendidikanTerakhirListString = [];
  dynamic selectedPendidikanTerakhir;
  String? selectedPendidikanTerakhirString;

  _fetchPendidikanTerakhir() {
    Future<dynamic> req =
        _apiCall.getDataPendukung(Constants.pathPendidikanTerakhir);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(value, context, (response) {
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

  dynamic selectedSekolahObj;
  String? selectedSekolahString;

  Future<List<dynamic>> _fetchDataSekolahByName(String name) {
    var completer = Completer<List<dynamic>>();

    Future<dynamic> req =
        _apiCall.getDataPendukung(Constants.pathSekolah + ('?name=') + name);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(value, context, (response) {
        completer.complete(response['data']);
      });
    });

    return completer.future;
  }

  _fetchDataJurusanSekolahByName(String filter) {
    var completer = Completer<List<dynamic>>();
    Future<dynamic> req = _apiCall
        .getDataPendukung(Constants.pathJurusanSekolah + ('?name=') + filter);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(value, context, (response) {
        completer.complete(response['data']);
      });
    });
    return completer.future;
  }

  List<dynamic> jurusanObj = [];
  List<String> jurusanListString = [];
  dynamic selectedJurusanObj;
  String? selectedJurusan;

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

  @override
  void initState() {
    _fetchPendidikanTerakhir();

    if (widget.riwayatPendidikanEdit != null) {
      _tahunMulaiController = TextEditingController(
          text: widget.riwayatPendidikanEdit['start_year']);
      _tahunSampaiController =
          TextEditingController(text: widget.riwayatPendidikanEdit['end_year']);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendidikan'),
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
                  label: 'Tambah Riwayat Pendidikan',
                ),
                BccDropdownSearch(
                    hint: "Sekolah/Perguruan Tinggi *",
                    itemAsString: (dynamic u) => u['name'],
                    asyncItems: (String filter) =>
                        _fetchDataSekolahByName(filter),
                    onChange: (dynamic data) {
                      setState(() {
                        selectedSekolahString = data['name'];
                        selectedSekolahObj = data;
                      });
                    }),
                BccDropDownString(
                  value: selectedPendidikanTerakhirString,
                  hint: const Text('Tingkat Pendidikan *'),
                  data: pendidikanTerakhirListString,
                  onChanged: (value) {
                    setState(() {
                      selectedPendidikanTerakhirString = value;
                      selectedPendidikanTerakhir = pendidikanTerakhirObj
                          .singleWhere((element) => element['name'] == value);
                    });
                  },
                ),
                BccDropdownSearch(
                    hint: "Jurusan *",
                    itemAsString: (dynamic u) => u['name'],
                    asyncItems: (String filter) =>
                        _fetchDataJurusanSekolahByName(filter),
                    onChange: (dynamic data) {
                      setState(() {
                        selectedJurusan = data['name'];
                        selectedJurusanObj = data;
                      });
                    }),
                const Center(
                  child: BccLabel(
                    label: 'Mulai Bulan',
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                  ),
                ),
                BccDropDownString(
                    value: bulanMulai,
                    data: bulans,
                    onChanged: (value) {
                      setState(() {
                        bulanMulai = value;
                      });
                    }),
                const Center(
                  child: BccLabel(
                    label: 'Tahun Mulai',
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                  ),
                ),
                BccTextFormFieldInput(
                  hint: '-- Tahun --',
                  padding: EdgeInsets.zero,
                  controller: _tahunMulaiController,
                ),
                const Center(
                  child: BccLabel(
                    label: 'Mulai Sampai',
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                  ),
                ),
                BccDropDownString(
                    value: bulanSampai,
                    data: bulans,
                    onChanged: (value) {
                      setState(() {
                        bulanSampai = value;
                      });
                    }),
                const Center(
                  child: BccLabel(
                    label: 'Tahun Sampai',
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                  ),
                ),
                BccTextFormFieldInput(
                  hint: '-- Tahun --',
                  padding: EdgeInsets.zero,
                  controller: _tahunSampaiController,
                ),
                const Center(
                  child: BccLabel(
                    label: 'Deskripsi',
                    margin: EdgeInsets.only(top: 10, bottom: 5),
                  ),
                ),
                BccTextFormFieldInput(
                  hint: '-- Deskripsi --',
                  padding: EdgeInsets.zero,
                  controller: _descriptionController,
                  textInputType: TextInputType.multiline,
                ),
                BccButton(
                  onPressed: () {
                    if (selectedSekolahObj == null) {
                      showAlertDialog('Harap pilih sekolah', context);
                      return;
                    }

                    if (selectedPendidikanTerakhir == null) {
                      showAlertDialog(
                          'Harap pilih tingkat pendidikan', context);
                      return;
                    }
                    if (selectedJurusanObj == null) {
                      showAlertDialog('Harap pilih jurusan', context);
                      return;
                    }

                    if (bulanMulai == null) {
                      showAlertDialog('Harap pilih bulan mulai', context);
                      return;
                    }

                    if (_tahunMulaiController.text == '') {
                      showAlertDialog('Harap pilih tahun mulai', context);
                      return;
                    }

                    if (bulanSampai == null) {
                      showAlertDialog('Harap pilih bulan sampai', context);
                      return;
                    }

                    if (_tahunSampaiController.text == '') {
                      showAlertDialog('Harap pilih tahun sampai', context);
                      return;
                    }

                    dynamic loginData = GetStorage().read(Constants.loginInfo);
                    // log('data $loginData');
                    String token = loginData['data']['token'];
                    String jobseekerId = loginData['data']['id'];

                    var dataPendidikanSimpan = {
                      'master_school_id': selectedSekolahObj['id'],
                      'master_degree_id': selectedPendidikanTerakhir['id'],
                      'master_major_id': selectedJurusanObj['id'],
                      'start_month': bulanMulai,
                      'start_year': _tahunMulaiController.text,
                      'end_month': bulanSampai,
                      'end_year': _tahunSampaiController.text,
                      'description': _descriptionController.text,
                      'jobseeker_id': jobseekerId,
                    };

                    showDialog(
                        // The user CANNOT close this dialog  by pressing outsite it
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return Dialog(
                            // The background color
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
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
                        .simpanPendidikan(dataPendidikanSimpan, token)
                        .then((value) {
                      if (!mounted) return;
                      Navigator.of(context).pop();

                      _apiHelper.apiCallResponseHandler(value, context,
                          (response) {
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
