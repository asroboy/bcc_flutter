import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_card_perusahaan_simple.dart';
import 'package:bcc/bccwidgets/bcc_circle_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_load_more_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/cari_jobs.dart';
import 'package:bcc/screen/landing/cari_lokasi.dart';
import 'package:bcc/screen/landing/cari_perusahaan.dart';
import 'package:bcc/screen/landing/perusahaan/perusahaan_detail_screen.dart';
import 'package:flutter/material.dart';

class PerusahaanListScreen extends StatefulWidget {
  const PerusahaanListScreen({super.key});

  @override
  State<PerusahaanListScreen> createState() => _PerusahaanListScreenState();
}

class _PerusahaanListScreenState extends State<PerusahaanListScreen> {
  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  bool _isLoadingDataPerusahaan = false;
  bool _isLoadingMoreData = false;
  List<dynamic> _dataPerusahaan = [];
  final int _maxPerPage = 10;
  int _page = 1;
  bool _isLastePage = false;

  _fetchPerusahaanTerbaru() {
    Future<dynamic> reqLowonganPopuler = _apiCall.getDataPendukung(
        Constants.pathLandingCompany +
            ('?limit=10&page=1&orderBy=id&sort=desc'));
    reqLowonganPopuler.then((value) {
      // log('result $value');
      if (mounted) {
        _apiHelper.apiCallResponseHandler(value, context, (response) {
          setState(() {
            _isLoadingDataPerusahaan = false;
            _isLoadingMoreData = false;
            List<dynamic> dataResponse = response['data'];
            _dataPerusahaan.addAll(dataResponse);

            if (dataResponse.length < _maxPerPage) {
              _isLastePage = true;
            } else {
              _page++;
            }
          });
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoadingDataPerusahaan = true;
    _fetchPerusahaanTerbaru();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 231, 231),
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: const CariLokasi(),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.1,
                        child: const CariPerusahaan(),
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
                            onPressed: () {}, child: const Text('Filter')),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Full Time'))),
                      Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Text('Part Time'))),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Magang'))
                    ],
                  )
                ],
              ),
            ),
          ),
          _isLoadingDataPerusahaan
              ? const BccLoadingIndicator()
              : _dataPerusahaan.isEmpty
                  ? const BccNoDataInfo()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          _dataPerusahaan.length + (_isLastePage ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index == _dataPerusahaan.length) {
                          if (_isLoadingMoreData) {
                            return const BccLoadMoreLoadingIndicator();
                          }

                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLoadingMoreData = true;
                                    });

                                    _fetchPerusahaanTerbaru();
                                  },
                                  child: const Text('Muat data selanjutnya')),
                            ),
                          );
                        }

                        dynamic perusahaan = _dataPerusahaan[index];
                        return BccCardPerusahaanSimple(
                          perusahaan: perusahaan,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  const PerusahaanDetailScreen(),
                            ));
                          },
                        );
                      },
                    )
        ],
      ),
    );
  }
}
