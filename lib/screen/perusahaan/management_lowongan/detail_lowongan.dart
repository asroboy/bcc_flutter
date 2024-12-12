import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_loading_dialog.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/data_pelamar_kerja.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/tambah_lowongan.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/header_label.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/row_data.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class DetailLowongan extends StatefulWidget {
  const DetailLowongan({super.key, this.lowongan});

  final dynamic lowongan;

  @override
  State<DetailLowongan> createState() => _DetailLowonganState();
}

class _DetailLowonganState extends State<DetailLowongan> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool isLoading = true;
  final ApiHelper _apiHelper = ApiHelper();

  _deleteLowongan() {
    BccLoadingDialog bccLoadingDialog =
        BccLoadingDialog(context: context, message: 'Loading...');

    bccLoadingDialog.showLoaderDialog();

    String token = loginInfo['data']['token'];
    String lowonganId = widget.lowongan['id'];
    // String idPerusahaan = loginInfo['data']['id'];
    _apiPerusahaanCall
        .deleteLowonganPekerjaan(
      token: token,
      lowonganId: lowonganId,
    )
        .then(
      (value) {
        log('update result $value');
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  bccLoadingDialog.dismiss();
                  showAlertDialogWithAction('Data berhasil dihapus', context,
                      () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop('OK');
                  }, 'Ok');
                });
              });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime tanggalKadaluarsa = DateFormat("yyyy-MM-dd")
        .parse(widget.lowongan['vacancies_expired'].toString());
    String tanggalKadaluarsaString =
        DateFormat("dd MMMM yyyy").format(tanggalKadaluarsa);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lowongan'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          HeaderLabel(label: widget.lowongan['title']),
          RowData(
            label: 'Deskripsi',
            isHtml: widget.lowongan['description'].toString().contains('<p>')
                ? true
                : false,
            value: widget.lowongan['description'] ?? '',
          ),
          RowData(
            label: 'Jenis Pekerjaan',
            value: widget.lowongan['master_employment_type_name'] ?? '',
          ),
          RowData(
            label: 'Level Pekerjaan',
            value: widget.lowongan['master_job_level_name'] ?? '',
          ),
          RowData(
            label: 'Kota/Kab.',
            value:
                '${widget.lowongan['master_city_name']} - ${widget.lowongan['master_province_name']}',
          ),
          RowData(
            label: 'Gaji',
            value: widget.lowongan['is_show_salary'] == '0'
                ? 'Tidak ditampilkan'
                : ('${widget.lowongan['range_salary_from']} s.d ${widget.lowongan['range_salary_to']}'),
          ),
          RowData(
            label: 'Kadaluarsa',
            value: tanggalKadaluarsaString,
          ),
          Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    // Checkbox(
                    //     value: widget.lowongan['status'] == 'Aktif',
                    //     onChanged: (value) {}),
                    Text(
                      widget.lowongan['status'],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: widget.lowongan['status'] == 'Aktif'
                              ? Colors.green
                              : Colors.red),
                    )
                  ]),
                ],
              )),
          const Padding(padding: EdgeInsets.only(top: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {
                    showAlertDialogWithAction2(
                        'Apakah Kamu yakin menghapus data ini?', context, () {
                      Navigator.of(context).pop();
                    }, () {
                      Navigator.of(context).pop();
                      _deleteLowongan();
                    }, 'Batal', 'OK');
                  },
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red)),
                  child: const Row(
                    children: [Icon(Icons.delete)],
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 5),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DataPelamarKerja(
                        lowongan: widget.lowongan,
                      ),
                    ));
                  },
                  child: const Row(
                    children: [Icon(Icons.people_alt)],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 15),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        builder: (context) => TambahLowongan(
                          label: 'Ubah Lowongan',
                          lowongan: widget.lowongan,
                        ),
                      ))
                          .then(
                        (value) {
                          if (value == 'OK') {
                            showAlertDialogWithAction(
                                'Data telah diupdate, klik OK untuk kembali mereload data',
                                context, () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop('OK');
                            }, 'OK');
                          }
                        },
                      );
                    },
                    child: const Row(
                      children: [Icon(Icons.edit)],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
