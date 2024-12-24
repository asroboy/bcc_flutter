import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/row_data_info.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TerimaKerja extends StatefulWidget {
  const TerimaKerja({super.key, required this.lamaran});

  final dynamic lamaran;

  @override
  State<TerimaKerja> createState() => _TerimaKerjaState();
}

class _TerimaKerjaState extends State<TerimaKerja> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);
  final ApiHelper _apiHelper = ApiHelper();

  String? _selectedBulan;
  final List<String> _bulanString = [
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
    'Desember'
  ];
  final List<dynamic> _jenisPekerjaan = [];
  final List<String> _jenisPekerjaanString = [];
  dynamic _selectedJenisPekerjaan;
  String? _selectedJenisPekerjaanString;
  bool _isLoadingJenisPekerjaan = true;

  _simpan({required dynamic dataBody}) {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];

    // dynamic newDataUserExperience = dataBody;

    _apiPerusahaanCall
        .tambahkanUserExperienceTerimaKerja(data: dataBody, token: token)
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  Navigator.of(context).pop('');
                  Navigator.of(context).pop('OK');
                });
              });
        }
      },
    );
  }

  final TextEditingController _judulPekerjaanController =
      TextEditingController();
  final TextEditingController _tahunController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();

  final EdgeInsets margin =
      const EdgeInsets.symmetric(horizontal: 15, vertical: 5);

  @override
  void initState() {
    _getJenisPekerjaan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terima Kerja'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Data Pelamar",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          Padding(
            padding: margin,
            child: RowDataInfo(
                label: 'Nama Pelamar', info: widget.lamaran['jobseeker_name']),
          ),
          Padding(
            padding: margin,
            child: RowDataInfo(
                label: 'Jenis Kelamin',
                info: widget.lamaran['jobseeker_gender']),
          ),
          Padding(
            padding: margin,
            child: RowDataInfo(
                label: 'TTL',
                info:
                    '${widget.lamaran['jobseeker_place_of_birth']} ${widget.lamaran['jobseeker_date_of_birth']}'),
          ),
          Padding(
            padding: margin,
            child: RowDataInfo(
                label: 'Email', info: widget.lamaran['jobseeker_email']),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              "Detail Posisi Kerja",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          BccTextFormFieldInput(
            hint: 'Judul Pekerjaan',
            controller: _judulPekerjaanController,
            padding: margin,
          ),
          Padding(
            padding: margin,
            child: const Text('Jenis Pekerjaan'),
          ),
          _isLoadingJenisPekerjaan
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: LinearProgressIndicator(),
                )
              : BccDropDownString(
                  margin: const EdgeInsets.only(
                      left: 15, right: 15, top: 5, bottom: 10),
                  data: _jenisPekerjaanString,
                  value: _selectedJenisPekerjaanString,
                  onChanged: (value) {
                    setState(() {
                      if (value == null) return;
                      _selectedJenisPekerjaanString = value;
                      _selectedJenisPekerjaan = _jenisPekerjaan.firstWhere(
                        (element) => element['name'] == value,
                      );
                    });
                  },
                ),
          Padding(
            padding: margin,
            child: const RowDataInfo(label: 'Mulai Bulan', info: ''),
          ),
          BccDropDownString(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
            data: _bulanString,
            value: _selectedBulan,
            onChanged: (value) {
              setState(() {
                if (value == null) return;
                _selectedBulan = value;
              });
            },
          ),
          BccTextFormFieldInput(
            hint: 'Tahun',
            controller: _tahunController,
            padding: margin,
            textInputType: TextInputType.number,
          ),
          BccTextFormFieldInput(
            hint: 'Keterangan',
            controller: _keteranganController,
            padding: margin,
            textInputType: TextInputType.multiline,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Padding(
                padding: const EdgeInsets.only(left: 15, right: 5),
                child: ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.grey)),
                    child: const Row(
                      children: [Icon(Icons.cancel), Text('Batal')],
                    ))),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 15),
              child: ElevatedButton(
                  onPressed: () {
                    String idPerusahaan = loginInfo['data']['id'];

                    if (_judulPekerjaanController.text == '') {
                      showAlertDialog('Harap isi judul pekerjaan', context);
                      return;
                    }
                    if (_selectedJenisPekerjaan == null) {
                      showAlertDialog('Harap pilih jenis pekerjaan', context);
                      return;
                    }

                    if (_selectedBulan == null) {
                      showAlertDialog('Harap pilih bulan', context);
                      return;
                    }
                    if (_tahunController.text == '') {
                      showAlertDialog('Harap isi tahun', context);
                      return;
                    }

                    dynamic data = {
                      'company_id': idPerusahaan,
                      'title': _judulPekerjaanController.text,
                      'description': _keteranganController.text,
                      'master_employment_type_id':
                          _selectedJenisPekerjaan['id'],
                      'jobseeker_id': widget.lamaran['jobseeker_id'],
                      'company_name': widget.lamaran['company_name'],
                      'is_currently_working': 1,
                      'start_month': _selectedBulan,
                      'start_year': _tahunController.text,
                      // 'created_at': DateTime.now().millisecondsSinceEpoch,
                      // 'created_by': idPerusahaan,
                    };

                    showLoaderDialog(
                        context: context, message: 'Harap tunggu..');

                    _simpan(dataBody: data);
                  },
                  child: const Row(
                    children: [Icon(Icons.save), Text('Simpan')],
                  )),
            ),
          ]),
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
          )
        ],
      ),
    );
  }

  _getJenisPekerjaan() {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getJenisPekerjaan(token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _jenisPekerjaan.addAll(response['data']);
                  for (var jenisPekerjaan in _jenisPekerjaan) {
                    _jenisPekerjaanString.add(jenisPekerjaan['name']);
                  }
                  log('jenis pekerjaan result $response');
                  _isLoadingJenisPekerjaan = false;
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
