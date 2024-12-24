import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/profile_perusahaan_model.dart';
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
    _getUkuranPerusahaanInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProfilePerusahaanModel profModel = context.watch<ProfilePerusahaanModel>();
    TextEditingController usernameController =
        TextEditingController(text: profModel.profil['username']);
    TextEditingController emailController =
        TextEditingController(text: profModel.profil['email']);
    TextEditingController namaController =
        TextEditingController(text: profModel.profil['name']);

    TextEditingController taglineController = TextEditingController(
        text: profModel.profil['tagline'] == null ||
                profModel.profil['tagline'] == 'null'
            ? ''
            : profModel.profil['tagline']);
    TextEditingController tentangController =
        TextEditingController(text: profModel.profil['about_company']);
    TextEditingController teleponPerusahaan =
        TextEditingController(text: profModel.profil['phone_number_company']);

    TextEditingController websitePerusahaan =
        TextEditingController(text: profModel.profil['website']);
    TextEditingController tahunPendiaranController =
        TextEditingController(text: profModel.profil['founded']);

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
                ? profModel.profil['master_company_size_name']
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
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  Navigator.of(context).pop('OK');
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
}
