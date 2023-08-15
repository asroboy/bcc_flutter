import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/cari_jobs.dart';
import 'package:bcc/screen/landing/cari_lokasi.dart';
import 'package:bcc/screen/landing/cari_perusahaan.dart';
import 'package:flutter/material.dart';

class PerusahaanListScreen extends StatefulWidget {
  const PerusahaanListScreen({super.key});

  @override
  State<PerusahaanListScreen> createState() => _PerusahaanListScreenState();
}

class _PerusahaanListScreenState extends State<PerusahaanListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Constants.colorBiruGelap,
        elevation: 0,
      ),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 180,
                decoration: BoxDecoration(
                    color: Constants.colorBiruGelap,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              ),
              Container(
                height: 180,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg_batik_detil.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
                child: Column(children: [
                  const CariJobs(),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: CariLokasi(),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.1,
                        child: CariPerusahaan(),
                      )
                    ],
                  )
                ]),
              )
            ],
          ),
          Center(
            child: Card(
              margin: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 10,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: ElevatedButton(
                            onPressed: () {}, child: Text('Filter')),
                      ),
                      Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: ElevatedButton(
                              onPressed: () {}, child: Text('Full Time'))),
                      Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: ElevatedButton(
                              onPressed: () {}, child: Text('Part Time'))),
                      ElevatedButton(onPressed: () {}, child: Text('Magang'))
                    ],
                  )
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                  margin:
                      EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
                  child: Padding(
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Image.asset(
                                      'assets/images/dummy_logo_pt.png',
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'PT Kerja Keras',
                                        style: TextStyle(
                                            color: Constants.colorBiruGelap,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Text('Perusahaan tanpa henti'),
                                      const Text('10 Lowongan'),
                                      const Text('20 Pelamar'),
                                    ],
                                  )
                                ]),
                          ),
                          Positioned(
                              top: -15,
                              right: 5,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.bookmark,
                                    color: Colors.green,
                                  ))),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Constants.colorBiruGelap,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10))),
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, bottom: 5, top: 5),
                                child: const Text(
                                  '5 Hari yang lalu',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ))
                        ],
                      )));
            },
          )
        ],
      ),
    );
  }
}
