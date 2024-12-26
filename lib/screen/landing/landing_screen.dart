import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_card_job.dart';
import 'package:bcc/bccwidgets/bcc_card_perusahaan.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/banner_register.dart';
import 'package:bcc/screen/landing/landing_grid.dart';
import 'package:bcc/screen/landing/perusahaan/perusahaan_detail_screen.dart';
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

  final List<dynamic> _dataLowonganPopuler = [];
  final List<dynamic> _dataPerusahaanTerbaru = [];

  dynamic contentSetting;
  // bool _isLoadSetting = true;

  _getContentSetting() {
    _apiCall.getSetting().then((value) {
      setState(() {
        contentSetting = value['data'];
        log('contentSetting $contentSetting');
        // _isLoadSetting = false;
      });
    });
  }

  _fetchLowonganPopuler() {
    Future<dynamic> reqLowonganPopuler =
        _apiCall.getLowonganPopuler(Constants.pathJobboard);
    reqLowonganPopuler.then((value) {
      // log('result $value');
      if (mounted) {
        _apiHelper.apiCallResponseHandler(
            response: value,
            context: context,
            onSuccess: (response) {
              setState(() {
                _isLoadingLowongan = false;
                _dataLowonganPopuler.addAll(response['data']);
              });
            });
      }
    });
  }

  _fetchPerusahaanTerbaru() {
    Future<dynamic> reqLowonganPopuler = _apiCall.getDataPendukung(
        Constants.pathLandingCompany +
            ('?limit=10&page=1&orderBy=id&sort=desc'));
    reqLowonganPopuler.then((value) {
      // log('result $value');
      if (mounted) {
        _apiHelper.apiCallResponseHandler(
            response: value,
            context: context,
            onSuccess: (response) {
              setState(() {
                _isLoadingPerusahaan = false;
                _dataPerusahaanTerbaru.addAll(response['data']);
              });
            });
      }
    });
  }

  @override
  void initState() {
    _isLoadingPerusahaan = true;
    _isLoadingLowongan = true;

    _getContentSetting();
    _fetchPerusahaanTerbaru();
    _fetchLowonganPopuler();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: ListView(children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              (contentSetting != null)
                  ? SizedBox(
                      child: Image.network(
                        contentSetting['background_bupati'],
                        fit: BoxFit.fill,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                              'assets/images/bg_header_landing.png',
                              fit: BoxFit.fill);
                        },
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(0)),
                      ),
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      child: const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color: Colors.white,
                        ),
                      )),
              (contentSetting != null)
                  ? SizedBox(
                      height: 180,
                      child: Center(
                        child: Image.network(
                          contentSetting['bupati'],
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center();
                          },
                        ),
                      ),
                    )
                  : const Center()
            ],
          ),
        ),
        Text(
          'Bogor Career Center',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Constants.colorBiruGelap,
            fontSize: 18,
            fontFamily: 'Jost',
            fontWeight: FontWeight.w500,
            letterSpacing: -0.24,
          ),
        ),
        const LandingGrid(),
        const Center(
          child: Text(
            'Pekerjaan Terbaru',
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
            height: 280,
            child: _isLoadingLowongan
                ? const Center(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _dataLowonganPopuler.length,
                    itemBuilder: (context, index) {
                      dynamic lowongan = _dataLowonganPopuler[index];
                      return BccCardJob(
                        dataLowongan: lowongan,
                      );
                    },
                  )),
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
          height: 280,
          child: _isLoadingPerusahaan
              ? const Center(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : ListView.builder(
                  itemCount: _dataPerusahaanTerbaru.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    dynamic perusahaan = _dataPerusahaanTerbaru[index];
                    return BccCardPerusahaan(
                      dataPerusahaan: perusahaan,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PerusahaanDetailScreen(
                                  perusahaan: perusahaan,
                                )));
                      },
                    );
                  },
                ),
        ),
        const Padding(padding: EdgeInsets.only(top: 20)),
      ]),
    );
  }
}
