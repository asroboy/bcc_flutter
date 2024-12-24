import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TambahBadanHukum extends StatefulWidget {
  const TambahBadanHukum({super.key, this.mlegalitas});
  final dynamic mlegalitas;
  @override
  State<TambahBadanHukum> createState() => _TambahBadanHukumState();
}

class _TambahBadanHukumState extends State<TambahBadanHukum> {
  final TextEditingController _nomorAktaController = TextEditingController();
  final TextEditingController _namaNotarisController = TextEditingController();
  final TextEditingController _nomorSKKemenkumham = TextEditingController();

  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);
  final ApiHelper _apiHelper = ApiHelper();

  @override
  void initState() {
    if (widget.mlegalitas != null) {
      _nomorAktaController.text = widget.mlegalitas['deed_number'];
      _namaNotarisController.text = widget.mlegalitas['notary_name'];
      _nomorSKKemenkumham.text = widget.mlegalitas['sk_number_kemenkumham'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Badan Hukum Usaha'),
      ),
      body: ListView(
        children: [
          const Padding(padding: EdgeInsets.only(top: 15)),
          const BccRowLabel(
            label: 'Legalitas Perusahaan',
            padding: EdgeInsets.only(left: 15),
          ),
          BccTextFormFieldInput(
            hint: 'Nomor Akta',
            controller: _nomorAktaController,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          BccTextFormFieldInput(
            hint: 'Nama Notaris',
            controller: _namaNotarisController,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          BccTextFormFieldInput(
            hint: 'Nomor SK KEMENKUMHAM',
            controller: _nomorSKKemenkumham,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ElevatedButton(
                    onPressed: () {
                      if (_nomorAktaController.text == '') {
                        showAlertDialog('Harap isi no akta', context);
                        return;
                      }
                      if (_namaNotarisController.text == '') {
                        showAlertDialog('Harap isi nama notaris', context);
                        return;
                      }

                      if (_nomorSKKemenkumham.text == '') {
                        showAlertDialog('Harap isi nama nomor SK', context);
                        return;
                      }

                      showLoaderDialog(
                          context: context, message: 'Harap tunggu..');
                      String idPerusahaan = loginInfo['data']['id'];

                      dynamic dataLegalitas = {
                        'company_id': idPerusahaan,
                        'deed_number': _nomorAktaController.text,
                        'notary_name': _namaNotarisController.text,
                        'sk_number_kemenkumham': _nomorSKKemenkumham.text,
                      };
                      if (widget.mlegalitas != null) {
                        dataLegalitas['id'] = widget.mlegalitas['id'];
                      }
                      _simpan(dataLegalitas);
                    },
                    child: const Row(
                      children: [Icon(Icons.save), Text('Simpan')],
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  _simpan(dynamic dataLegalitas) {
    String token = loginInfo['data']['token'];
    // String idPerusahaan = loginInfo['data']['id'];

    //widget.profilPerusahaan;

    log('data $dataLegalitas');

    Future<dynamic> simpan = _apiPerusahaanCall.simpanLegalitasHukum(
        token: token, data: dataLegalitas);
    if (widget.mlegalitas != null) {
      simpan = _apiPerusahaanCall.updateLegalitasHukum(
          idLegalitas: widget.mlegalitas['id'],
          token: token,
          data: dataLegalitas);
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
