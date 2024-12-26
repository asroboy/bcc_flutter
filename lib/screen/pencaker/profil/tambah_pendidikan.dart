import 'dart:async';
import 'dart:developer';

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

class TambahPendidikan extends StatefulWidget {
  const TambahPendidikan({super.key, this.riwayatPendidikanEdit});

  final dynamic riwayatPendidikanEdit;

  @override
  State<TambahPendidikan> createState() => _TambahPendidikanState();
}

class _TambahPendidikanState extends State<TambahPendidikan> {
  final ApiCall _apiCall = ApiCall();
  late ApiHelper _apiHelper;

  TextEditingController _tahunMulaiController = TextEditingController();
  TextEditingController _tahunSampaiController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final List<dynamic> _sekolah = [];
  List<dynamic> pendidikanTerakhirObj = [];
  List<String> pendidikanTerakhirListString = [];
  dynamic selectedPendidikanTerakhir;
  String? selectedPendidikanTerakhirString;

  _fetchPendidikanTerakhir() {
    Future<dynamic> req =
        _apiCall.getDataPendukung(Constants.pathPendidikanTerakhir);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                pendidikanTerakhirObj.addAll(response['data']);
                for (dynamic d in pendidikanTerakhirObj) {
                  pendidikanTerakhirListString.add(d['name']);
                }

                if (widget.riwayatPendidikanEdit != null) {
                  selectedPendidikanTerakhir =
                      pendidikanTerakhirObj.singleWhere((element) =>
                          element['id'] ==
                          widget.riwayatPendidikanEdit['master_degree_id']);
                  selectedPendidikanTerakhirString =
                      selectedPendidikanTerakhir['name'];
                }
              });
            }
          });
    });
  }

  dynamic selectedSekolahObj;
  String? selectedSekolahString;

  _fetchDataJurusanhByName() {
    Future<dynamic> req =
        _apiCall.getDataPendukung(Constants.pathJurusanSekolah);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            // log('response $response');
            setState(() {
              jurusanObj.addAll(response['data']);
              if (widget.riwayatPendidikanEdit != null) {
                selectedJurusanObj = jurusanObj.singleWhere((element) =>
                    element['id'] ==
                    widget.riwayatPendidikanEdit['master_major_id']);
                selectedJurusan = selectedJurusanObj['name'];
              }
            });
          });
    });
  }

  _fetchDataSekolah(String name) {
    Future<dynamic> req = _apiCall.getDataPendukung(Constants.pathSekolah);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            // log('response $response');
            setState(() {
              _sekolah.addAll(response['data']);

              if (widget.riwayatPendidikanEdit != null) {
                selectedSekolahObj = _sekolah.singleWhere((element) =>
                    element['id'] ==
                    widget.riwayatPendidikanEdit['master_school_id']);
                log('sekolah $selectedSekolahObj');
                selectedSekolahString = selectedSekolahObj['name'];
              }
            });
          });
    });
  }

  // _fetchDataJurusanSekolahByName(String filter) {
  //   var completer = Completer<List<dynamic>>();
  //   Future<dynamic> req = _apiCall
  //       .getDataPendukung(Constants.pathJurusanSekolah + ('?name=') + filter);
  //   req.then((value) {
  //     _apiHelper.apiCallResponseHandler(
  //         response: value,
  //         onSuccess: (response) {
  //           completer.complete(response['data']);
  //         });
  //   });
  //   return completer.future;
  // }

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
    _apiHelper = ApiHelper(buildContext: context);
    _fetchPendidikanTerakhir();
    _fetchDataSekolah('');
    _fetchDataJurusanhByName();

    if (widget.riwayatPendidikanEdit != null) {
      bulanMulai = widget.riwayatPendidikanEdit['start_month'];
      bulanSampai = widget.riwayatPendidikanEdit['end_month'];
      _tahunMulaiController = TextEditingController(
          text: widget.riwayatPendidikanEdit['start_year']);
      _tahunSampaiController =
          TextEditingController(text: widget.riwayatPendidikanEdit['end_year']);

      _descriptionController.text = widget.riwayatPendidikanEdit['description'];
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
                const BccRowLabel(label: 'Sekolah/Perguruan Tinggi *'),
                BccDropdownSearch(
                    items: _sekolah,
                    keyName: 'name',
                    hint: "Sekolah/Perguruan Tinggi *",
                    selectedItem: selectedSekolahObj,
                    itemAsString: (dynamic u) => u['name'],
                    onChange: (data) {
                      log('selected data $data');
                      setState(() {
                        selectedSekolahString = data['name'];
                        selectedSekolahObj = data;
                      });
                    }),
                const BccRowLabel(label: 'Tingkat Pendidikan *'),
                BccDropdownSearch(
                    items: pendidikanTerakhirObj,
                    keyName: 'name',
                    hint: "Tingkat Pendidikan *",
                    selectedItem: selectedPendidikanTerakhir,
                    itemAsString: (dynamic u) => u['name'],
                    onChange: (data) {
                      log('data $data');
                      setState(() {
                        selectedPendidikanTerakhirString = data['name'];
                        selectedPendidikanTerakhir = data;
                      });
                    }),
                const BccRowLabel(label: 'Jurusan *'),
                BccDropdownSearch(
                    items: jurusanObj,
                    keyName: 'name',
                    hint: "Jurusan *",
                    selectedItem: selectedJurusanObj,
                    itemAsString: (dynamic u) => u['name'],
                    onChange: (data) {
                      log('data $data');
                      setState(() {
                        selectedJurusan = data['name'];
                        selectedJurusanObj = data;
                      });
                    }),
                const BccRowLabel(label: 'Bulan mulai *'),
                BccDropDownString(
                    value: bulanMulai,
                    data: bulans,
                    hint: const Text('Bulan mulai *'),
                    onChanged: (value) {
                      setState(() {
                        bulanMulai = value;
                      });
                    }),
                BccTextFormFieldInput(
                  hint: 'Tahun Mulai *',
                  padding: const EdgeInsets.only(top: 10),
                  controller: _tahunMulaiController,
                ),
                const BccRowLabel(label: 'Bulan sampai *'),
                BccDropDownString(
                    value: bulanSampai,
                    data: bulans,
                    hint: const Text('Bulan sampai *'),
                    onChanged: (value) {
                      setState(() {
                        bulanSampai = value;
                      });
                    }),
                BccTextFormFieldInput(
                  hint: 'Tahun Sampai',
                  padding: const EdgeInsets.only(top: 10),
                  controller: _tahunSampaiController,
                ),
                BccTextFormFieldInput(
                  hint: 'Deskripsi',
                  padding: const EdgeInsets.only(top: 15),
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
                    if (widget.riwayatPendidikanEdit != null) {
                      _apiCall
                          .updatePendidikan(dataPendidikanSimpan, token,
                              widget.riwayatPendidikanEdit['id'])
                          .then((value) {
                        _apiHelper.apiCallResponseHandler(
                            response: value,
                            onSuccess: (response) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop(response);
                            });
                      });
                    } else {
                      _apiCall
                          .simpanPendidikan(dataPendidikanSimpan, token)
                          .then((value) {
                        _apiHelper.apiCallResponseHandler(
                            response: value,
                            onSuccess: (response) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop(response);
                            });
                      });
                    }
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
