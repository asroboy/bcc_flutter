import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/state_management/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class UbahPICPerusahaan extends StatefulWidget {
  const UbahPICPerusahaan({super.key});

  @override
  State<UbahPICPerusahaan> createState() => _UbahPICPerusahaanState();
}

class _UbahPICPerusahaanState extends State<UbahPICPerusahaan> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);
  final ApiHelper _apiHelper = ApiHelper();

  final TextEditingController _namaDirecturHRDController =
      TextEditingController();
  final TextEditingController _ktpDirecturHRDController =
      TextEditingController();
  final TextEditingController _telpDirecturHRDController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserLoginModel profile = context.watch<UserLoginModel>();
    dynamic profilPerusahaan = profile.profilPerusahaan;
    _namaDirecturHRDController.text = profilPerusahaan['director_name'] ?? '';
    _ktpDirecturHRDController.text = profilPerusahaan['director_ktp'] ?? '';
    _telpDirecturHRDController.text =
        profilPerusahaan['director_phone_number'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('PIC Perusahaan'),
      ),
      body: ListView(
        children: [
          const BccRowLabel(
            label: 'Silahkan lengkapi data PIC Perusahaan',
            padding: EdgeInsets.only(left: 15, top: 20, bottom: 10),
          ),
          BccTextFormFieldInput(
            hint: 'Nama Direktur HRD',
            controller: _namaDirecturHRDController,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          BccTextFormFieldInput(
            hint: 'No. KTP Direktur HRD',
            controller: _ktpDirecturHRDController,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          BccTextFormFieldInput(
            hint: 'Telp. Direktur',
            controller: _telpDirecturHRDController,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ElevatedButton(
                    onPressed: () {
                      if (_namaDirecturHRDController.text == '') {
                        showAlertDialog('Silahkan isi nama Direktur', context);
                        return;
                      }
                      if (_ktpDirecturHRDController.text.length < 16) {
                        showAlertDialog('KTP harus 16 Digit', context);
                        return;
                      }

                      dynamic perusahaanUpdate = {
                        'director_name': _namaDirecturHRDController.text,
                        'director_ktp': _ktpDirecturHRDController.text,
                        'director_phone_number':
                            _telpDirecturHRDController.text,
                      };
                      showLoaderDialog(
                          context: context, message: 'Harap tunggu...');
                      _simpan(perusahaanUpdate);
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

  _simpan(dynamic perusahaanUpdate) {
    String token = loginInfo['data']['token'];
    String idPerusahaan = loginInfo['data']['id'];

    //widget.profilPerusahaan;

    log('data $perusahaanUpdate');
    _apiPerusahaanCall
        .simpanProfilPerusahaan(idPerusahaan, token, perusahaanUpdate)
        .then(
      (value) {
        if (mounted) {
          Navigator.of(context).pop();
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  showAlertDialogWithAction(
                      'PIC Perusahan berhasil disimpan', context, () {
                    _getProfilPerusahaan();
                  }, 'OK');
                });
              });
        }
      },
    );
  }

  _getProfilPerusahaan() {
    String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getProfilPerusahaan(idPerusahaan, token).then(
      (value) {
        if (mounted) {
          Navigator.of(context).pop();
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  dynamic profilPerusahaan = response['data'];
                  Provider.of<UserLoginModel>(context, listen: false)
                      .setProfilePerusahaan(profilPerusahaan);

                  Navigator.of(context).pop('OK');
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
