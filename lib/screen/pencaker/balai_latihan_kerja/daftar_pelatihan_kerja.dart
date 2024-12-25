import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/balai_latihan_kerja/card_pelatihan.dart';
import 'package:bcc/state_management/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class DaftarPelatihanKerja extends StatefulWidget {
  const DaftarPelatihanKerja({super.key});

  @override
  State<DaftarPelatihanKerja> createState() => _DaftaPelatihanKerjaState();
}

class _DaftaPelatihanKerjaState extends State<DaftarPelatihanKerja> {
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);
  dynamic userInfo;
  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();
  bool _isLoading = true;
  bool _isLoadingMore = false;

  final List<dynamic> _dataPelatihan = [];

  int _totalPage = 0;
  int _page = 1;
  final int _max = 10;
  bool _lastpage = false;

  final TextEditingController _cariController = TextEditingController();

  _cari() {
    setState(() {
      _isLoading = true;
      _dataPelatihan.clear();
      _page = 1;
      _lastpage = false;
    });
    _fetchPekerjaanDisimpan(cari: _cariController.text);
  }

  @override
  void initState() {
    super.initState();
    UserLoginModel model = Provider.of<UserLoginModel>(context, listen: false);
    userInfo = model.profilPencaker;
    if (userInfo == null) {
      model.reloadDataCompany();
    }

    _fetchPekerjaanDisimpan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10))),
          height: 130,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Daftar Pelatihan Kerja',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
              const BccLineSparator(),
              Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.77,
                        child: TextFormField(
                          controller: _cariController,
                          decoration: InputDecoration(
                            hintText: 'Cari',
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(width: 0.1)),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            _cari();
                          },
                          icon: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            // padding: const EdgeInsets.all(5),
                            child: const Padding(
                              padding: EdgeInsets.all(7),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                            ),
                          ))
                    ],
                  )),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 140),
          height: MediaQuery.of(context).size.height - 140,
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _dataPelatihan.length + (_lastpage ? 0 : 1),
                  itemBuilder: (context, index) {
                    if (index == _dataPelatihan.length) {
                      if (_isLoadingMore) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Center(
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _isLoadingMore = true;
                              });
                              _fetchPekerjaanDisimpan();
                            },
                            child: const Text('Muat data selanjutnya')),
                      );
                    } else {
                      dynamic dataPelatihan = _dataPelatihan[index];
                      return CardPelatihan(
                        dataPelatihan: dataPelatihan,
                      );
                    }
                  },
                ),
        ),
      ]),
    );
  }

  _fetchPekerjaanDisimpan({String? cari}) {
    Future<dynamic> reqLowonganPopuler = _apiCall.getPelatihanKerja(
        page: _page, limit: _max, cari: cari, jobseekerId: userInfo['id']);
    reqLowonganPopuler.then((value) {
      // log('result $value');
      if (mounted) {
        _apiHelper.apiCallResponseHandler(
            response: value,
            context: context,
            onSuccess: (response) {
              setState(() {
                _isLoading = false;
                _isLoadingMore = false;
                // _isLoadMore = false;
                List<dynamic> dresponse = response['data'];
                _dataPelatihan.addAll(dresponse);

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
}
