import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_label.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/bccwidgets/bcc_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/bccwidgets/bcc_row_info2.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/whishlist/pekerjaan_disimpan.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ListPekerjaanDisimpan extends StatefulWidget {
  const ListPekerjaanDisimpan({super.key});

  @override
  State<ListPekerjaanDisimpan> createState() => _ListPekerjaanDisimpanState();
}

class _ListPekerjaanDisimpanState extends State<ListPekerjaanDisimpan> {
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  int idPencaker = 0;

  int _page = 0;
  final int _max = 20;
  String search = '';

  bool _isLoadingLowongan = false;
  bool _isLoadMore = false;
  bool _lastpage = false;
  int _totalPage = 0;
  final List<dynamic> _dataLowonganDiharapkan = [];

  _fetchPekerjaanDisimpan() {
    Future<dynamic> reqLowonganPopuler = _apiCall.getLowonganWhishList(
        Constants.pathWishList, _page, _max, idPencaker);
    reqLowonganPopuler.then((value) {
      // log('result $value');
      if (mounted) {
        _apiHelper.apiCallResponseHandler(value, context, (response) {
          setState(() {
            _isLoadingLowongan = false;
            _isLoadMore = false;
            List<dynamic> dresponse = response['data'];
            _dataLowonganDiharapkan.addAll(dresponse);

            dynamic metadata = response['meta'];

            _totalPage = metadata['totalPage'];
            if (_page < _totalPage) {
              _page++;
            } else {
              _lastpage = true;
            }
          });
        });
      }
    });
  }

  @override
  void initState() {
    idPencaker = int.parse(loginInfo['data']['id']);
    _isLoadingLowongan = true;
    _fetchPekerjaanDisimpan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pekerjaan Disimpan'),
      ),
      body: _isLoadingLowongan
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _dataLowonganDiharapkan.isEmpty
              ? const BccNoDataInfo()
              : ListView.builder(
                  itemCount: _dataLowonganDiharapkan.length,
                  itemBuilder: (context, index) {
                    dynamic whishedJob = _dataLowonganDiharapkan[index];
                    log('job $whishedJob');
                    return Card(
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
                                    child: whishedJob != null
                                        ? Image.asset(
                                            'assets/images/dummy_logo_pt.png',
                                            width: 70,
                                            height: 70,
                                          )
                                        : (whishedJob['company_logo'] != null &&
                                                whishedJob['company_logo'] != ''
                                            ? Image.network(
                                                whishedJob['company_logo'],
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
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            whishedJob['title'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const BccLineSparator(
                                            padding: EdgeInsets.all(5),
                                            margin: EdgeInsets.only(
                                                top: 5, bottom: 5),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: BccRowInfo2(
                                                icon: const Icon(
                                                  Icons.business_rounded,
                                                  size: 19,
                                                ),
                                                info:
                                                    '${whishedJob['company_name']}'),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: BccRowInfo2(
                                                icon: const Icon(
                                                  Icons.pin_drop_outlined,
                                                  size: 19,
                                                ),
                                                info:
                                                    '${whishedJob['master_city_name']} ${whishedJob['master_province_name']}'),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: BccRowInfo2(
                                                icon: const Icon(
                                                  Icons.timer_outlined,
                                                  size: 19,
                                                ),
                                                info:
                                                    'Lowongan aktif sampai ${whishedJob['vacancies_expired']}'),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: BccRowInfo2(
                                                icon: const Icon(
                                                  Icons.watch_later_outlined,
                                                  size: 19,
                                                ),
                                                info:
                                                    'Dibuat pada ${whishedJob['created_at']}'),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, bottom: 5),
                                            child: BccRowInfo2(
                                                icon: const Icon(
                                                  Icons.people_alt_outlined,
                                                  size: 19,
                                                ),
                                                info:
                                                    '${whishedJob['total_application']} pelamar'),
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PekerjaanDisimpan(
                                                            jobWhish:
                                                                whishedJob,
                                                          )));
                                            },
                                            icon: const Icon(
                                                Icons.remove_red_eye_outlined),
                                            label: const Text('Detail'),
                                          )
                                        ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ));
                  },
                ),
    );
  }
}
