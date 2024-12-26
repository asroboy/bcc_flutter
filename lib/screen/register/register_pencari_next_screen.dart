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
import 'package:intl/intl.dart';

import 'package:bcc/screen/register/informasi_pendaftaran.dart';
import 'package:bcc/screen/register/register_complete.dart';
import 'package:flutter/material.dart';

class RegisterPencariKerjaNextScreen extends StatefulWidget {
  const RegisterPencariKerjaNextScreen({super.key, this.registerData});

  final dynamic registerData;
  @override
  State<RegisterPencariKerjaNextScreen> createState() =>
      _RegisterPencariKerjaNextScreenState();
}

class _RegisterPencariKerjaNextScreenState
    extends State<RegisterPencariKerjaNextScreen> {
  final ApiCall _apiCall = ApiCall();
  late ApiHelper _apiHelper;

  String? jenisKelamin;
  String? wargaNegara;
  String? agama;
  String? statusPernikahan;
  String? statusBekerja;
  String? bulanMulaiPendidikan;
  String? bulanSampaiPendidikan;

  List<String> bulanString = [
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

  // String? pendidikan;

  List<dynamic> provinsisObj = [];
  List<dynamic> kotaObj = [];
  List<dynamic> kecamatanObj = [];
  List<dynamic> desaObj = [];
  DateTime? tanggalLahir;
  final TextEditingController _textEditingControllerTanggalLahir =
      TextEditingController();
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _noKTPController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _tinggiBadanController = TextEditingController();
  final TextEditingController _beratBadanController = TextEditingController();
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

  List<dynamic> disabilitasObj = [];
  List<String> disabilitasListString = [];
  String? disabilitas;
  dynamic selectedDisabilitasObj;

  _fetchDisabilitas() {
    Future<dynamic> req = _apiCall.getDataPendukung(Constants.pathDisable);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                disabilitasObj.addAll(response['data']);
                for (dynamic d in disabilitasObj) {
                  disabilitasListString.add(d['name']);
                }
              });
            }
          });
    });
  }

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

  List<dynamic> sekolahObj = [];
  List<String> sekolahListString = [];
  dynamic selectedSekolahObj;
  String? selectedSekolahString;

  _fetchDataSekolah() {
    Future<dynamic> req = _apiCall.getDataPendukung(Constants.pathSekolah);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                sekolahObj.addAll(response['data']);
                for (dynamic d in sekolahObj) {
                  sekolahListString.add(d['name']);
                }
              });
            }
          });
    });
  }

  _fetchDataSekolahByName(String name) {
    Future<dynamic> req =
        _apiCall.getDataPendukung(Constants.pathSekolah + ('?name=') + name);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            setState(() {
              sekolahObj.addAll(response['data']);
            });
          });
    });
  }

  _fetchDataJurusanSekolahByName(String filter) {
    Future<dynamic> req = _apiCall
        .getDataPendukung(Constants.pathJurusanSekolah + ('?name=') + filter);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            setState(() {
              jurusanObj.addAll(response['data']);
            });
          });
    });
  }

  List<dynamic> jurusanObj = [];
  List<String> jurusanListString = [];
  dynamic selectedJurusanObj;
  String? selectedJurusan;

  _fetchDataJurusanSekolah() {
    Future<dynamic> req =
        _apiCall.getDataPendukung(Constants.pathJurusanSekolah);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                jurusanObj.addAll(response['data']);
                for (dynamic d in jurusanObj) {
                  jurusanListString.add(d['name']);
                }
              });
            }
          });
    });
  }

  @override
  void initState() {
    _apiHelper = ApiHelper(buildContext: context);
    _fetchDataProvinsi();
    _fetchDisabilitas();

    _fetchPendidikanTerakhir();
    _fetchDataSekolah();
    _fetchDataJurusanSekolah();

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
            const InformasiPendaftaran(),
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
                      'DATA DIRI PENCARI KERJA',
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
                    hint: 'Nama Lengkap*',
                    controller: _namaLengkapController,
                    padding: const EdgeInsets.only(top: 5),
                  ),
                  BccTextFormFieldInput(
                    hint: 'No. KTP*',
                    textInputType: TextInputType.number,
                    controller: _noKTPController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'No Telpon (+62)',
                    textInputType: TextInputType.phone,
                    controller: _noTelpController,
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
                  BccTextFormFieldInput(
                    hint: 'Tempat Lahir*',
                    controller: _tempatLahirController,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: BccTextFormFieldInput(
                          hint: 'Tanggal Lahir*',
                          readOnly: true,
                          controller: _textEditingControllerTanggalLahir,
                          padding: const EdgeInsets.only(top: 15),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.15,
                        child: Center(
                          child: BccButton(
                              padding: const EdgeInsets.only(top: 15),
                              size: const Size(40, 45),
                              onPressed: () {
                                showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1970),
                                        lastDate: DateTime.now())
                                    .then((value) {
                                  setState(() {
                                    if (value != null) {
                                      tanggalLahir = value;

                                      DateFormat df =
                                          DateFormat('dd MMMM yyyy');
                                      _textEditingControllerTanggalLahir.text =
                                          df.format(tanggalLahir!);
                                    }
                                  });
                                });
                              },
                              child: const Icon(Icons.calendar_today)),
                        ),
                      ),
                    ],
                  ),
                  const BccRowLabel(label: 'Agama'),
                  BccDropDownString(
                    value: agama,
                    hint: const Text('Agama*'),
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
                  const BccRowLabel(label: 'Penyandang disabilitas?'),
                  BccDropDownString(
                    value: disabilitas,
                    hint: const Text('Penyandang disabilitas?'),
                    data: disabilitasListString,
                    onChanged: (value) {
                      setState(() {
                        disabilitas = value;
                        selectedDisabilitasObj = disabilitasObj
                            .singleWhere((element) => element['name'] == value);
                      });
                    },
                  ),
                  BccTextFormFieldInput(
                    hint: 'Tinggi Badan (cm)*',
                    controller: _tinggiBadanController,
                    textInputType: TextInputType.number,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Berat Badan (kg)*',
                    controller: _beratBadanController,
                    textInputType: TextInputType.number,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  const BccRowLabel(label: 'Kewarganegaraan*'),
                  BccDropDownString(
                    value: wargaNegara,
                    hint: const Text('Kewarganegaraan*'),
                    data: const ['WNI', 'WNA'],
                    onChanged: (value) {
                      setState(() {
                        wargaNegara = value;
                      });
                    },
                  ),
                  const BccRowLabel(label: 'Status Pernikahan*'),
                  BccDropDownString(
                    value: statusPernikahan,
                    hint: const Text('Status Pernikahan*'),
                    data: const [
                      'BELUM KAWIN',
                      'KAWIN',
                      'CERAI MATI',
                      'CERAI HIDUP'
                    ],
                    onChanged: (value) {
                      setState(() {
                        statusPernikahan = value;
                      });
                    },
                  ),
                  const BccRowLabel(label: 'Status Bekerja*'),
                  BccDropDownString(
                    value: statusBekerja,
                    hint: const Text('Status Bekerja*'),
                    data: const [
                      'BELUM BEKERJA',
                      'SUDAH BEKERJA',
                      'SEDANG PELATIHAN'
                    ],
                    onChanged: (value) {
                      setState(() {
                        statusBekerja = value;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'PENDIDIKAN',
                      style: TextStyle(
                        color: Constants.colorBiruGelap,
                        fontSize: 14,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.14,
                      ),
                    ),
                  ),
                  const BccRowLabel(label: 'Pendidikan Terakhir*'),
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
                    hint: 'Tahun Lulus*',
                    textInputType: TextInputType.number,
                    controller: _tahunLulusController,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                  ),
                  const BccRowLabel(label: 'Sekolah/Perguruan Tinggi*'),
                  BccDropdownSearch(
                      items: sekolahObj,
                      getData: _fetchDataSekolahByName,
                      hint: "Sekolah/Perguruan Tinggi*",
                      itemAsString: (dynamic u) => u['name'],
                      onChange: (dynamic data) {
                        setState(() {
                          selectedSekolahString = data['name'];
                          selectedSekolahObj = data;
                        });
                      }),
                  const BccRowLabel(label: 'Proram/Jurusan*'),
                  BccDropdownSearch(
                      items: jurusanObj,
                      getData: _fetchDataJurusanSekolahByName,
                      hint: "Program/Jurusan*",
                      itemAsString: (dynamic u) => u['name'],
                      onChange: (dynamic data) {
                        setState(() {
                          selectedJurusan = data['name'];
                          selectedJurusanObj = data;
                        });
                      }),
                  const BccRowLabel(label: 'Mulai pendidikan dari'),
                  const BccRowLabel(label: 'Bulan mulai*'),
                  BccDropDownString(
                    value: bulanMulaiPendidikan,
                    hint: const Text('Bulan mulai*'),
                    data: bulanString,
                    onChanged: (value) {
                      setState(() {
                        bulanMulaiPendidikan = value;
                      });
                    },
                  ),
                  BccTextFormFieldInput(
                    hint: 'Tahun mulai*',
                    textInputType: TextInputType.number,
                    controller: _tahunMulaiPendidikan,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  const BccRowLabel(label: 'Bulan sampai*'),
                  BccDropDownString(
                    value: bulanSampaiPendidikan,
                    hint: const Text('Bulan sampai*'),
                    data: bulanString,
                    onChanged: (value) {
                      setState(() {
                        bulanSampaiPendidikan = value;
                      });
                    },
                  ),
                  BccTextFormFieldInput(
                    hint: 'Tahun sampai*',
                    textInputType: TextInputType.number,
                    controller: _tahunSelesaiPendidikan,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'ALAMAT TINGGAL / DOMISILI',
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
                  const BccRowLabel(label: 'Desa*'),
                  BccDropDownString(
                    value: selectedDesaString,
                    hint: const Text('Desa'),
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
                    hint: 'Alamat lengkap',
                    padding: const EdgeInsets.only(top: 10),
                    controller: _alamatLengkapController,
                  ),
                  BccButton(
                    onPressed: () {
                      String namaLengkap = _namaLengkapController.text;
                      String noKtp = _noKTPController.text;
                      String noTelp = _noTelpController.text;
                      String tempatLahir = _tempatLahirController.text;
                      String beratBadan = _beratBadanController.text;
                      String tinggiBadan = _tinggiBadanController.text;
                      String tahunLulus = _tahunLulusController.text;
                      String tahunMulaiPendidikan = _tahunMulaiPendidikan.text;
                      String alamatLengkap = _alamatLengkapController.text;
                      String tahunSelesaiPendidikan =
                          _tahunSelesaiPendidikan.text;
                      String tangalLahirString =
                          _textEditingControllerTanggalLahir.text;
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
                      if (noTelp == '') {
                        showAlertDialog('Harap isi no Telp. Kamu', context);
                        return;
                      }

                      if (jenisKelamin == '') {
                        showAlertDialog('Harap pilih jenis kelamin', context);
                        return;
                      }

                      if (tempatLahir == '') {
                        showAlertDialog('Harap isi tempat lahir kamu', context);
                        return;
                      }
                      if (tangalLahirString == '') {
                        showAlertDialog(
                            'Harap isi tanggal lahir kamu', context);
                        return;
                      }

                      if (agama == null) {
                        showAlertDialog('Harap isi Agama kamu', context);
                        return;
                      }
                      if (selectedDisabilitasObj == null) {
                        showAlertDialog(
                            'Harap isi Apakah kamu penyandang disabilitas',
                            context);
                        return;
                      }

                      if (tinggiBadan == '') {
                        showAlertDialog('Harap isi tinggi badan Kamu', context);
                        return;
                      }
                      if (beratBadan == '') {
                        showAlertDialog('Harap isi berat badan Kamu', context);
                        return;
                      }

                      if (wargaNegara == null) {
                        showAlertDialog('Harap kewarganegaraan Kamu', context);
                        return;
                      }
                      if (statusPernikahan == null) {
                        showAlertDialog(
                            'Harap Status Pernikahan Kamu', context);
                        return;
                      }
                      if (statusBekerja == null) {
                        showAlertDialog('Harap Status Bekerja Kamu', context);
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

                      if (selectedSekolahObj == null) {
                        showAlertDialog(
                            'Harap isi Sekolah / Perguruan Tinggi  Kamu',
                            context);
                        return;
                      }

                      if (selectedJurusanObj == null) {
                        showAlertDialog(
                            'Harap pilih Program Kejuruan Kamu', context);
                        return;
                      }

                      if (bulanMulaiPendidikan == null ||
                          tahunMulaiPendidikan == '' ||
                          bulanSampaiPendidikan == null ||
                          tahunSelesaiPendidikan == '') {
                        showAlertDialog(
                            'Harap lengkapi masa pendidikan Kamu', context);
                        return;
                      }

                      if (selectedDesa == null || alamatLengkap == '') {
                        showAlertDialog(
                            'Harap lengkapi alamat tinggal / domisili',
                            context);
                        return;
                      }

                      var dataCalonUser = widget.registerData;

                      dataCalonUser['name'] = namaLengkap;
                      dataCalonUser['ktp_number'] = noKtp;
                      dataCalonUser['phone_number'] = noTelp;
                      dataCalonUser['place_of_birth'] = tempatLahir;
                      DateFormat df = DateFormat('yyyy-MM-dd');
                      dataCalonUser['date_of_birth'] = df.format(tanggalLahir!);
                      dataCalonUser['gender'] = jenisKelamin;
                      dataCalonUser['religion'] = agama;

                      dataCalonUser['master_disability_id'] =
                          selectedDisabilitasObj['id'];
                      dataCalonUser['height'] = tinggiBadan;
                      dataCalonUser['weight'] = beratBadan;
                      dataCalonUser['weight'] = beratBadan;
                      dataCalonUser['nationality'] = wargaNegara;
                      dataCalonUser['marital_status'] = statusPernikahan;
                      dataCalonUser['work_status'] = statusBekerja;

                      //pendidikan belum lengkap
                      dataCalonUser['last_education'] =
                          selectedPendidikanTerakhir['id'];
                      dataCalonUser['graduation_year'] = tahunLulus;
                      dataCalonUser['master_school_id'] =
                          selectedSekolahObj['id'];
                      dataCalonUser['master_major_id'] =
                          selectedJurusanObj['id'];
                      dataCalonUser['start_month'] = bulanMulaiPendidikan;
                      dataCalonUser['start_year'] = tahunMulaiPendidikan;
                      dataCalonUser['end_month'] = bulanSampaiPendidikan;
                      dataCalonUser['end_year'] = tahunSelesaiPendidikan;

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
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
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
                        Navigator.of(context).pop();

                        _apiHelper.apiCallResponseHandler(
                            response: value,
                            context: context,
                            onSuccess: (response) {
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
