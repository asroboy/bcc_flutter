import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/bccwidgets/bcc_row_info2.dart';
import 'package:flutter/material.dart';

import 'pekerjaan_disimpan.dart';

class CardListPekerjaan extends StatelessWidget {
  const CardListPekerjaan(
      {super.key, this.whishedJob, required this.showAjukanLamaran});

  final dynamic whishedJob;
  final bool showAjukanLamaran;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 5),
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
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            whishedJob['title'],
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
                                info: '${whishedJob['company_name']}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: BccRowInfo2(
                                icon: const Icon(
                                  Icons.pin_drop_outlined,
                                  size: 19,
                                ),
                                info:
                                    '${whishedJob['master_city_name']} ${whishedJob['master_province_name']}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: BccRowInfo2(
                                icon: const Icon(
                                  Icons.timer_outlined,
                                  size: 19,
                                ),
                                info:
                                    'Lowongan aktif sampai ${whishedJob['vacancies_expired']}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: BccRowInfo2(
                                icon: const Icon(
                                  Icons.watch_later_outlined,
                                  size: 19,
                                ),
                                info:
                                    'Dibuat pada ${whishedJob['created_at']}'),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 5),
                            child: BccRowInfo2(
                                icon: const Icon(
                                  Icons.people_alt_outlined,
                                  size: 19,
                                ),
                                info:
                                    '${whishedJob['total_application']} pelamar'),
                          ),
                          whishedJob['company_job_application_status'] != null
                              ? Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.only(
                                      //     top: 5,
                                      //     bottom: 5,
                                      //     right: 10,
                                      bottom: 10),
                                  // color: Colors.blue[100],
                                  child: Text(
                                    whishedJob['company_job_application_status'] ==
                                            'PENDING'
                                        ? 'Status Lamaran Terkirim'
                                        : 'Status ${whishedJob['company_job_application_status']}',
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
                                      '${whishedJob['master_employment_type_name']}')),
                              Container(
                                  margin: const EdgeInsets.only(right: 10),
                                  padding: const EdgeInsets.only(
                                      top: 5, bottom: 5, right: 10, left: 10),
                                  color: Colors.green[100],
                                  child: Text(
                                      '${whishedJob['master_job_level_name']}')),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PekerjaanDisimpan(
                                        jobWhish: whishedJob,
                                        showAjukanLamaran: showAjukanLamaran,
                                      )));
                            },
                            icon: const Icon(Icons.remove_red_eye_outlined),
                            label: const Text('Detail'),
                          )
                        ]),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
