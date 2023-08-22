import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_card_perusahaan_simple.dart';
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
              return BccCardPerusahaanSimple();
            },
          )
        ],
      ),
    );
  }
}
