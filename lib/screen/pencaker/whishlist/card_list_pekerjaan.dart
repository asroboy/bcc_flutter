import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/bccwidgets/bcc_row_info2.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/riwayat/riwayat_lamaran_detail.dart';
import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/row_data_info.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'pekerjaan_disimpan.dart';

class CardListPekerjaan extends StatefulWidget {
  const CardListPekerjaan(
      {super.key,
      this.whishedJob,
      required this.showAjukanLamaran,
      this.onRemove,
      required this.isWhishList});

  final dynamic whishedJob;
  final bool showAjukanLamaran;
  final bool isWhishList;
  final Function? onRemove;

  @override
  State<CardListPekerjaan> createState() => _CardListPekerjaanState();
}

class _CardListPekerjaanState extends State<CardListPekerjaan> {
  final ApiCall _apiCall = ApiCall();
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  final ApiHelper _apiHelper = ApiHelper();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  final List<dynamic> _jadwal = [];
  dynamic jadwal;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (!widget.isWhishList) {
      String token = loginInfo['data']['token'];
      String idPencaker = loginInfo['data']['id'];
      _isLoading = true;
      _ambilJadwalInterview(token, idPencaker, widget.whishedJob['id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: widget.whishedJob == null
                        ? Image.asset(
                            'assets/images/dummy_logo_pt.png',
                            width: 50,
                            height: 50,
                          )
                        : (widget.whishedJob['company_logo'] != null &&
                                widget.whishedJob['company_logo'] != ''
                            ? Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.5),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(45)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          widget.whishedJob['company_logo']),
                                      fit: BoxFit.fill),
                                ),
                              )
                            : Image.asset(
                                'assets/images/dummy_logo_pt.png',
                                height: 50,
                                width: 50,
                              )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.whishedJob['title'],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const BccLineSparator(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: BccRowInfo2(
                                icon: const Icon(
                                  Icons.business_rounded,
                                  size: 19,
                                ),
                                info: '${widget.whishedJob['company_name']}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: BccRowInfo2(
                                icon: const Icon(
                                  Icons.pin_drop_outlined,
                                  size: 19,
                                ),
                                info:
                                    '${widget.whishedJob['master_city_name']} ${widget.whishedJob['master_province_name']}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: BccRowInfo2(
                                icon: const Icon(
                                  Icons.timer_outlined,
                                  size: 19,
                                ),
                                info:
                                    'Lowongan aktif sampai ${widget.whishedJob['vacancies_expired']}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: BccRowInfo2(
                                icon: const Icon(
                                  Icons.watch_later_outlined,
                                  size: 19,
                                ),
                                info:
                                    'Dibuat pada ${widget.whishedJob['created_at']}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: BccRowInfo2(
                                icon: const Icon(
                                  Icons.people_alt_outlined,
                                  size: 19,
                                ),
                                info:
                                    '${widget.whishedJob['total_application']} pelamar'),
                          ),
                          widget.whishedJob['company_job_application_status'] !=
                                  null
                              ? Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.only(
                                      //     top: 5,
                                      //     bottom: 5,
                                      //     right: 10,
                                      bottom: 10),
                                  // color: Colors.blue[100],
                                  child: Text(
                                    widget.whishedJob[
                                                'company_job_application_status'] ==
                                            'PENDING'
                                        ? 'Status Lamaran Terkirim'
                                        : 'Status ${widget.whishedJob['company_job_application_status']}',
                                    style: TextStyle(color: Colors.blue[900]),
                                  ))
                              : const Center(),
                          Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5, right: 10, left: 10),
                                  color: Colors.blue[100],
                                  child: Text(
                                      '${widget.whishedJob['master_employment_type_name']}')),
                              Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5, right: 10, left: 10),
                                  color: Colors.green[100],
                                  child: Text(
                                      '${widget.whishedJob['master_job_level_name']}')),
                            ],
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Row(children: [
                            widget.isWhishList
                                ? ElevatedButton.icon(
                                    onPressed: () {
                                      showAlertDialogWithAction2(
                                          'Yakin hapus Perkerjaan ini dari daftar?',
                                          context, () {
                                        Navigator.of(context).pop();
                                      }, () {
                                        Navigator.of(context).pop();
                                        _hapusBookmark(
                                            dataLowongan: widget.whishedJob);
                                      }, 'Batal', 'OK');
                                    },
                                    icon: const Icon(Icons.bookmark_border),
                                    label: const Text('Hapus'),
                                    style: const ButtonStyle(
                                        backgroundColor: WidgetStatePropertyAll(
                                            Colors.grey)),
                                  )
                                : const Center(),
                            const Padding(padding: EdgeInsets.only(right: 5)),
                            widget.isWhishList
                                ? ElevatedButton.icon(
                                    onPressed: () {
                                      if (widget.isWhishList) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PekerjaanDisimpan(
                                                      jobWhish:
                                                          widget.whishedJob,
                                                      showAjukanLamaran: widget
                                                          .showAjukanLamaran,
                                                    )));
                                      } else {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailRiwayatLamaranSaya(
                                                      lamaran:
                                                          widget.whishedJob,
                                                    )));
                                      }
                                    },
                                    icon: const Icon(
                                        Icons.remove_red_eye_outlined),
                                    label: const Text('Detail'),
                                  )
                                : const Center()
                          ]),
                          const BccLineSparator(
                            padding: EdgeInsets.all(5),
                            margin: EdgeInsets.only(top: 5, bottom: 5),
                          ),
                          widget.isWhishList
                              ? const Center()
                              : _showStatusLamaran(widget.whishedJob)
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  Widget _showStatusLamaran(dynamic lamaran) {
    return _isLoading
        ? const Center(
            child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: LinearProgressIndicator(),
          ))
        : SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RowDataInfo(
                    infoColor: _getColorStatus(lamaran),
                    label: 'Status',
                    info: widget.whishedJob['company_job_application_status'] ==
                            'PENDING'
                        ? 'Status Lamaran Terkirim'
                        : '${widget.whishedJob['company_job_application_status']}'),
                const Text(
                  'Jadwal Interview',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                RowDataInfo(
                    label: 'Tanggal',
                    info: jadwal == null ? '-' : jadwal['schedule_date']),
                RowDataInfo(
                    label: 'Keterangan',
                    info: jadwal == null ? '-' : jadwal['description'])
              ],
            ),
          );
  }

  _hapusBookmark({required dynamic dataLowongan}) {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];

    _apiPerusahaanCall
        .hapusnWishListLowongan(
            id: dataLowongan['jobseeker_wishlist_id'], token: token)
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                log('response: $response');
                widget.onRemove!();
                // _getBookmark(dataLowongan: dataLowongan);
              });
        }
      },
    );
  }

  Color _getColorStatus(dynamic mlowongan) {
    if (mlowongan['company_job_application_status'] == 'PENDING') {
      return Colors.orange;
    }
    if (mlowongan['company_job_application_status'] == 'ACCEPTED') {
      return const Color.fromARGB(255, 51, 135, 204);
    }
    if (mlowongan['company_job_application_status'] == 'INTERVIEW') {
      return Colors.blueGrey;
    }
    if (mlowongan['company_job_application_status'] == 'APPROVED') {
      return Colors.green;
    }
    if (mlowongan['company_job_application_status'] == 'REJECTED') {
      return const Color.fromARGB(255, 224, 33, 33);
    }
    return Colors.orange;
  }

  _ambilJadwalInterview(String token, String idPencaker, String idLowongan) {
    // String idPerusahaan = loginInfo['data']['id'];
    // String token = loginInfo['data']['token'];
    _apiCall.getJobInterview(idLowongan, idPencaker, token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _jadwal.addAll(response['data']);
                  if (_jadwal.isNotEmpty) {
                    jadwal = _jadwal[0];
                  }
                  _isLoading = false;
                });
              });
        }
      },
    );
  }
}
