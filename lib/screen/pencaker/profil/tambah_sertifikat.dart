import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/bcc_subheader_label.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TambahSertifikat extends StatefulWidget {
  const TambahSertifikat({super.key, this.sertifikatEdit});

  final dynamic sertifikatEdit;
  @override
  State<TambahSertifikat> createState() => _TambahSertifikatState();
}

class _TambahSertifikatState extends State<TambahSertifikat> {
  dynamic loginData = GetStorage().read(Constants.loginInfo);

  final TextEditingController _tahunMulaiController = TextEditingController();
  final TextEditingController _tahunSampaiController = TextEditingController();
  final TextEditingController _idCredentialController = TextEditingController();
  final TextEditingController _urlCredentialController =
      TextEditingController();
  final TextEditingController _namaSertifikat = TextEditingController();
  final TextEditingController _namaPenerbit = TextEditingController();

  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  String? kredensialMasihAktif;
  String? bulanMulai;
  String? bulanSampai;
  List<String> bulans = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lisensi & Sertifikat'),
      ),
      body: ListView(children: [
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
                  label: 'Tambah Lisensi dan Sertifikat',
                ),
                BccTextFormFieldInput(
                  hint: 'Nama Sertifikat *',
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  controller: _namaSertifikat,
                ),
                BccTextFormFieldInput(
                  hint: 'Nama Penerbit *',
                  padding: const EdgeInsets.only(bottom: 5, top: 10),
                  controller: _namaPenerbit,
                ),
                const BccRowLabel(
                    label: 'Apakah sertifikat masih berlaku/aktif?'),
                BccDropDownString(
                    value: kredensialMasihAktif,
                    data: const ['Ya', 'Tidak'],
                    onChanged: (value) {
                      setState(() {
                        kredensialMasihAktif = value;
                      });
                    }),
                const BccRowLabel(label: 'Bulan mulai'),
                BccDropDownString(
                    value: bulanMulai,
                    data: bulans,
                    onChanged: (value) {
                      setState(() {
                        bulanMulai = value;
                      });
                    }),
                BccTextFormFieldInput(
                  hint: 'Tahun mulai',
                  padding: const EdgeInsets.only(top: 10),
                  controller: _tahunMulaiController,
                ),
                const BccRowLabel(label: 'Bulan sampai'),
                BccDropDownString(
                    value: bulanSampai,
                    data: bulans,
                    onChanged: (value) {
                      setState(() {
                        bulanSampai = value;
                      });
                    }),
                BccTextFormFieldInput(
                  hint: 'Tahun sampai',
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  controller: _tahunSampaiController,
                ),
                BccTextFormFieldInput(
                  hint: 'ID Kredensial',
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  controller: _idCredentialController,
                ),
                BccTextFormFieldInput(
                  hint: 'URL Kredensial',
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  controller: _urlCredentialController,
                ),
                BccButton(
                  onPressed: () {
                    String namaSertifikat = _namaSertifikat.text;
                    String namaPenerbit = _namaPenerbit.text;
                    String tahunMulai = _tahunMulaiController.text;
                    String tahunSampai = _tahunSampaiController.text;

                    if (namaSertifikat == '') {
                      showAlertDialog('Harap isi nama sertifikat', context);
                      return;
                    }

                    if (namaPenerbit == '') {
                      showAlertDialog('Harap pilih nama penerbit', context);
                      return;
                    }

                    if (bulanMulai == null) {
                      showAlertDialog('Pilih bulan mulai', context);
                      return;
                    }
                    if (tahunMulai == '') {
                      showAlertDialog('Pilih tahun mulai', context);
                      return;
                    }

                    if (bulanSampai == null) {
                      showAlertDialog('Pilih bulan samapi', context);
                      return;
                    }
                    if (tahunSampai == '') {
                      showAlertDialog('Pilih tahun sampai', context);
                      return;
                    }

                    // log('data $loginData');
                    String token = loginData['data']['token'];
                    String jobseekerId = loginData['data']['id'];

                    var dataSertifkat = {
                      'name': namaSertifikat,
                      'issuing_organization': namaPenerbit,
                      'is_not_expire': kredensialMasihAktif == 'Ya' ? 1 : 0,
                      'start_month': bulanMulai,
                      'start_year': _tahunMulaiController.text,
                      'end_month': bulanSampai,
                      'end_year': _tahunSampaiController.text,
                      'credential_id': _idCredentialController.text,
                      'credential_url': _urlCredentialController.text,
                      'jobseeker_id': jobseekerId,
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
                                  Text('Loading...')
                                ],
                              ),
                            ),
                          );
                        });

                    _apiCall
                        .simpanSertifikatPencaker(dataSertifkat, token)
                        .then((value) {
                      if (!mounted) return;
                      Navigator.of(context).pop();

                      _apiHelper.apiCallResponseHandler(
                          response: value,
                          context: context,
                          onSuccess: (response) {
                            Navigator.of(context).pop(response);
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (context) => const RegisterComplete()),
                            //   (Route<dynamic> route) => false,
                            // );
                          });
                    });
                  },
                  padding: const EdgeInsets.only(top: 20),
                  child: const Text('Simpan'),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
