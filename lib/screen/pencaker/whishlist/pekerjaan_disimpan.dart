import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_label.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/bccwidgets/bcc_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/bccwidgets/bcc_row_info1.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get_storage/get_storage.dart';

import '../../../bccwidgets/bcc_row_info2.dart';

class PekerjaanDisimpan extends StatefulWidget {
  const PekerjaanDisimpan({super.key, this.jobWhish});

  final dynamic jobWhish;
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
    return Scaffold(
        appBar: AppBar(
          title: const Text('Pekerjaan Disimpan'),
        ),
        body: ListView(children: [
          Card(
              margin: const EdgeInsets.only(
                  left: 15, right: 15, top: 10, bottom: 5),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, left: 15, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
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
                                  padding: const EdgeInsets.only(top: 5),
                                  child: BccRowInfo2(
                                      icon: const Icon(
                                        Icons.pin_drop_outlined,
                                        size: 19,
                                      ),
                                      info:
                                          '${widget.jobWhish['master_city_name']} ${widget.jobWhish['master_province_name']}'),
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
                    Html(
                      data: widget.jobWhish['description'],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ElevatedButton(
                            onPressed: () {},
                            child: const Text('Ajukan lamaran'))
                      ],
                    )
                  ],
                ),
              ))
        ]));
  }
}
