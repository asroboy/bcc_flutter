import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class TambahLowongan extends StatefulWidget {
  const TambahLowongan({super.key, this.label, this.lowongan});

  final String? label;
  final dynamic lowongan;

  @override
  State<TambahLowongan> createState() => _TambahLowonganState();
}

class _TambahLowonganState extends State<TambahLowongan> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool isLoading = true;
  final ApiHelper _apiHelper = ApiHelper();

  final List<dynamic> _jenisPekerjaan = [];
  final List<String> _jenisPekerjaanString = [];
  dynamic _selectedJenisPekerjaan;
  String? _selectedJenisPekerjaanString;
  bool _isLoadingJenisPekerjaan = true;

  final List<dynamic> _levelPekerjaan = [];
  final List<String> _levelPerkerjaanString = [];
  dynamic _selectedLevelPekerjaan;
  String? _selectedLevelPekerjaanString;
  bool _isLoadingLevelPekerjaan = true;

  final List<dynamic> _provinsi = [];
  final List<String> _provinsiString = [];
  dynamic _selectedProvinsi;
  String? _selectedProvinsiString;
  bool _isLoadingProvinsi = true;

  final List<dynamic> _kabko = [];
  final List<String> _kabkoString = [];
  dynamic _selectedKabko;
  String? _selectedKabkoString;
  bool _isLoadingKabko = false;

  String tanggalString = 'yyyy-MM-dd';
  String tampilGaji = 'Tidak';

  _getJenisPekerjaan() {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getJenisPekerjaan(token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _jenisPekerjaan.addAll(response['data']);
                  for (var jenisPekerjaan in _jenisPekerjaan) {
                    _jenisPekerjaanString.add(jenisPekerjaan['name']);
                  }
                  log('jenis pekerjaan result $response');
                  _isLoadingJenisPekerjaan = false;

                  if (widget.lowongan != null) {
                    _selectedJenisPekerjaanString =
                        widget.lowongan['master_employment_type_name'];
                    _selectedJenisPekerjaan = _jenisPekerjaan.singleWhere(
                        (element) =>
                            element['name'] == _selectedJenisPekerjaanString);
                  }
                });
              });
        }
      },
    );
  }

  _getLevelPekerjaan() {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getLevelPekerjaan(token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _levelPekerjaan.addAll(response['data']);
                  for (var levelPekerjaan in _levelPekerjaan) {
                    _levelPerkerjaanString.add(levelPekerjaan['name']);
                  }
                  log('jenis pekerjaan result $response');
                  _isLoadingLevelPekerjaan = false;

                  if (widget.lowongan != null) {
                    _selectedLevelPekerjaanString =
                        widget.lowongan['master_job_level_name'];
                    _selectedLevelPekerjaan = _levelPekerjaan.singleWhere(
                        (element) =>
                            element['name'] == _selectedLevelPekerjaanString);
                  }
                });
              });
        }
      },
    );
  }

  _getProvinsi() {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getMasterProvinsi(token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _provinsi.addAll(response['data']);
                  for (var provinsi in _provinsi) {
                    _provinsiString.add(provinsi['name']);
                  }
                  log('provinsi result $response');
                  _isLoadingProvinsi = false;

                  if (widget.lowongan != null) {
                    _selectedProvinsiString =
                        widget.lowongan['master_province_name'];
                    _selectedProvinsi = _provinsi.singleWhere((element) =>
                        element['name'] == _selectedProvinsiString);
                    _isLoadingKabko = true;
                    _getKabko(_selectedProvinsi['id']);
                  }
                });
              });
        }
      },
    );
  }

  _getKabko(String provinsiId) {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getMasterKabkoByProvinsi(provinsiId, token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _kabko.addAll(response['data']);
                  for (var kabko in _kabko) {
                    _kabkoString.add(kabko['name']);
                  }
                  // log('kabko result $response');
                  _isLoadingKabko = false;

                  if (widget.lowongan != null) {
                    _selectedKabkoString = widget.lowongan['master_city_name'];
                    _selectedKabko = _kabko.singleWhere(
                        (element) => element['name'] == _selectedKabkoString);
                  }
                });
              });
        }
      },
    );
  }

  // bool _isLoadingSimpan = false;

  _simpanPekerjaan(dynamic body) {
    String token = loginInfo['data']['token'];
    String idPerusahaan = loginInfo['data']['id'];
    _apiPerusahaanCall
        .simpanLowonganPekerjaan(
            requestBody: body, token: token, idPerusahaan: idPerusahaan)
        .then(
      (value) {
        log('simpan result $value');
        if (mounted) {
          Navigator.of(context).pop();
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  Navigator.of(context).pop('OK');
                });
              });
        }
      },
    );
  }

  _updatePekerjaan(dynamic body) {
    String token = loginInfo['data']['token'];
    String lowonganId = widget.lowongan['id'];
    // String idPerusahaan = loginInfo['data']['id'];
    _apiPerusahaanCall
        .updateLowonganPekerjaan(
      requestBody: body,
      token: token,
      lowonganId: lowonganId,
    )
        .then(
      (value) {
        log('update result $value');
        if (mounted) {
          Navigator.of(context).pop();
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  Navigator.of(context).pop('OK');
                });
              });
        }
      },
    );
  }

  TextEditingController judulC = TextEditingController();
  TextEditingController descCont = TextEditingController();

  TextEditingController gajiM = TextEditingController();
  TextEditingController gajiS = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getJenisPekerjaan();
    _getLevelPekerjaan();
    _getProvinsi();
    if (widget.lowongan != null) {
      judulC.text = widget.lowongan == null ? '' : widget.lowongan['title'];
      gajiM.text =
          widget.lowongan == null ? '0' : widget.lowongan['range_salary_from'];
      gajiS.text =
          widget.lowongan == null ? '0' : widget.lowongan['range_salary_to'];
      descCont.text =
          widget.lowongan == null ? '' : widget.lowongan['description'];

      tampilGaji =
          widget.lowongan['is_show_salary'] == '1' ? 'Tampil' : 'Tidak';

      tanggalString = widget.lowongan['vacancies_expired'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(widget.label ?? 'Tambah Lowongan'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              widget.label == null
                  ? 'Input Lowongan Pekerjaan'
                  : 'Ubah Lowongan Pekerjaan',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          BccTextFormFieldInput(
            hint: 'Judul Pekerjaan',
            controller: judulC,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          ),
          BccTextFormFieldInput(
            hint: 'Deskripsi Pekerjaan',
            textInputType: TextInputType.multiline,
            controller: descCont,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          ),
          const BccRowLabel(
            label: 'Jenis Pekerjaan',
            padding: EdgeInsets.only(left: 15),
          ),
          _isLoadingJenisPekerjaan
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: LinearProgressIndicator(),
                )
              : BccDropDownString(
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 5, bottom: 10),
                  data: _jenisPekerjaanString,
                  value: _selectedJenisPekerjaanString,
                  onChanged: (value) {
                    setState(() {
                      if (value == null) return;
                      _selectedJenisPekerjaanString = value;
                      _selectedJenisPekerjaan = _jenisPekerjaan.firstWhere(
                        (element) => element['name'] == value,
                      );
                    });
                  },
                ),
          const BccRowLabel(
            label: 'Level Pekerjaan',
            padding: EdgeInsets.only(left: 15),
          ),
          _isLoadingLevelPekerjaan
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: LinearProgressIndicator(),
                )
              : BccDropDownString(
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 5, bottom: 10),
                  data: _levelPerkerjaanString,
                  value: _selectedLevelPekerjaanString,
                  onChanged: (value) {
                    setState(() {
                      if (value == null) return;
                      _selectedLevelPekerjaanString = value;
                      _selectedLevelPekerjaan = _levelPekerjaan.firstWhere(
                        (element) => (element['name'] == value),
                      );
                    });
                  },
                ),
          const BccRowLabel(
            label: 'Provinsi',
            padding: EdgeInsets.only(left: 15),
          ),
          _isLoadingProvinsi
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: LinearProgressIndicator(),
                )
              : BccDropDownString(
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 5, bottom: 10),
                  data: _provinsiString,
                  value: _selectedProvinsiString,
                  onChanged: (value) {
                    setState(() {
                      if (value == null) return;
                      _selectedProvinsiString = value;
                      _selectedProvinsi = _provinsi.firstWhere(
                        (element) => element['name'] == value,
                      );
                      String provinsiId = _selectedProvinsi['id'];

                      //reset data kabko setelah pilih provinsi
                      _kabko.clear();
                      _kabkoString.clear();
                      _selectedKabkoString = null;
                      _selectedKabko = null;

                      _isLoadingKabko = true;
                      _getKabko(provinsiId);
                    });
                  },
                ),
          const BccRowLabel(
            label: 'Kota/Kabupaten',
            padding: EdgeInsets.only(left: 15),
          ),
          _isLoadingKabko
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: LinearProgressIndicator(),
                )
              : BccDropDownString(
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 5, bottom: 10),
                  data: _kabkoString,
                  value: _selectedKabkoString,
                  onChanged: (value) {
                    setState(() {
                      if (value == null) return;
                      _selectedKabkoString = value;
                      _selectedKabko = _kabko.firstWhere(
                        (element) => element['name'] == value,
                      );
                    });
                  },
                ),
          const BccRowLabel(
            label: 'Tampilkan Gaji',
            padding: EdgeInsets.only(left: 15),
          ),
          BccDropDownString(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
            data: const ['Tidak', 'Ya'],
            value: tampilGaji,
            onChanged: (value) {
              setState(() {
                if (value == null) return;
                tampilGaji = value;
              });
            },
          ),
          tampilGaji == 'Ya'
              ? BccTextFormFieldInput(
                  hint: 'Gaji mulai',
                  textInputType: TextInputType.number,
                  controller: gajiM,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                )
              : const Center(),
          tampilGaji == 'Ya'
              ? BccTextFormFieldInput(
                  hint: 'Gaji sampai',
                  textInputType: TextInputType.number,
                  controller: gajiS,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                )
              : const Center(),
          const BccRowLabel(
            label: 'Tanggal Kadaluarsa',
            padding: EdgeInsets.only(left: 15),
          ),
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
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 5),
                              lastDate: DateTime(DateTime.now().year + 5))
                          .then((value) {
                        setState(() {
                          if (value == null) return;
                          tanggalString =
                              DateFormat('yyyy-MM-dd').format(value);
                        });
                      });
                    },
                    child: const Row(
                      children: [Icon(Icons.calendar_month), Text('Tanggal')],
                    )),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ElevatedButton(
                    onPressed: () {
                      String idPerusahaan = loginInfo['data']['id'];

                      if (judulC.text == '') {
                        showAlertDialog('Harap isi judul pekerjaan', context);
                        return;
                      }
                      if (_selectedJenisPekerjaan == null) {
                        showAlertDialog('Harap pilih jenis pekerjaan', context);
                        return;
                      }
                      if (_selectedLevelPekerjaan == null) {
                        showAlertDialog('Harap pilih level pekerjaan', context);
                        return;
                      }
                      if (_selectedProvinsi == null) {
                        showAlertDialog('Harap pilih provinsi', context);
                        return;
                      }
                      if (_selectedKabko == null) {
                        showAlertDialog('Harap pilih kota', context);
                        return;
                      }
                      if (tanggalString == 'yyyy-MM-dd') {
                        showAlertDialog('Harap isi tanggal expired', context);
                        return;
                      }

                      dynamic body = {
                        'company_id': idPerusahaan,
                        'title': judulC.text,
                        'description': descCont.text,
                        'master_employment_type_id':
                            _selectedJenisPekerjaan['id'],
                        'master_job_level_id': _selectedLevelPekerjaan['id'],
                        'master_province_id': _selectedProvinsi['id'],
                        'master_city_id': _selectedKabko['id'],
                        'is_show_salary': tampilGaji,
                        'range_salary_from': gajiS.text,
                        'range_salary_to': gajiM.text,
                        'created_at': DateTime.now().millisecondsSinceEpoch,
                        'created_by': idPerusahaan,
                      };

                      if (tanggalString != 'yyyy-MM-dd') {
                        body['vacancies_expired'] = tanggalString;
                      }

                      showLoaderDialog(
                          context: context, message: 'Harap tunggu..');

                      if (widget.lowongan != null) {
                        body['updated_at'] =
                            DateTime.now().millisecondsSinceEpoch;
                        _updatePekerjaan(body);
                      } else {
                        _simpanPekerjaan(body);
                      }
                    },
                    child: const Row(
                      children: [Icon(Icons.save), Text('Simpan')],
                    )),
              )
            ],
          )
        ],
      ),
    );
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
}
