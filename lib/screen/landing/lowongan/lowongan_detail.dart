import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_label.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/bccwidgets/bcc_row_info2.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/login_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';
import 'package:get_storage/get_storage.dart';

class LowonganDetail extends StatefulWidget {
  const LowonganDetail({super.key, this.job});

  final dynamic job;
  @override
  State<LowonganDetail> createState() => _LowonganDetailState();
}

class _LowonganDetailState extends State<LowonganDetail> {
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  int idPencaker = 0;

  @override
  void initState() {
    if (loginInfo != null) {
      idPencaker = int.parse(loginInfo['data']['id']);
    }

    // _isLoadingLowongan = true;
    // _fetchPekerjaanDisimpan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('${widget.job}');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lowongan Pekerjaan'),
      ),
      body: ListView(children: [
        Card(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
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
                        child: widget.job != null
                            ? Image.asset(
                                'assets/images/dummy_logo_pt.png',
                                width: 70,
                                height: 70,
                              )
                            : (widget.job['company_logo'] != null &&
                                    widget.job['company_logo'] != ''
                                ? Image.network(
                                    widget.job['company_logo'],
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
                                widget.job['title'],
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
                                    info: '${widget.job['company_name']}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: BccRowInfo2(
                                    icon: const Icon(
                                      Icons.pin_drop_outlined,
                                      size: 19,
                                    ),
                                    info:
                                        '${widget.job['master_city_name']} ${widget.job['master_province_name']}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: BccRowInfo2(
                                    icon: const Icon(
                                      Icons.timer_outlined,
                                      size: 19,
                                    ),
                                    info:
                                        'Lowongan aktif sampai ${widget.job['vacancies_expired']}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: BccRowInfo2(
                                    icon: const Icon(
                                      Icons.watch_later_outlined,
                                      size: 19,
                                    ),
                                    info:
                                        'Dibuat pada ${widget.job['created_at']}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: BccRowInfo2(
                                    icon: const Icon(
                                      Icons.people_alt_outlined,
                                      size: 19,
                                    ),
                                    info:
                                        '${widget.job['total_application']} pelamar'),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                              Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          right: 10,
                                          left: 10),
                                      color: Colors.blue[100],
                                      child: Text(
                                          '${widget.job['master_employment_type_name']}')),
                                  Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          right: 10,
                                          left: 10),
                                      color: Colors.green[100],
                                      child: Text(
                                          '${widget.job['master_job_level_name']}')),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 10),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        _ajukanLamaran(widget.job['id']);
                                      },
                                      child: const Text('Ajukan lamaran'))
                                ],
                              )
                            ]),
                      ),
                    ],
                  ),
                  const BccLineSparator(
                      margin: EdgeInsets.only(bottom: 10, top: 10)),
                  Html(
                    data: widget.job['description'],
                  ),
                ],
              ),
            ))
      ]),
    );
  }

  _ajukanLamaran(String jobId) {
    if (loginInfo == null) {
      showAlertDialogWithAction(
          'Silahkan login terlebih dahulu jika ingin mengirimkan lamaran pekerjaan',
          context, () {
        Navigator.of(context).pop();
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ));
      }, 'OK');
    } else {
      String token = loginInfo['data']['token'];
      dynamic body = {'jobseeker_id': idPencaker, 'company_job_id': jobId};
      Future<dynamic> reqLowonganPopuler = _apiCall.ajukanLamaran(body, token);
      reqLowonganPopuler.then((value) {
        // log('result $value');
        if (mounted) {
          _apiHelper.apiCallResponseHandler(value, context, (response) {
            showAlertDialog('Lamaran Kamu sudah diajukan', context);
          });
        }
      });
    }
  }
}
