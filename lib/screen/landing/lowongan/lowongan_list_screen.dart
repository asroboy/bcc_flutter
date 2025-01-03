import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_card_job_simple.dart';
import 'package:bcc/bccwidgets/bcc_load_more_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/cari_jobs.dart';
import 'package:bcc/screen/landing/lowongan/lowongan_detail.dart';
import 'package:bcc/state_management/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class LowonganListScreen extends StatefulWidget {
  const LowonganListScreen({super.key});

  @override
  State<LowonganListScreen> createState() => _LowonganListScreenState();
}

class _LowonganListScreenState extends State<LowonganListScreen> {
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

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
    String? jobseekerId = loginInfo != null ? loginInfo['data']['id'] : null;
    Future<dynamic> reqLowonganPopuler = _apiCall.getLowonganPaged(
        Constants.pathJobboard,
        _page,
        _max,
        search,
        companyId,
        cityId,
        jobseekerId);
    reqLowonganPopuler.then((value) {
      // log('result $value');
      if (mounted) {
        _apiHelper.apiCallResponseHandler(
            response: value,
            context: context,
            onSuccess: (response) {
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

  String? jenis;

  @override
  Widget build(BuildContext context) {
    return loginInfo != null
        ? Consumer(
            builder: (context, UserLoginModel model, _) =>
                _isAkunLengkap(model.profilPencaker)
                    ? getScaffold()
                    : getScaffoldFiturOff(model))
        : getScaffold();
  }

  Widget getScaffoldFiturOff(UserLoginModel model) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 231),
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
                height: 120,
                decoration: BoxDecoration(
                    color: Constants.colorBiruGelap,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              ),
              Container(
                height: 120,
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
                  CariJobs(controller: _searchTextController, onPressed: () {}),
                  const Padding(padding: EdgeInsets.only(top: 20)),
                ]),
              )
            ],
          ),
          Card(
            margin: const EdgeInsets.all(15),
            color: Colors.orange[100],
            child: Padding(
              padding: const EdgeInsets.all(
                10,
              ),
              child: Column(
                children: [
                  Text(
                    Constants.infoFileBelumDiupload,
                    style:
                        const TextStyle(color: Color.fromARGB(255, 121, 76, 9)),
                  ),
                  Row(
                    children: [
                      Icon(
                          model.profilPencaker['photo'] == null
                              ? Icons.close
                              : Icons.check,
                          color: model.profilPencaker['photo'] == null
                              ? Colors.red
                              : Colors.green),
                      const Text(
                        '1. Foto Profil',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color.fromARGB(255, 121, 76, 9)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                          model.profilPencaker['ktp_file'] == null
                              ? Icons.close
                              : Icons.check,
                          color: model.profilPencaker['ktp_file'] == null
                              ? Colors.red
                              : Colors.green),
                      const Text(
                        '2. KTP',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color.fromARGB(255, 121, 76, 9)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                          model.profilPencaker['ijazah_file'] == null
                              ? Icons.close
                              : Icons.check,
                          color: model.profilPencaker['ijazah_file'] == null
                              ? Colors.red
                              : Colors.green),
                      const Text(
                        '3. Ijazah Terakhir',
                        textAlign: TextAlign.center,
                        style:
                            TextStyle(color: Color.fromARGB(255, 121, 76, 9)),
                      ),
                    ],
                  ),
                  Text(
                    Constants.infoFileBelumDiupload2,
                    style:
                        const TextStyle(color: Color.fromARGB(255, 121, 76, 9)),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getScaffold() {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 235, 231, 231),
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
                height: 120,
                decoration: BoxDecoration(
                    color: Constants.colorBiruGelap,
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
              ),
              Container(
                height: 120,
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
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Container(
                  //       width: MediaQuery.of(context).size.width / 2.3,
                  //       child: CariLokasi(),
                  //     ),
                  //     Container(
                  //       width: MediaQuery.of(context).size.width / 2.1,
                  //       child: CariPerusahaan(),
                  //     )
                  //   ],
                  // )
                ]),
              )
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 10)),
          // Center(
          //   child: Card(
          //     margin: const EdgeInsets.only(
          //       left: 15,
          //       right: 15,
          //       top: 10,
          //     ),
          //     child: Column(
          //       children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 5),
          //   child: ElevatedButton(
          //       onPressed: () {}, child: const Text('Filter')),
          // ),
          //   Padding(
          //       padding: const EdgeInsets.only(right: 5),
          //       child: ElevatedButton(
          //           onPressed: () {
          //             setState(() {
          //               jenis = 'Fulltime';
          //             });
          //           },
          //           child: const Text('Full Time'))),
          //   Padding(
          //       padding: const EdgeInsets.only(right: 5),
          //       child: ElevatedButton(
          //           onPressed: () {
          //             setState(() {
          //               jenis = 'Parttime';
          //             });
          //           },
          //           child: const Text('Part Time'))),
          //   ElevatedButton(
          //       onPressed: () {
          //         setState(() {
          //           jenis = 'Magang';
          //         });
          //       },
          //       child: const Text('Magang'))
          // ],
          // )
          //       ],
          //     ),
          //   ),
          // ),
          _isLoadingLowongan
              ? const BccLoadingIndicator()
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
                          onTap: () {
                            // if (loginInfo != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  LowonganDetail(job: dataLowongan),
                            ));
                            // } else {
                            //   showAlertDialogWithAction(
                            //       'Silahkan login untuk melanjutkan', context,
                            //       () {
                            //     Navigator.of(context).pop();
                            //     Navigator.of(context).push(MaterialPageRoute(
                            //       builder: (context) => const LoginScreen(),
                            //     ));
                            //   }, 'OK');
                            // }
                          },
                        );
                      },
                    )
        ],
      ),
    );
  }

  bool _isAkunLengkap(dynamic profilPencaker) {
    return profilPencaker['photo'] != null &&
        profilPencaker['ktp_file'] != null &&
        profilPencaker['ijazah_file'] != null &&
        profilPencaker['verified_email'] == '1';
  }
}
