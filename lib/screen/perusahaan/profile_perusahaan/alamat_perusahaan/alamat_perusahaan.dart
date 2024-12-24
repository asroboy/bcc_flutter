// import 'dart:convert';
import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_loading_indicator.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/alamat_perusahaan/tambah_alamat_perusahaan.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AlamatPerusahaan extends StatefulWidget {
  const AlamatPerusahaan({super.key});

  @override
  State<AlamatPerusahaan> createState() => _AlamatPerusahaanState();
}

class _AlamatPerusahaanState extends State<AlamatPerusahaan> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool isLoading = true;
  final ApiHelper _apiHelper = ApiHelper();

  final List<dynamic> _alamats = [];

  _getAlamatPerusahaan() {
    String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getAlamatPerusahaan(idPerusahaan, token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  isLoading = false;
                  _alamats.addAll(response['data']);
                  log('alamat perusahaan result $response');
                  // _dataPengalamanBekerja.addAll(biodataPencaker['experience']);
                  // _dataPendidikanPencaker.addAll(biodataPencaker['education']);
                  // _dataSertifikat.addAll(biodataPencaker['certificate']);
                  // _dataSkill.addAll(biodataPencaker['skill']);
                });
              });
        }
      },
    );
  }

  @override
  void initState() {
    _getAlamatPerusahaan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alamat Perusahaan'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => const TambahAlamatPerusahaan(),
          ))
              .then((value) {
            if (value == 'OK') {
              setState(() {
                isLoading = true;
                _alamats.clear();
              });
              _getAlamatPerusahaan();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: const BccLoadingIndicator(),
            )
          : ListView.builder(
              itemCount: _alamats.length,
              itemBuilder: (context, index) {
                dynamic alamat = _alamats[index];
                return Padding(
                  padding: const EdgeInsets.all(5),
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${_alamats[index]['title']}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              (_alamats[index]['is_primary'] == '1')
                                  ? ' (Utama)'
                                  : '',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                                child: Text(
                                    '${_alamats[index]['address']}, ${_alamats[index]['master_village_name']},${_alamats[index]['master_district_name']}, ${_alamats[index]['master_city_name']}, ${_alamats[index]['master_province_name']}'))
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            (_alamats[index]['is_primary'] != '1')
                                ? IconButton(
                                    padding: const EdgeInsets.all(3),
                                    onPressed: () {
                                      showAlertDialogWithAction2(
                                          'Kamu akan menjadikan alamat ini sebagai alamat utama, lanjutkan?',
                                          context, () {
                                        Navigator.of(context).pop();
                                      }, () {
                                        // Navigator.of(context).pop();
                                        _ubahAlamatUtama(alamat['id']);
                                      }, 'Batal', 'OK');
                                    },
                                    icon: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                    ))
                                : const Center(),
                            IconButton(
                                padding: const EdgeInsets.all(3),
                                onPressed: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) =>
                                        TambahAlamatPerusahaan(
                                      alamat: alamat,
                                    ),
                                  ))
                                      .then((value) {
                                    if (value == 'OK') {
                                      setState(() {
                                        isLoading = true;
                                        _alamats.clear();
                                      });
                                      _getAlamatPerusahaan();
                                    }
                                  });
                                },
                                icon: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                )),
                            IconButton(
                                padding: const EdgeInsets.all(3),
                                onPressed: () {
                                  showAlertDialogWithAction2(
                                      "Apakah kamu yakin menghapus data ini?",
                                      context, () {
                                    Navigator.of(context).pop();
                                  }, () {
                                    Navigator.of(context).pop();
                                    String idAlamat = alamat['id'];

                                    showLoaderDialog(
                                        context: context,
                                        message: 'Harap tunggu...');

                                    _hapus(idAlamat);
                                  }, 'Batal', 'OK');
                                },
                                icon: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  )),
                );
              },
            ),
    );
  }

  _hapus(String idAlamat) {
    String token = loginInfo['data']['token'];
    log('data $idAlamat');
    _apiPerusahaanCall
        .hapusAlamatPerusahaan(
      idAlamat: idAlamat,
      token: token,
    )
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  Navigator.of(context).pop();
                  setState(() {
                    isLoading = true;
                    _alamats.clear();
                  });
                  _getAlamatPerusahaan();
                });
              });
        }
      },
    );
  }

  _ubahAlamatUtama(String idAlamat) {
    String token = loginInfo['data']['token'];
    log('data $idAlamat');
    _apiPerusahaanCall.setAlamatUtamaPerusahaan(
        idAlamat: idAlamat, token: token, data: {'is_primary': 1}).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  Navigator.of(context).pop();
                  setState(() {
                    isLoading = true;
                    _alamats.clear();
                  });
                  _getAlamatPerusahaan();
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
