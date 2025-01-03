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
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class UbahBiodata extends StatefulWidget {
  const UbahBiodata({super.key, this.biodataPencaker});

  final dynamic biodataPencaker;

  @override
  State<UbahBiodata> createState() => _UbahBiodataState();
}

class _UbahBiodataState extends State<UbahBiodata> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _ktpController = TextEditingController();
  final TextEditingController _notelpController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _tahunLulusController = TextEditingController();
  final TextEditingController _headlineController = TextEditingController();
  final TextEditingController _tinggiBadanController = TextEditingController();
  final TextEditingController _beratBadanController = TextEditingController();
  final TextEditingController _noBpjsController = TextEditingController();
  final TextEditingController _noBpjsTenagaKerjaController =
      TextEditingController();

  String? _namaLengkapErrorType;
  String? _noTelpErrorType;
  String? _tempatLahirErrorType;
  String? _tahunLulusErrorType;

  bool _isValidAllInput() {
    return (_namaLengkapErrorType == null || _namaLengkapErrorType == '') &&
        (_noTelpErrorType == null || _noTelpErrorType == '') &&
        (_tahunLulusErrorType == null || _tahunLulusErrorType == '') &&
        (_tempatLahirErrorType == null || _tempatLahirErrorType == '');
  }

  void _validasiNamaLengkap(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _namaLengkapErrorType = 'Nama lengkap wajib diisi';
      });
    } else if (value.length <= 5) {
      setState(() {
        _namaLengkapErrorType = 'Panjang Nama minimal 5 karakter';
      });
    } else {
      setState(() {
        _namaLengkapErrorType = null;
      });
    }
  }

  void _validasiNomorTelp(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _noTelpErrorType = 'No Telp/HP wajib diisi';
      });
    } else if (value.length <= 5) {
      setState(() {
        _noTelpErrorType = 'Panjang no telp minimal 5 karakter';
      });
    } else {
      setState(() {
        _noTelpErrorType = null;
      });
    }
  }

  void _validasiTempatLahir(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _tempatLahirErrorType = 'Tempat lahir wajib diisi';
      });
    } else {
      setState(() {
        _tempatLahirErrorType = null;
      });
    }
  }

  void _validasiTahunLulus(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _tempatLahirErrorType = 'Tahun lulus wajib diisi';
      });
    } else if (value.length != 4) {
      setState(() {
        _tempatLahirErrorType = 'Tahun lulus harus 4 digit';
      });
    } else {
      setState(() {
        _tempatLahirErrorType = null;
      });
    }
  }

  String? tanggalLahirString;
  DateTime? tanggalLahir;

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
  late ApiHelper _apiHelper;

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
              });
            }
          });
    });
  }

  @override
  void initState() {
    _apiHelper = ApiHelper(buildContext: context);
    _fetchPendidikanTerakhir();

    if (widget.biodataPencaker != null) {
      log('${widget.biodataPencaker}');
      _usernameController.text = widget.biodataPencaker['username'];
      _emailController.text = widget.biodataPencaker['email'];
      _namaLengkapController.text = widget.biodataPencaker['name'];
      _ktpController.text = widget.biodataPencaker['ktp_number'];
      _notelpController.text = widget.biodataPencaker['phone_number'];
      _tempatLahirController.text = widget.biodataPencaker['place_of_birth'];
      _tanggalLahirController.text = widget.biodataPencaker['date_of_birth'];
      tanggalLahirString = widget.biodataPencaker['date_of_birth'];
      tanggalLahir = tanggalLahirString == null
          ? DateTime.now()
          : DateFormat('yyyy-MM-dd').parse(tanggalLahirString!);

      _tahunLulusController.text = widget.biodataPencaker['graduation_year'];
      _noBpjsTenagaKerjaController.text = widget.biodataPencaker['bpjs_number'];
      _noBpjsController.text = widget.biodataPencaker['bpjs_health_number'];
      _tinggiBadanController.text = widget.biodataPencaker['height'];
      _beratBadanController.text = widget.biodataPencaker['weight'];

      jenisKelamin = widget.biodataPencaker['gender'];
      agama = widget.biodataPencaker['religion'];
      warganegara = widget.biodataPencaker['nationality'];
      statusPerkawinan = widget.biodataPencaker['marital_status'];
      statusBekerja = widget.biodataPencaker['work_status'];
      _headlineController.text = widget.biodataPencaker['headline'] ?? '';

      selectedPendidikanTerakhirString =
          widget.biodataPencaker['master_degree_name'];

      selectedPendidikanTerakhir = {
        'id': widget.biodataPencaker['master_degree_id'],
        'name': widget.biodataPencaker['master_degree_name']
      };
    } else {
      tanggalLahir = DateTime.now();
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
                    readOnly: true,
                    controller: _usernameController,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Email',
                    readOnly: true,
                    controller: _emailController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Nama lengkap',
                    validator: _namaLengkapErrorType,
                    onChanged: _validasiNamaLengkap,
                    controller: _namaLengkapController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'KTP',
                    readOnly: true,
                    controller: _ktpController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Nomor Telpon',
                    validator: _noTelpErrorType,
                    onChanged: _validasiNomorTelp,
                    controller: _notelpController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Tempat Lahir',
                    controller: _tempatLahirController,
                    validator: _tempatLahirErrorType,
                    onChanged: _validasiTempatLahir,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: BccTextFormFieldInput(
                            readOnly: true,
                            hint: 'Tanggal Lahir',
                            controller: _tanggalLahirController,
                            padding: const EdgeInsets.only(top: 5),
                          ),
                        ),
                        SizedBox(
                          child: IconButton(
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: tanggalLahir,
                                      firstDate: DateTime(DateTime(1940).year),
                                      lastDate:
                                          DateTime(DateTime.now().year + 5))
                                  .then((value) {
                                setState(() {
                                  if (value == null) return;
                                  tanggalLahir = value;
                                  tanggalLahirString =
                                      DateFormat('yyyy-MM-dd').format(value);

                                  _tanggalLahirController.text =
                                      tanggalLahirString ?? '';
                                });
                              });
                            },
                            icon: Container(
                              margin: const EdgeInsets.only(top: 5),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 12),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Tentang Saya',
                    controller: _headlineController,
                    textInputType: TextInputType.multiline,
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
                    onChanged: _validasiTahunLulus,
                    validator: _tahunLulusErrorType,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Tinggi Badan',
                    controller: _tinggiBadanController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Berat Badan',
                    controller: _beratBadanController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'No BPJS Kesehatan',
                    controller: _noBpjsController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'No BPJS Ketenaga Kerjaan',
                    controller: _noBpjsTenagaKerjaController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccButton(
                    onPressed: () {
                      _simpan();
                    },
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

  _simpan() {
    if (_isValidAllInput() == false) {
      return;
    }

    dynamic loginData = GetStorage().read(Constants.loginInfo);
    // log('data $loginData');
    String token = loginData['data']['token'];
    String jobseekerId = loginData['data']['id'];
    String jobseekerUniqueId = loginData['data']['unique_id'];

    var biodataSimpan = {
      'id': jobseekerId,
      'unique_id': jobseekerUniqueId,
      'username': _usernameController.text,
      'email': _emailController.text,
      'name': _namaLengkapController.text,
      'ktp_number': _ktpController.text,
      'phone_number': _notelpController.text,
      'place_of_birth': _tempatLahirController.text,
      'date_of_birth': tanggalLahirString,
      'gender': jenisKelamin,
      'religion': agama,
      'nationality': warganegara,
      'marital_status': statusPerkawinan,
      'work_status': statusBekerja,
      'last_education': selectedPendidikanTerakhir['id'],
      'graduation_year': _tahunLulusController.text,
      'height': _tinggiBadanController.text,
      'weight': _beratBadanController.text,
      'bpjs_health_number': _noBpjsController.text,
      'bpjs_number': _noBpjsTenagaKerjaController.text,
      'headline': _headlineController.text
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
                  Text('Harap tunggu...')
                ],
              ),
            ),
          );
        });

    if (widget.biodataPencaker != null) {
      _apiCall
          .simpanProfilPencaker(jobseekerUniqueId, token, biodataSimpan)
          .then((value) {
        if (mounted) {
          Navigator.of(context).pop();
        }
        _apiHelper.apiCallResponseHandler(
            response: value,
            onSuccess: (response) {
              Navigator.of(context).pop('OK');
            });
      });
    }
  }
}
