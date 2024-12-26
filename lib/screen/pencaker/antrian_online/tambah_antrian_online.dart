import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
// import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class TambahAntrianOnlie extends StatefulWidget {
  const TambahAntrianOnlie({super.key, required this.userType});

  final UserType userType;

  @override
  State<TambahAntrianOnlie> createState() => _TambahAntrianOnlieState();
}

class _TambahAntrianOnlieState extends State<TambahAntrianOnlie> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool isLoading = true;
  final ApiHelper _apiHelper = ApiHelper();
  bool _isLoadingLayanan = false;
  bool _isLoadingBidang = false;
  final List<String> _layananString = [];
  final List<dynamic> _dataLayanan = [];
  final List<dynamic> _kuotaAntrian = [];
  String? _selectedLayananString;
  dynamic _selectedLayanan;

  final List<String> _bidangString = [];
  final List<dynamic> _dataBidang = [];
  String? _selectedBidangString;
  dynamic _selectedBidang;

  final List<String> _waktuLayanan = [
    '08.00-09.00',
    '09.00-10.00',
    '10.00-11.00',
    '11.00-12.00',
    '12.30-14.00'
  ];
  String? _selectedWaktuLayanan;
  final TextEditingController _descriptionController = TextEditingController();
  String tanggalString =
      'yyyy-MM-dd'; //DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Antrian Online'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BccRowLabel(
                  label: tanggalString,
                  padding: const EdgeInsets.only(left: 35),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.blue[700])),
                      onPressed: () {
                        showDatePicker(
                                context: context,
                                // initialDate: DateTime.now(),
                                firstDate: DateTime.now(),
                                lastDate: DateTime(DateTime.now().year + 5))
                            .then((value) {
                          setState(() {
                            if (value == null) return;
                            tanggalString =
                                DateFormat('yyyy-MM-dd').format(value);
                            _layananString.clear();
                            _dataLayanan.clear();
                            _selectedLayanan = null;

                            _bidangString.clear();
                            _dataBidang.clear();
                            _selectedBidang = null;

                            _cekKuota(tanggalString);
                          });
                        });
                      },
                      child: const Row(
                        children: [Icon(Icons.calendar_month), Text('Tanggal')],
                      )),
                )
              ],
            ),
            const BccRowLabel(
              label: 'Waktu Layanan',
              padding: EdgeInsets.only(left: 15),
            ),
            BccDropDownString(
              margin: const EdgeInsets.only(
                  left: 15, right: 15, top: 5, bottom: 10),
              data: _waktuLayanan,
              value: _selectedWaktuLayanan,
              onChanged: (value) {
                setState(() {
                  _selectedWaktuLayanan = value;
                });
              },
            ),
            const BccRowLabel(
              label: 'Layanan',
              padding: EdgeInsets.only(left: 15),
            ),
            _isLoadingLayanan
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: LinearProgressIndicator(),
                  )
                : BccDropDownString(
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 10),
                    data: _layananString,
                    value: _selectedLayananString,
                    onChanged: (value) {
                      setState(() {
                        _selectedLayananString = value;
                        _selectedLayanan = _dataLayanan
                            .firstWhere((element) => element['name'] == value);
                      });
                    },
                  ),
            const BccRowLabel(
              label: 'Bidang',
              padding: EdgeInsets.only(left: 15),
            ),
            _isLoadingBidang
                ? const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: LinearProgressIndicator(),
                  )
                : BccDropDownString(
                    margin: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 10),
                    data: _bidangString,
                    value: _selectedBidangString,
                    onChanged: (value) {
                      setState(() {
                        _selectedBidangString = value;
                        _selectedBidang = _dataBidang
                            .firstWhere((element) => element['name'] == value);
                      });
                    },
                  ),
            BccTextFormFieldInput(
              hint: 'Keterangan/Catatan/Keperluan',
              textInputType: TextInputType.multiline,
              controller: _descriptionController,
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: ElevatedButton(
                      onPressed: () {
                        // String idPerusahaan = loginInfo['data']['id'];

                        if (tanggalString == 'yyyy-MM-dd') {
                          showAlertDialog('Harap pilih tanggal', context);
                          return;
                        }
                        if (_selectedWaktuLayanan == null) {
                          showAlertDialog('Harap pilih waktu layanan', context);
                          return;
                        }
                        if (_selectedLayananString == null) {
                          showAlertDialog('Harap pilih Layanan', context);
                          return;
                        }
                        if (_selectedBidang == null) {
                          showAlertDialog('Harap pilih Bidang', context);
                          return;
                        }
                        if (_descriptionController.text == '') {
                          showAlertDialog(
                              'Harap isi keterangan/catatan/keperluan Kamu',
                              context);
                          return;
                        }
                        showLoaderDialog(
                            context: context,
                            message: 'Harap tunggu sedang memproses data...');
                        _ambilGeneratedCode();
                      },
                      child: const Row(
                        children: [Icon(Icons.save), Text('Simpan')],
                      )),
                )
              ],
            ),
          ]),
        ));
  }

  showLoaderDialog({required BuildContext context, String? message}) {
    AlertDialog alert = AlertDialog(
      content: SizedBox(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.75,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(message ?? 'Loading...')),
            ],
          ),
        ),
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _cekKuota(String tanggal) {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getKuotaAntrian(token, tanggal).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _kuotaAntrian.addAll(response['data']);

                  if (_kuotaAntrian.isNotEmpty) {
                    _isLoadingLayanan = true;
                    _isLoadingBidang = true;
                    _getLayanan();
                    _getBidang();
                  } else {
                    _isLoadingBidang = false;
                    _isLoadingLayanan = false;
                    showAlertDialog(
                        'Kuota antrian untuk tanggal $tanggal tidak tersedia',
                        context);
                  }
                });
              });
        }
      },
    );
  }

  _getLayanan() {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getMasterQueue(token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _dataLayanan.addAll(response['data']);
                  for (var layanan in _dataLayanan) {
                    _layananString.add(layanan['name']);
                  }

                  _isLoadingLayanan = false;
                });
              });
        }
      },
    );
  }

  _getBidang() {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getMasterRole(token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _dataBidang.addAll(response['data']);
                  for (var bidang in _dataBidang) {
                    _bidangString.add(bidang['name']);
                  }

                  _isLoadingBidang = false;
                });
              });
        }
      },
    );
  }

  _ambilGeneratedCode() {
    String userId = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];

    _apiPerusahaanCall
        .generatedCode(
            token: token, userId: userId, userType: UserType.jobseeker)
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  log('response $response');
                  dynamic generatedCode = response['data'];
                  _simpanAntrian(generatedCode);
                });
              });
        }
      },
    );
  }

  _simpanAntrian(dynamic generatedCode) {
    String userId = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    String type = 'JOBSEEKER';

    dynamic requstBody = {
      'type': type,
      'reff_code': generatedCode['reff_code'],
      'service_code': generatedCode['service_code'],
      'user_id': userId,
      'service_id': _selectedLayanan['id'],
      'counter_id': _selectedBidang['id'],
      'visit_date': tanggalString,
      'service_time': _selectedWaktuLayanan,
      'status': 'SUBMISSION',
      'description': _descriptionController.text,
    };

    _apiPerusahaanCall
        .simpanAntrian(
            token: token, requestBody: requstBody, userType: UserType.jobseeker)
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  log('response $response');
                  Navigator.of(context).pop();
                  _apiHelper.apiCallResponseHandler(
                      response: response, onSuccess: (response) {});
                  showAlertDialogWithAction('Data berhasil disimpan', context,
                      () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop('OK');
                  }, 'OK');
                });
              });
        }
      },
    );
  }
}
