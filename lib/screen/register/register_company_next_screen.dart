import 'dart:async';
import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/register/informasi_pendaftaran.dart';
import 'package:bcc/screen/register/register_complete.dart';
import 'package:flutter/material.dart';

class RegisterCompnayNextScreen extends StatefulWidget {
  const RegisterCompnayNextScreen({super.key, this.registerData});

  final dynamic registerData;
  @override
  State<RegisterCompnayNextScreen> createState() =>
      _RegisterCompnayNextScreenState();
}

class _RegisterCompnayNextScreenState extends State<RegisterCompnayNextScreen> {
  final ApiCall _apiCall = ApiCall();
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  late ApiHelper _apiHelper;

  List<dynamic> provinsisObj = [];
  List<dynamic> kotaObj = [];
  List<dynamic> kecamatanObj = [];
  List<dynamic> desaObj = [];

  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _noKTPController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tahunBerdiriController = TextEditingController();
  final TextEditingController _sekilasPerusahaanController =
      TextEditingController();

  final TextEditingController _tahunLulusController = TextEditingController();
  final TextEditingController _tahunMulaiPendidikan = TextEditingController();
  final TextEditingController _tahunSelesaiPendidikan = TextEditingController();
  final TextEditingController _alamatLengkapController =
      TextEditingController();

  List<String> provinsiListString = [];
  List<String> kotaListString = [];
  List<String> kecamatanListString = [];
  List<String> desaListString = [];

  String? selectedProvinsiString;
  String? selectedKotaString;
  String? selectedKecamatanString;
  String? selectedDesaString;

  dynamic selectedProvinsi;
  dynamic selectedKota;
  dynamic selectedKecamatan;
  dynamic selectedDesa;

  List<dynamic> pendidikanTerakhirObj = [];
  List<String> pendidikanTerakhirListString = [];
  dynamic selectedPendidikanTerakhir;
  String? selectedPendidikanTerakhirString;

  _fetchDataProvinsi() {
    Future<dynamic> req = _apiCall.getDataPendukung(Constants.pathProvinsi);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                provinsisObj.addAll(response['data']);
                for (dynamic prov in provinsisObj) {
                  provinsiListString.add(prov['name']);
                }
              });
            }
          });
    });
  }

  _resetKota() {
    _resetKecamatan();
    setState(() {
      kotaObj.clear();
      selectedKota = null;
      selectedKotaString = null;
      kotaListString.clear();
    });
  }

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

  _fetchDataKota(String idProvinsi) {
    Future<dynamic> req = _apiCall.getDataPendukung(
        Constants.pathKota + ('?master_province_id=') + idProvinsi);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                kotaObj.addAll(response['data']);
                for (dynamic kota in kotaObj) {
                  kotaListString.add(kota['name']);
                }
              });
            }
          });
    });
  }

  _fetchDataKecamatan(String idKota) {
    Future<dynamic> req = _apiCall.getDataPendukung(
        Constants.pathKecamatan + ('?master_city_id=') + idKota);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                kecamatanObj.addAll(response['data']);
                for (dynamic kecamatan in kecamatanObj) {
                  kecamatanListString.add(kecamatan['name']);
                }
              });
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
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                desaObj.addAll(response['data']);
                for (dynamic desa in desaObj) {
                  desaListString.add(desa['name']);
                }
              });
            }
          });
    });
  }

  List<String> klasifikasi = [
    'Mikro',
    'Kecil',
    'Menengah',
    'Besar',
  ];

  List<String> simpanKlasifikasi = ['MICRO', 'SMALL', 'MEDIUM', 'BIG'];

  String? _selectedKlasifikasi;
  String? _selectedSimpanKlasifikasi;

  List<dynamic> infoUkuranPerusahaan = [];
  List<String> infoUkuranPerusahaanString = [];
  dynamic selectedUkuranPerusahaan;
  String selectedUkuranPerusahaanName = '';

  _getUkuranPerusahaanInfo() {
    // String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getUkuranPerusahaan('').then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  infoUkuranPerusahaan.addAll(response['data']);
                  for (var ukuran in infoUkuranPerusahaan) {
                    infoUkuranPerusahaanString.add(ukuran['name']);
                  }
                });
              });
        }
      },
    );
  }

  List<dynamic> masterIndustri = [];
  List<String> masterIndustriString = [];
  dynamic selectedMasterIndustri;
  String? selectedMasterIndustriName;

  _getMasterIndustri() {
    // String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getMasterIndustri().then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  masterIndustri.addAll(response['data']);
                  for (var industri in masterIndustri) {
                    masterIndustriString.add(industri['name']);
                  }
                });
              });
        }
      },
    );
  }

  @override
  void initState() {
    _apiHelper = ApiHelper(buildContext: context);
    _fetchDataProvinsi();
    _getUkuranPerusahaanInfo();
    _getMasterIndustri();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/icons/ic_back.png',
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            const InformasiPendaftaran(registerType: RegisterType.perusahaan),
            const Padding(
              padding: EdgeInsets.only(top: 40),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: ShapeDecoration(
                color: Constants.boxColorBlueTrans,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'INFORMASI DASAR PERUSAHAAN',
                      style: TextStyle(
                        color: Constants.colorBiruGelap,
                        fontSize: 14,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.14,
                      ),
                    ),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Nama Perusahaan*',
                    controller: _namaLengkapController,
                    padding: const EdgeInsets.only(top: 5),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Email Perusahaan*',
                    textInputType: TextInputType.number,
                    controller: _noKTPController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Telepon Perusahaan*',
                    textInputType: TextInputType.phone,
                    controller: _noTelpController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Website*',
                    controller: _tempatLahirController,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  const BccRowLabel(label: 'Klasifikasi'),
                  BccDropDownString(
                    value: _selectedKlasifikasi,
                    hint: const Text('Klasifikasi*'),
                    data: klasifikasi,
                    onChanged: (value) {
                      setState(() {
                        _selectedKlasifikasi = value;
                        _selectedSimpanKlasifikasi =
                            simpanKlasifikasi[klasifikasi.indexOf(value!)];
                      });
                    },
                  ),
                  const BccRowLabel(label: 'Jumlah Pekerja'),
                  BccDropDownString(
                    value: selectedUkuranPerusahaanName,
                    hint: const Text('Jumlah Pekerja*'),
                    data: infoUkuranPerusahaanString,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          selectedUkuranPerusahaanName = value;
                          selectedUkuranPerusahaan =
                              infoUkuranPerusahaan.singleWhere(
                            (element) =>
                                element['name'] == selectedUkuranPerusahaanName,
                          );
                        }
                      });
                    },
                  ),
                  const BccRowLabel(label: 'Industri'),
                  BccDropDownString(
                    value: selectedMasterIndustriName,
                    hint: const Text('Industri*'),
                    data: masterIndustriString,
                    onChanged: (value) {
                      setState(() {
                        selectedMasterIndustriName = value;
                        if (value != null) {
                          selectedMasterIndustri = masterIndustri.singleWhere(
                            (element) =>
                                element['name'] == selectedUkuranPerusahaanName,
                          );
                        }
                      });
                    },
                  ),
                  BccTextFormFieldInput(
                    hint: 'Tahun Berdiri*',
                    controller: _tahunBerdiriController,
                    textInputType: TextInputType.number,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Sekilas Tentang Perusahaan',
                    controller: _sekilasPerusahaanController,
                    textInputType: TextInputType.multiline,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'ALAMAT PERUSAHAAN',
                      style: TextStyle(
                        color: Constants.colorBiruGelap,
                        fontSize: 14,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.14,
                      ),
                    ),
                  ),
                  const BccRowLabel(label: 'Procinsi*'),
                  BccDropDownString(
                    value: selectedProvinsiString,
                    hint: const Text('Provinsi'),
                    data: provinsiListString,
                    onChanged: (value) {
                      setState(() {
                        selectedProvinsiString = value;
                        selectedProvinsi = provinsisObj
                            .singleWhere((element) => element['name'] == value);
                        if (selectedProvinsi != null) {
                          _resetKota();
                          _fetchDataKota(selectedProvinsi['id']);
                        }
                      });
                    },
                  ),
                  const BccRowLabel(label: 'Kota/Kabupaten*'),
                  BccDropDownString(
                    value: selectedKotaString,
                    hint: const Text('Kota/Kabupaten'),
                    data: kotaListString,
                    onChanged: (value) {
                      setState(() {
                        selectedKotaString = value;
                        selectedKota = kotaObj
                            .singleWhere((element) => element['name'] == value);

                        if (selectedKota != null) {
                          _resetKecamatan();
                          _fetchDataKecamatan(selectedKota['id']);
                        }
                      });
                    },
                  ),
                  const BccRowLabel(label: 'Kecamatan*'),
                  BccDropDownString(
                    value: selectedKecamatanString,
                    hint: const Text('Kecamatan'),
                    data: kecamatanListString,
                    onChanged: (value) {
                      setState(() {
                        selectedKecamatanString = value;
                        selectedKecamatan = kecamatanObj
                            .singleWhere((element) => element['name'] == value);

                        if (selectedKecamatan != null) {
                          _resetDesa();
                          _fetchDataDesa(selectedKecamatan['id']);
                        }
                      });
                    },
                  ),
                  const BccRowLabel(label: 'Desa/Keluarahan*'),
                  BccDropDownString(
                    value: selectedDesaString,
                    hint: const Text('Desa/Keluarahan'),
                    data: desaListString,
                    onChanged: (value) {
                      setState(() {
                        selectedDesaString = value;
                        selectedDesa = desaObj
                            .singleWhere((element) => element['name'] == value);
                      });
                    },
                  ),
                  BccTextFormFieldInput(
                    hint: 'Jl. Raya Bogor No ....',
                    label: 'Alamat lengkap',
                    textInputType: TextInputType.multiline,
                    padding: const EdgeInsets.only(top: 10),
                    controller: _alamatLengkapController,
                  ),
                  BccButton(
                    onPressed: () {
                      String namaLengkap = _namaLengkapController.text;
                      String noKtp = _noKTPController.text;

                      String tahunBerdiri = _tahunBerdiriController.text;
                      String tahunLulus = _tahunLulusController.text;
                      String tahunMulaiPendidikan = _tahunMulaiPendidikan.text;
                      String alamatLengkap = _alamatLengkapController.text;
                      String tahunSelesaiPendidikan =
                          _tahunSelesaiPendidikan.text;

                      if (namaLengkap == '') {
                        showAlertDialog('Harap isi nama lengkap Kamu', context);
                        return;
                      }
                      if (noKtp == '') {
                        showAlertDialog('Harap isi no KTP Kamu', context);
                        return;
                      }
                      if (noKtp.length != 16) {
                        showAlertDialog('No KTP harus 16 digit', context);
                        return;
                      }

                      if (tahunBerdiri == '') {
                        showAlertDialog(
                            'Harap isi tahun pendirian perusahaan', context);
                        return;
                      }

                      if (selectedPendidikanTerakhir == null) {
                        showAlertDialog(
                            'Harap pilih pendidikan terakhir Kamu', context);
                        return;
                      }

                      if (tahunLulus == '') {
                        showAlertDialog('Harap isi tahun lulus Kamu', context);
                        return;
                      }

                      if (selectedDesa == null || alamatLengkap == '') {
                        showAlertDialog(
                            'Harap lengkapi alamat tinggal / domisili',
                            context);
                        return;
                      }

                      var dataCalonUser = widget.registerData;

                      dataCalonUser['tahun_'] = tahunBerdiri;

                      //alamat
                      dataCalonUser['master_province_id'] =
                          selectedProvinsi['id'];
                      dataCalonUser['master_city_id'] = selectedKota['id'];
                      dataCalonUser['master_district_id'] =
                          selectedKecamatan['id'];
                      dataCalonUser['master_village_id'] = selectedDesa['id'];
                      dataCalonUser['address'] = alamatLengkap;

                      log('data calon user $dataCalonUser');

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

                      _apiCall.daftar(dataCalonUser).then((value) {
                        if (!mounted) return;

                        _apiHelper.apiCallResponseHandler(
                            response: value,
                            onSuccess: (response) {
                              Navigator.of(context).pop();

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterComplete()),
                                (Route<dynamic> route) => false,
                              );
                            });
                      });
                    },
                    padding: const EdgeInsets.only(
                        left: 0, right: 0, top: 10, bottom: 30),
                    child: const Text('Daftar'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
