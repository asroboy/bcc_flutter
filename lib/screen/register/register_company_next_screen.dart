import 'dart:async';
import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_search.dart';
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
  final _formKey = GlobalKey<FormState>();

  final ApiCall _apiCall = ApiCall();
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  late ApiHelper _apiHelper;

  List<dynamic> provinsisObj = [];
  List<dynamic> kotaObj = [];
  List<dynamic> kecamatanObj = [];
  List<dynamic> desaObj = [];

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
  String? selectedUkuranPerusahaanName;

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

  _getMasterIndustri(String? cari) {
    // String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getMasterIndustri(cari: cari).then(
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
    _getMasterIndustri(null);
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
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        autofocus: true,
                        controller: _namaPerusahaanController,
                        validator: _namaPerusahaanErrorType,
                        onChanged: _validateNamaPerusahaan,
                        padding: const EdgeInsets.only(top: 5),
                      ),
                      BccTextFormFieldInput(
                        hint: 'Email Perusahaan*',
                        textInputType: TextInputType.emailAddress,
                        validator: _emailErrorType,
                        onChanged: _validateEmail,
                        controller: _emailPerusahaanController,
                        padding: const EdgeInsets.only(top: 15),
                      ),
                      BccTextFormFieldInput(
                        hint: 'Telepon Perusahaan*',
                        textInputType: TextInputType.phone,
                        controller: _telpPerusahaanController,
                        validator: _telpPerusahaanErrorType,
                        onChanged: _validateNoTelp,
                        padding: const EdgeInsets.only(top: 15),
                      ),
                      BccTextFormFieldInput(
                        hint: 'Website',
                        controller: _websiteController,
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
                                    element['name'] ==
                                    selectedUkuranPerusahaanName,
                              );
                            }
                          });
                        },
                      ),
                      const BccRowLabel(label: 'Industri*'),
                      BccDropdownSearch(
                          getData: _getMasterIndustri,
                          items: masterIndustri,
                          keyName: 'name',
                          hint: "Industri",
                          selectedItem: selectedMasterIndustri,
                          itemAsString: (dynamic u) => u['name'],
                          onChange: (data) {
                            log('data $data');
                            setState(() {
                              selectedMasterIndustriName = data['name'];
                              selectedMasterIndustri = data;
                            });
                          }),
                      // BccDropDownString(
                      //   value: selectedMasterIndustriName,
                      //   hint: const Text('Industri*'),
                      //   data: masterIndustriString,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       selectedMasterIndustriName = value;
                      //       if (value != null) {
                      //         selectedMasterIndustri = masterIndustri.singleWhere(
                      //           (element) =>
                      //               element['name'] == selectedUkuranPerusahaanName,
                      //         );
                      //       }
                      //     });
                      //   },
                      // ),
                      BccTextFormFieldInput(
                        hint: 'Tahun Berdiri*',
                        controller: _tahunBerdiriController,
                        validator: _tahunBerdiriErrorType,
                        onChanged: _validateTahunBerdiri,
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
                            selectedProvinsi = provinsisObj.singleWhere(
                                (element) => element['name'] == value);
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
                            selectedKota = kotaObj.singleWhere(
                                (element) => element['name'] == value);

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
                            selectedKecamatan = kecamatanObj.singleWhere(
                                (element) => element['name'] == value);

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
                            selectedDesa = desaObj.singleWhere(
                                (element) => element['name'] == value);
                          });
                        },
                      ),
                      BccTextFormFieldInput(
                        hint: 'Jl. Raya Bogor No ....',
                        label: 'Alamat lengkap',
                        textInputType: TextInputType.multiline,
                        padding: const EdgeInsets.only(top: 10),
                        controller: _alamatLengkapController,
                        onChanged: _validateAlamatLengkap,
                        validator: _alamatLengkapErrorType,
                      ),
                      BccButton(
                        onPressed: () {
                          _submitForm();
                        },
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 10, bottom: 30),
                        child: const Text('Daftar'),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  final TextEditingController _namaPerusahaanController =
      TextEditingController();
  final TextEditingController _emailPerusahaanController =
      TextEditingController();
  final TextEditingController _telpPerusahaanController =
      TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _tahunBerdiriController = TextEditingController();
  final TextEditingController _alamatLengkapController =
      TextEditingController();
  final TextEditingController _sekilasPerusahaanController =
      TextEditingController();
  String? _namaPerusahaanErrorType;
  String? _emailErrorType;
  String? _telpPerusahaanErrorType;
  String? _tahunBerdiriErrorType;
  String? _alamatLengkapErrorType;

  bool _isValidAllInput() {
    return (_namaPerusahaanErrorType == null ||
            _namaPerusahaanErrorType == '') &&
        (_emailErrorType == null || _emailErrorType == '') &&
        (_telpPerusahaanErrorType == null || _telpPerusahaanErrorType == '') &&
        (_tahunBerdiriErrorType == null || _tahunBerdiriErrorType == '');
  }

  void _validateNamaPerusahaan(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _namaPerusahaanErrorType = 'Nama Perusahaan wajib diisi';
      });
    } else {
      setState(() {
        _namaPerusahaanErrorType = null;
      });
    }
  }

  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailErrorType = 'Email wajib diisi';
      });
    } else if (!isEmailValid(value)) {
      setState(() {
        _emailErrorType = 'Masukkan alamat email yang valid';
      });
    } else {
      setState(() {
        _emailErrorType = null;
      });
    }
  }

  void _validateNoTelp(String value) {
    if (value.isEmpty) {
      setState(() {
        _telpPerusahaanErrorType = 'No. Telepon perusahaan wajib diisi';
      });
    } else {
      setState(() {
        _telpPerusahaanErrorType = null;
      });
    }
  }

  void _validateAlamatLengkap(String value) {
    if (value.isEmpty) {
      setState(() {
        _alamatLengkapErrorType = 'Alamat lengkap perusahaan wajib diisi';
      });
    } else {
      setState(() {
        _alamatLengkapErrorType = null;
      });
    }
  }

  void _validateTahunBerdiri(String value) {
    if (value.isEmpty) {
      setState(() {
        _tahunBerdiriErrorType = 'Tahun pendirian wajib diisi';
      });
    }
    if (value.length != 4) {
      setState(() {
        _tahunBerdiriErrorType = 'Tahun terdiri dari 4 digit';
      });
    } else {
      setState(() {
        _tahunBerdiriErrorType = null;
      });
    }
  }

  bool isEmailValid(String email) {
    // Basic email validation using regex
    // You can implement more complex validation if needed
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }

  void _submitForm() {
    _validateNamaPerusahaan(_namaPerusahaanController.text);
    _validateEmail(_emailPerusahaanController.text);
    _validateNoTelp(_telpPerusahaanController.text);
    _validateTahunBerdiri(_tahunBerdiriController.text);
    _validateAlamatLengkap(_alamatLengkapController.text);

    if (_isValidAllInput()) {
      if (_formKey.currentState!.validate()) {
        // Form is valid, proceed with your logic here
        // For this example, we will simply print the email

        if (selectedProvinsi == null) {
          showAlertDialog('Harap pilih provinsi', context);
          return;
        }
        if (selectedKota == null) {
          showAlertDialog('Harap pilih kota/kabupaten', context);
          return;
        }

        if (selectedKecamatan == null) {
          showAlertDialog('Harap pilih kecamatan', context);
          return;
        }

        if (selectedDesa == null) {
          showAlertDialog('Harap pilih desa/kelurahan', context);
          return;
        }

        _showLoadingDialog();
        _registerPerusahaan();
      }
    }
  }

  _registerPerusahaan() {
    var akunPerusahaan = widget
        .registerData; //sudah ada data username dan password dari halaman sebelumnya

    String alamatLengkap = _alamatLengkapController.text;

    akunPerusahaan['name'] = _namaPerusahaanController.text;
    akunPerusahaan['email_company'] = _emailPerusahaanController.text;
    akunPerusahaan['website'] = _websiteController.text;
    akunPerusahaan['phone_number_company'] = _telpPerusahaanController.text;
    akunPerusahaan['founded'] = _tahunBerdiriController.text;
    akunPerusahaan['about_company'] = _sekilasPerusahaanController.text;
    akunPerusahaan['master_industry_id'] = selectedMasterIndustri['id'];
    akunPerusahaan['master_company_size_id'] = selectedUkuranPerusahaan['id'];
    akunPerusahaan['grade'] = _selectedSimpanKlasifikasi;
    akunPerusahaan['domicile'] =
        selectedKota['name'].contains('Bogor') ? 'INSIDE' : 'OUTSIDE';
    akunPerusahaan['master_province_id'] = selectedProvinsi['id'];
    akunPerusahaan['master_city_id'] = selectedKota['id'];
    akunPerusahaan['master_district_id'] = selectedKecamatan['id'];
    akunPerusahaan['master_village_id'] = selectedDesa['id'];
    akunPerusahaan['address'] = alamatLengkap;
    akunPerusahaan['title'] = 'KANTOR PUSAT';

    log('data calon user $akunPerusahaan');

    _apiCall.registrasiPerusahaan(akunPerusahaan).then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            _dismissLoadingDialog();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const RegisterComplete()),
              (Route<dynamic> route) => false,
            );
          });
    });
  }

  _dismissLoadingDialog() {
    Navigator.of(context).pop();
  }

  _showLoadingDialog() {
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
  }
}
