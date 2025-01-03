import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:get_storage/get_storage.dart';

import '../../../bccwidgets/bcc_row_info2.dart';

class PekerjaanDisimpan extends StatefulWidget {
  const PekerjaanDisimpan(
      {super.key, this.jobWhish, required this.showAjukanLamaran});

  final dynamic jobWhish;
  final bool showAjukanLamaran;

  @override
  State<PekerjaanDisimpan> createState() => _PekerjaanDisimpanState();
}

class _PekerjaanDisimpanState extends State<PekerjaanDisimpan> {
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  int idPencaker = 0;

  // int _page = 0;
  // final int _max = 20;
  // String search = '';

  // bool _isLoadingLowongan = false;
  // bool _isLoadMore = false;
  // bool _lastpage = false;
  // int _totalPage = 0;
  // final List<dynamic> _dataLowonganDiharapkan = [];

  // _fetchPekerjaanDisimpan() {
  //   Future<dynamic> reqLowonganPopuler = _apiCall.getLowonganWhishList(
  //       Constants.pathWishList, _page, _max, idPencaker);
  //   reqLowonganPopuler.then((value) {
  //     // log('result $value');
  //     if (mounted) {
  //       _apiHelper.apiCallResponseHandler(value, context, (response) {
  //         setState(() {
  //           _isLoadingLowongan = false;
  //           _isLoadMore = false;
  //           List<dynamic> dresponse = response['data'];
  //           _dataLowonganDiharapkan.addAll(dresponse);

  //           dynamic metadata = response['meta'];

  //           _totalPage = metadata['totalPage'];
  //           if (_page < _totalPage) {
  //             _page++;
  //           } else {
  //             _lastpage = true;
  //           }
  //         });
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    idPencaker = int.parse(loginInfo['data']['id']);
    // _isLoadingLowongan = true;
    // _fetchPekerjaanDisimpan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('job ${widget.jobWhish}');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pekerjaan Disimpan'),
        ),
        body: ListView(children: [
          Card(
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
                          child: widget.jobWhish != null
                              ? Image.asset(
                                  'assets/images/dummy_logo_pt.png',
                                  width: 70,
                                  height: 70,
                                )
                              : (widget.jobWhish['company_logo'] != null &&
                                      widget.jobWhish['company_logo'] != ''
                                  ? Image.network(
                                      widget.jobWhish['company_logo'],
                                      height: 70,
                                      width: 70,
                                    )
                                  : Image.asset(
                                      'assets/images/dummy_logo_pt.png',
                                      height: 70,
                                      width: 70,
                                    )),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.65,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.jobWhish['title'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
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
                                      info:
                                          '${widget.jobWhish['company_name']}'),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 10),
                                  child: BccRowInfo2(
                                      icon: const Icon(
                                        Icons.pin_drop_outlined,
                                        size: 19,
                                      ),
                                      info:
                                          '${widget.jobWhish['master_city_name']} ${widget.jobWhish['master_province_name']}'),
                                ),
                                widget.jobWhish[
                                            'company_job_application_status'] !=
                                        null
                                    ? Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        // padding: const EdgeInsets.only(
                                        //     top: 5,
                                        //     bottom: 5,
                                        //     right: 10,
                                        //     left: 10),
                                        // color: Colors.blue[100],
                                        child: Text(
                                          widget.jobWhish[
                                                      'company_job_application_status'] ==
                                                  'PENDING'
                                              ? 'Status Lamaran Terkirim'
                                              : 'Status ${widget.jobWhish['company_job_application_status']}',
                                          style: TextStyle(
                                              color: Colors.blue[900]),
                                        ))
                                    : const Center(),
                                const Padding(
                                  padding: EdgeInsets.only(top: 10),
                                ),
                                Row(
                                  children: [
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            right: 10,
                                            left: 10),
                                        color: Colors.blue[100],
                                        child: Text(
                                            '${widget.jobWhish['master_employment_type_name']}')),
                                    Container(
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.only(
                                            top: 5,
                                            bottom: 5,
                                            right: 10,
                                            left: 10),
                                        color: Colors.green[100],
                                        child: Text(
                                            '${widget.jobWhish['master_job_level_name']}')),
                                  ],
                                ),
                              ]),
                        ),
                      ],
                    ),
                    const BccLineSparator(
                        margin: EdgeInsets.only(bottom: 10, top: 10)),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: BccRowInfo2(
                          icon: const Icon(
                            Icons.timer_outlined,
                            size: 19,
                          ),
                          info:
                              'Lowongan aktif sampai ${widget.jobWhish['vacancies_expired']}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: BccRowInfo2(
                          icon: const Icon(
                            Icons.watch_later_outlined,
                            size: 19,
                          ),
                          info: 'Dibuat pada ${widget.jobWhish['created_at']}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: BccRowInfo2(
                          icon: const Icon(
                            Icons.people_alt_outlined,
                            size: 19,
                          ),
                          info:
                              '${widget.jobWhish['total_application']} pelamar'),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: BccLineSparator(
                          margin: EdgeInsets.only(bottom: 10, top: 10)),
                    ),
                    widget.showAjukanLamaran &&
                            widget.jobWhish['company_job_application_status'] ==
                                null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    _ajukanLamaran(widget.jobWhish['id']);
                                  },
                                  child: const Text('Ajukan lamaran'))
                            ],
                          )
                        : const Center(),
                    Text(
                      widget.jobWhish['description'],
                    ),
                  ],
                ),
              ))
        ]));
  }

  _ajukanLamaran(String jobId) {
    String token = loginInfo['data']['token'];
    if (token == '') {
      showAlertDialogWithAction(
          'Silahkan login terlebih dahulu jika ingin mengirimkan lamaran pekerjaan',
          context,
          () {},
          'OK');
    } else {
      dynamic body = {'jobseeker_id': idPencaker, 'company_job_id': jobId};
      Future<dynamic> reqLowonganPopuler = _apiCall.ajukanLamaran(body, token);
      reqLowonganPopuler.then((value) {
        // log('result $value');
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                showAlertDialog('Lamaran Kamu sudah diajukan', context);
              });
        }
      });
    }
  }
}
