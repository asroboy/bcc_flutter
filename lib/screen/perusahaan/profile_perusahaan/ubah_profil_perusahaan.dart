import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/state_management/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class UbahProfilPerusahaan extends StatefulWidget {
  const UbahProfilPerusahaan({super.key, this.profilPerusahaan});

  final dynamic profilPerusahaan;

  @override
  State<UbahProfilPerusahaan> createState() => _UbahProfilPerusahaanState();
}

class _UbahProfilPerusahaanState extends State<UbahProfilPerusahaan> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);
  final ApiHelper _apiHelper = ApiHelper();

  List<dynamic> infoUkuranPerusahaan = [];
  List<String> infoUkuranPerusahaanString = [];
  dynamic selectedUkuranPerusahaan;
  String selectedUkuranPerusahaanName = '';

  _getUkuranPerusahaanInfo() {
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getUkuranPerusahaan(token).then(
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

                  if (widget.profilPerusahaan['master_company_size_id'] !=
                      null) {
                    selectedUkuranPerusahaan = infoUkuranPerusahaan.singleWhere(
                      (element) =>
                          element['id'] ==
                          widget.profilPerusahaan['master_company_size_id'],
                    );
                  }
                });
              });
        }
      },
    );
  }

  @override
  void initState() {
    _getUkuranPerusahaanInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserLoginModel profModel = context.watch<UserLoginModel>();
    TextEditingController usernameController =
        TextEditingController(text: profModel.profilPerusahaan['username']);
    TextEditingController emailController =
        TextEditingController(text: profModel.profilPerusahaan['email']);
    TextEditingController namaController =
        TextEditingController(text: profModel.profilPerusahaan['name']);

    TextEditingController taglineController = TextEditingController(
        text: profModel.profilPerusahaan['tagline'] == null ||
                profModel.profilPerusahaan['tagline'] == 'null'
            ? ''
            : profModel.profilPerusahaan['tagline']);
    TextEditingController tentangController = TextEditingController(
        text: profModel.profilPerusahaan['about_company']);
    TextEditingController teleponPerusahaan = TextEditingController(
        text: profModel.profilPerusahaan['phone_number_company']);

    TextEditingController websitePerusahaan =
        TextEditingController(text: profModel.profilPerusahaan['website']);
    TextEditingController tahunPendiaranController =
        TextEditingController(text: profModel.profilPerusahaan['founded']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Profil Perusahaan'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              'Informasi Umum',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          BccTextFormFieldInput(
            hint: 'Username',
            readOnly: true,
            controller: usernameController,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          ),
          BccTextFormFieldInput(
            hint: 'Email',
            readOnly: true,
            controller: emailController,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              'Info Perusahaan',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          BccTextFormFieldInput(
            hint: 'Nama Perusahaan',
            controller: namaController,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          BccTextFormFieldInput(
            hint: 'Tagline',
            controller: taglineController,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          BccTextFormFieldInput(
            hint: 'Tentang Perusahaan',
            controller: tentangController,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          BccTextFormFieldInput(
            hint: 'Telepon Perusahaan',
            controller: teleponPerusahaan,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          BccTextFormFieldInput(
            hint: 'Website Perusahaan',
            controller: websitePerusahaan,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          BccTextFormFieldInput(
            hint: 'Tahun Pendirian',
            controller: tahunPendiaranController,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
          ),
          const BccRowLabel(
            label: 'Ukuran Perusahaan',
            padding: EdgeInsets.only(left: 20),
          ),
          selectedUkuranPerusahaan == null
              ? const Center()
              : BccRowLabel(label: selectedUkuranPerusahaan['name']),
          BccDropDownString(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
            data: infoUkuranPerusahaanString,
            value: selectedUkuranPerusahaanName == ''
                ? profModel.profilPerusahaan['master_company_size_name']
                : '',
            onChanged: (value) {
              setState(() {
                selectedUkuranPerusahaanName = value ?? '';
                selectedUkuranPerusahaan = infoUkuranPerusahaan.firstWhere(
                  (element) => element['name'] == value,
                );
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ElevatedButton(
                    onPressed: () {
                      dynamic perusahaanUpdate = {
                        'id': widget.profilPerusahaan['id'],
                        'name': namaController.text,
                        'tagline': taglineController.text,
                        'about_company': tentangController.text,
                        'phone_number_company': teleponPerusahaan.text,
                        'website': websitePerusahaan.text,
                        'founded': tahunPendiaranController.text,
                        'master_company_size_id':
                            selectedUkuranPerusahaan['id'],
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
    String perusahaanId = widget.profilPerusahaan['id'];

    //widget.profilPerusahaan;

    log('data $perusahaanUpdate');
    _apiPerusahaanCall
        .simpanProfilPerusahaan(perusahaanId, token, perusahaanUpdate)
        .then(
      (value) {
        if (mounted) {
          Navigator.of(context).pop();
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                showAlertDialogWithAction(
                    'Profil Perusahan berhasil disimpan', context, () {
                  _getProfilPerusahaan();
                }, 'OK');
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

                  Navigator.of(context).pop();
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
