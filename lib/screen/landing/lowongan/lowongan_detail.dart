import 'package:bcc/bccwidgets/bcc_label.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/bccwidgets/bcc_row_info2.dart';
import 'package:flutter/material.dart';

import 'package:flutter_html/flutter_html.dart';

class LowonganDetail extends StatefulWidget {
  const LowonganDetail({super.key, this.job});

  final dynamic job;
  @override
  State<LowonganDetail> createState() => _LowonganDetailState();
}

class _LowonganDetailState extends State<LowonganDetail> {
  @override
  Widget build(BuildContext context) {
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {},
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
}
