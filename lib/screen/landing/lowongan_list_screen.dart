import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_card_job_simple.dart';
import 'package:bcc/bccwidgets/bcc_circle_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_load_more_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/cari_jobs.dart';
import 'package:bcc/screen/landing/cari_lokasi.dart';
import 'package:bcc/screen/landing/cari_perusahaan.dart';
import 'package:flutter/material.dart';

class LowonganListScreen extends StatefulWidget {
  const LowonganListScreen({super.key});

  @override
  State<LowonganListScreen> createState() => _LowonganListScreenState();
}

class _LowonganListScreenState extends State<LowonganListScreen> {
  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  int _page = 1;
  final int _max = 10;
  bool _lastpage = false;

  int _totalPage = 0;
  bool _isLoadingLowongan = false;
  bool _isLoadMore = false;
  final List<dynamic> _dataLowonganPopuler = [];
  String? search;
  int? companyId;
  int? cityId;

  final TextEditingController _searchTextController = TextEditingController();

  _fetchLowonganPopuler() {
    Future<dynamic> reqLowonganPopuler = _apiCall.getLowonganPaged(
        Constants.pathJobboard, _page, _max, search, companyId, cityId);
    reqLowonganPopuler.then((value) {
      // log('result $value');
      if (mounted) {
        _apiHelper.apiCallResponseHandler(value, context, (response) {
          setState(() {
            _isLoadingLowongan = false;
            _isLoadMore = false;
            List<dynamic> dresponse = response['data'];
            _dataLowonganPopuler.addAll(dresponse);

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

  _reloadData() {
    setState(() {
      _isLoadingLowongan = true;
      _totalPage = 0;
      _page = 1;
      _lastpage = false;
      _dataLowonganPopuler.clear();
    });

    _fetchLowonganPopuler();
  }

  @override
  void initState() {
    super.initState();
    _isLoadingLowongan = true;
    _fetchLowonganPopuler();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.colorBiruGelap,
        elevation: 0,
        toolbarHeight: 0,
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
                  CariJobs(
                      controller: _searchTextController,
                      onPressed: () {
                        setState(() {
                          search = _searchTextController.text;
                          _reloadData();
                        });
                      }),
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
                            onPressed: () {}, child: const Text('Filter')),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(right: 5),
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
          _isLoadingLowongan
              ? const Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : _dataLowonganPopuler.isEmpty
                  ? const BccNoDataInfo()
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          _dataLowonganPopuler.length + (_lastpage ? 0 : 1),
                      itemBuilder: (context, index) {
                        if (index == _dataLowonganPopuler.length) {
                          if (_isLoadMore) {
                            return const BccLoadMoreLoadingIndicator();
                          }
                          return Center(
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isLoadMore = true;
                                  });
                                  _fetchLowonganPopuler();
                                },
                                child: const Text('Muat data selanjutnya')),
                          );
                        }

                        dynamic dataLowongan = _dataLowonganPopuler[index];
                        return BccCardJobSimple(
                          dataLowongan: dataLowongan,
                        );
                      },
                    )
        ],
      ),
    );
  }
}
