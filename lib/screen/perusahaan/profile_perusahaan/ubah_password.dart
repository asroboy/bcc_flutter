import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/landing_tab.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class UbahPassword extends StatefulWidget {
  const UbahPassword({super.key, this.profilPerusahaan});
  final dynamic profilPerusahaan;
  @override
  State<UbahPassword> createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);
  final ApiHelper _apiHelper = ApiHelper();

  TextEditingController passwordLama = TextEditingController();
  TextEditingController passwordBaru = TextEditingController();
  TextEditingController ulangiPasswordBaru = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ubah Kata Sandi'),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              'Untuk mengubah passwod, silahkan masukkan password lama kamu.',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
            ),
          ),
          BccTextFormFieldInput(
            hint: 'Password lama',
            readOnly: false,
            controller: passwordLama,
            textInputType: TextInputType.visiblePassword,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
          ),
          BccTextFormFieldInput(
            hint: 'Password baru',
            readOnly: false,
            controller: passwordBaru,
            textInputType: TextInputType.visiblePassword,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          ),
          BccTextFormFieldInput(
            hint: 'Ulangi password baru',
            readOnly: false,
            controller: ulangiPasswordBaru,
            textInputType: TextInputType.visiblePassword,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (passwordLama.text == '') {
                        showAlertDialog('Harap isi password lama', context);
                        return;
                      }
                      if (passwordBaru.text == '') {
                        showAlertDialog('Harap isi password baru', context);
                        return;
                      }
                      if (ulangiPasswordBaru.text == '') {
                        showAlertDialog('Harap ulangi password baru', context);
                        return;
                      }
                      if (passwordLama.text !=
                          widget.profilPerusahaan['password_ori']) {
                        showAlertDialog('Password lama salah', context);
                        return;
                      }
                      if (passwordBaru.text != ulangiPasswordBaru.text) {
                        showAlertDialog('Password baru tidak sama', context);
                        return;
                      }

                      if (passwordBaru.text.length < 6) {
                        showAlertDialog('Password minimal 6 digit', context);
                        return;
                      }
                      dynamic perusahaanUpdate = {
                        'old_password': passwordLama.text,
                        'new_password': passwordBaru.text,
                        'renew_password': ulangiPasswordBaru.text
                      };
                      _simpanPassword(perusahaanUpdate);
                    },
                    child: const Row(
                      children: [Icon(Icons.save), Text('Simpan')],
                    ))
              ],
            ),
          )
        ]));
  }

  _simpanPassword(dynamic perusahaanUpdate) {
    String token = loginInfo['data']['token'];
    String perusahaanId = widget.profilPerusahaan['id'];

    //widget.profilPerusahaan;

    log('data $perusahaanUpdate');
    _apiPerusahaanCall
        .updatePasswordPerusahaan(
            idPerusahaan: perusahaanId, token: token, data: perusahaanUpdate)
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  showAlertDialogWithAction(
                      'Password berhasil diubah, silahkan klik OK untuk melakukan login ulang',
                      context, () {
                    _logout(context);
                  }, 'OK');
                  // Navigator.of(context).pop('OK');
                  // infoUkuranPerusahaan.addAll(response['data']);
                  // for (var ukuran in infoUkuranPerusahaan) {
                  //   infoUkuranPerusahaanString.add(ukuran['name']);
                  // }

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

  _logout(BuildContext context) {
    GetStorage().remove(Constants.loginInfo);
    GetStorage().remove(Constants.userType);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LandingTab()),
      (Route<dynamic> route) => true,
    );
  }
}
