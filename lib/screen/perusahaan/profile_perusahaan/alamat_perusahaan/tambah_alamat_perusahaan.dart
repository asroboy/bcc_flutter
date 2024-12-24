import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TambahAlamatPerusahaan extends StatefulWidget {
  const TambahAlamatPerusahaan({super.key, this.alamat});

  final dynamic alamat;

  @override
  State<TambahAlamatPerusahaan> createState() => _TambahAlamatPerusahaanState();
}

class _TambahAlamatPerusahaanState extends State<TambahAlamatPerusahaan> {
  // final TextEditingController _judulController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);
  final ApiHelper _apiHelper = ApiHelper();
  final ApiCall _apiCall = ApiCall();

  List<String> jenisKantor = ['KANTOR PUSAT', 'KANTOR CABANG'];
  String? _selectedJenisKantor;

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
  bool _isLoadingKecamatan = false;
  bool _isLoadingDesa = false;

  List<dynamic> kecamatanObj = [];
  List<dynamic> desaObj = [];
  List<String> kecamatanListString = [];
  List<String> desaListString = [];
  String? selectedKecamatanString;
  String? selectedDesaString;
  dynamic selectedKecamatan;
  dynamic selectedDesa;

  // bool? _alamatUtama;

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

                  if (widget.alamat != null) {
                    _selectedProvinsi = _provinsi.singleWhere((element) =>
                        element['id'] == widget.alamat['master_province_id']);
                    _selectedProvinsiString = _selectedProvinsi['name'];
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

                  if (widget.alamat != null) {
                    _selectedKabko = _kabko.singleWhere((element) =>
                        element['id'] == widget.alamat['master_city_id']);
                    _selectedKabkoString = _selectedKabko['name'];
                    _isLoadingKecamatan = true;
                    _fetchDataKecamatan(_selectedKabko['id']);
                  }
                });
              });
        }
      },
    );
  }

  _fetchDataKecamatan(String idKota) {
    Future<dynamic> req = _apiCall.getDataPendukung(
        Constants.pathKecamatan + ('?master_city_id=') + idKota);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          context: mounted ? context : null,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                _isLoadingKecamatan = false;
                kecamatanObj.addAll(response['data']);
                for (dynamic kecamatan in kecamatanObj) {
                  kecamatanListString.add(kecamatan['name']);
                }
              });

              if (widget.alamat != null) {
                selectedKecamatan = kecamatanObj.singleWhere((element) =>
                    element['id'] == widget.alamat['master_district_id']);
                selectedKecamatanString = selectedKecamatan['name'];
                _isLoadingDesa = true;
                _fetchDataDesa(selectedKecamatan['id']);
              }
            }
          });
    });
  }

  _fetchDataDesa(String idKecamatan) {
    Future<dynamic> req = _apiCall.getDataPendukung(
        Constants.pathDesa + ('?master_district_id=') + idKecamatan);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          context: mounted ? context : null,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                _isLoadingDesa = false;
                desaObj.addAll(response['data']);
                for (dynamic desa in desaObj) {
                  desaListString.add(desa['name']);
                }
              });

              if (widget.alamat != null) {
                selectedDesa = desaObj.singleWhere((element) =>
                    element['id'] == widget.alamat['master_village_id']);
                selectedDesaString = selectedDesa['name'];
              }
            }
          });
    });
  }

  // _resetKota() {
  //   _resetKecamatan();
  //   setState(() {
  //     _kabko.clear();
  //     _selectedKabko = null;
  //     _selectedKabkoString = null;
  //     _kabkoString.clear();
  //   });
  // }

  _resetKecamatan() {
    _resetDesa();
    setState(() {
      kecamatanObj.clear();
      selectedKecamatan = null;
      selectedKecamatanString = null;
      kecamatanListString.clear();
    });
  }

  _resetDesa() {
    setState(() {
      desaObj.clear();
      selectedDesa = null;
      selectedDesaString = null;
      desaListString.clear();
    });
  }

  @override
  void initState() {
    _getProvinsi();
    super.initState();

    if (widget.alamat != null) {
      // _alamatUtama = widget.alamat['is_primary'] == '1';
      _selectedJenisKantor = widget.alamat['title'];
      _alamatController.text = widget.alamat['address'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Alamat Perusahaan'),
        ),
        body: Card(
          margin: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const Padding(padding: EdgeInsets.only(top: 15)),
              const BccRowLabel(
                label: 'Status Alamat*',
                padding: EdgeInsets.only(left: 15),
              ),
              BccDropDownString(
                margin: const EdgeInsets.only(
                    left: 15, right: 15, top: 5, bottom: 10),
                data: jenisKantor,
                value: _selectedJenisKantor,
                onChanged: (value) {
                  setState(() {
                    _selectedJenisKantor = value;
                  });
                },
              ),
              BccTextFormFieldInput(
                hint: 'Alamat*',
                controller: _alamatController,
                textInputType: TextInputType.multiline,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              ),
              const BccRowLabel(
                label: 'Provinsi*',
                padding: EdgeInsets.only(left: 15),
              ),
              _isLoadingProvinsi
                  ? const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                label: 'Kota/Kabupaten*',
                padding: EdgeInsets.only(left: 15),
              ),
              _isLoadingKabko
                  ? const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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

                          _resetKecamatan();
                          _fetchDataKecamatan(_selectedKabko['id']);
                        });
                      },
                    ),
              const BccRowLabel(
                label: 'Kecamatan*',
                padding: EdgeInsets.only(left: 15),
              ),
              _isLoadingKecamatan
                  ? const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: LinearProgressIndicator(),
                    )
                  : BccDropDownString(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 10),
                      value: selectedKecamatanString,
                      hint: const Text('Kecamatan'),
                      data: kecamatanListString,
                      onChanged: (value) {
                        setState(() {
                          selectedKecamatanString = value;
                          selectedKecamatan = kecamatanObj.singleWhere(
                              (element) => element['name'] == value);

                          if (selectedKecamatan != null) {
                            _resetDesa();
                            _fetchDataDesa(selectedKecamatan['id']);
                          }
                        });
                      },
                    ),
              const BccRowLabel(
                label: 'Desa*',
                padding: EdgeInsets.only(left: 15),
              ),
              _isLoadingDesa
                  ? const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: LinearProgressIndicator(),
                    )
                  : BccDropDownString(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, top: 5, bottom: 10),
                      value: selectedDesaString,
                      hint: const Text('Desa'),
                      data: desaListString,
                      onChanged: (value) {
                        setState(() {
                          selectedDesaString = value;
                          selectedDesa = desaObj.singleWhere(
                              (element) => element['name'] == value);
                        });
                      },
                    ),
              // Row(
              //   children: [
              //     Checkbox(
              //         value: _alamatUtama,
              //         onChanged: (value) {
              //           setState(() {
              //             _alamatUtama = value;
              //           });
              //         }),
              //     const Padding(
              //       padding: EdgeInsets.only(right: 10),
              //       child: Text('Alamat utama'),
              //     )
              //   ],
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_selectedJenisKantor == null) {
                            showAlertDialog(
                                'Harap pilih jenis kantor', context);
                            return;
                          }

                          if (_selectedProvinsi == null) {
                            showAlertDialog('Harap pilih provinsi', context);
                            return;
                          }
                          if (_selectedKabko == null) {
                            showAlertDialog(
                                'Harap pilih kota/kabupaten', context);
                            return;
                          }
                          if (selectedKecamatan == null) {
                            showAlertDialog('Harap pilih kecamatan', context);
                            return;
                          }
                          if (selectedDesa == null) {
                            showAlertDialog('Harap pilih desa', context);
                            return;
                          }
                          if (_alamatController.text == '') {
                            showAlertDialog('Harap isi alamat', context);
                            return;
                          }

                          showLoaderDialog(
                              context: context, message: 'Harap tunggu..');
                          String idPerusahaan = loginInfo['data']['id'];

                          dynamic alamatPerusahaan = {
                            'company_id': idPerusahaan,
                            'title': _selectedJenisKantor,
                            'master_province_id': _selectedProvinsi['id'],
                            'master_city_id': _selectedKabko['id'],
                            'master_district_id': selectedKecamatan['id'],
                            'master_village_id': selectedDesa['id'],
                            'address': _alamatController.text,
                            // 'is_primary': _alamatUtama == true ? 1 : 0
                          };

                          if (widget.alamat != null) {
                            alamatPerusahaan['id'] = widget.alamat['id'];
                          }

                          _simpan(alamatPerusahaan);
                        },
                        child: const Row(
                          children: [Icon(Icons.save), Text('Simpan')],
                        )),
                  )
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 20))
            ],
          ),
        ));
  }

  _simpan(dynamic dataAlamatPerusahaan) {
    String token = loginInfo['data']['token'];
    // String idPerusahaan = loginInfo['data']['id'];

    //widget.profilPerusahaan;

    log('data $dataAlamatPerusahaan');

    Future<dynamic> simpan = _apiPerusahaanCall.simpanAlamatPerusahaan(
        token: token, data: dataAlamatPerusahaan);
    if (widget.alamat != null) {
      simpan = _apiPerusahaanCall.updateAlamatPerusahaan(
          idAlamat: widget.alamat['id'],
          token: token,
          data: dataAlamatPerusahaan);
    }

    simpan.then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  Navigator.of(context).pop();
                  showAlertDialogWithAction('Data Berhasil disimpan', context,
                      () {
                    Navigator.of(context).pop('OK');
                    Navigator.of(context).pop('OK');
                  }, 'OK');
                });
              });
        }
      },
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
