import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_card_job.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/banner_register.dart';
import 'package:bcc/screen/landing/cari_jobs.dart';
import 'package:bcc/screen/landing/cari_lokasi.dart';
import 'package:bcc/screen/landing/cari_perusahaan.dart';
import 'package:bcc/screen/landing/landing_grid.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();
  bool _isLoadingLowongan = false;
  bool _isLoadingPerusahaan = false;

  List<dynamic> dataLowonganPopuler = [];
  List<dynamic> dataPerusahaanTerbaru = [];

  _fetchLowonganPopuler() {
    Future<dynamic> reqLowonganPopuler =
        _apiCall.getLowonganPopuler('jobseeker/Jobboard');
    reqLowonganPopuler.then((value) {
      log('result $value');
      _apiHelper.apiCallResponseHandler(value, context, (response) {
        if (mounted) {
          setState(() {
            _isLoadingLowongan = false;
            dataLowonganPopuler.addAll(response['data']);
          });
        }
      });
    });
  }

  _fetchPerusahaanTerbaru() {
    Future<dynamic> reqLowonganPopuler = _apiCall.getData('Perusahaan');
    reqLowonganPopuler.then((value) {
      log('result $value');
      _apiHelper.apiCallResponseHandler(value, context, (response) {
        if (mounted) {
          setState(() {
            _isLoadingPerusahaan = false;
            dataPerusahaanTerbaru.addAll(response['data']);
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          child: Image.asset('assets/images/bg_header_landing.png',
              fit: BoxFit.fill),
        ),
        Text(
          'Cari Pekerjaan Anda disini',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Constants.colorBiruGelap,
            fontSize: 18,
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.24,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 15)),
        const CariJobs(),
        const Padding(padding: EdgeInsets.only(top: 5)),
        const CariLokasi(),
        const Padding(padding: EdgeInsets.only(top: 5)),
        const CariPerusahaan(),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            'Pencarian Terpopuler : Designer, Developer, Web, IOS, PHP',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Constants.colorBiruGelap,
              fontSize: 12,
              fontFamily: 'Jost',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.24,
            ),
          ),
        ),
        const LandingGrid(),
        const Center(
          child: Text(
            'Pekerjaan Terpopuler',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Jost',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.14,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        SizedBox(
          height: 310,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              BccCardJob(),
              BccCardJob(),
              BccCardJob(),
              BccCardJob(),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        const BannerRegister(),
        const Padding(padding: EdgeInsets.only(top: 20)),
        const Center(
          child: Text(
            'Perusahaan Terbaru',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontFamily: 'Jost',
              fontWeight: FontWeight.w500,
              letterSpacing: -0.14,
            ),
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
        SizedBox(
          height: 310,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              BccCardJob(),
              BccCardJob(),
              BccCardJob(),
              BccCardJob(),
            ],
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),

        // const Padding(padding: EdgeInsets.only(top: 20)),
        // _isLoadingLowongan
        //     ? const BccCircleLoadingIndicator()
        //     : SizedBox(
        //         height: 310,
        //         child: ListView.builder(
        //           scrollDirection: Axis.horizontal,
        //           itemCount: dataLowonganPopuler.length,
        //           itemBuilder: (context, index) {
        //             dynamic dataLowongan = dataLowonganPopuler[index];
        //             return BccCardJob(
        //               dataLowongan: dataLowongan,
        //             );
        //           },
        //         ),
        //       ),
        // // const Padding(padding: EdgeInsets.only(top: 20)),
        // const Padding(padding: EdgeInsets.only(top: 20)),
        // const Center(
        //   child: Text(
        //     'Perusahaan Terbaru',
        //     style: TextStyle(
        //       color: Colors.black,
        //       fontSize: 18,
        //       fontFamily: 'Jost',
        //       fontWeight: FontWeight.w500,
        //       letterSpacing: -0.14,
        //     ),
        //   ),
        // ),
        // const Padding(padding: EdgeInsets.only(top: 20)),
        // _isLoadingPerusahaan
        //     ? const BccCircleLoadingIndicator()
        //     : SizedBox(
        //         height: 310,
        //         child: ListView.builder(
        //           scrollDirection: Axis.horizontal,
        //           itemCount: dataPerusahaanTerbaru.length,
        //           itemBuilder: (context, index) {
        //             dynamic dataPerusahaan = dataPerusahaanTerbaru[index];
        //             return BccCardPerusahaan(dataPerusahaan: dataPerusahaan);
        //           },
        //         )),
        // const Padding(padding: EdgeInsets.only(top: 20)),
      ]),
    );
  }
}
