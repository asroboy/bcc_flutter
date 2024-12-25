import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/whishlist/card_list_pekerjaan.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class RiwayatLamaran extends StatefulWidget {
  const RiwayatLamaran({super.key});

  @override
  State<RiwayatLamaran> createState() => _RiwayatLamaranState();
}

class _RiwayatLamaranState extends State<RiwayatLamaran> {
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  int idPencaker = 0;

  int _page = 0;
  final int _max = 20;
  String search = '';

  bool _isLoadingLowongan = false;
  // bool _isLoadMore = false;
  // bool _lastpage = false;
  int _totalPage = 0;
  final List<dynamic> _dataRiwayatLamaran = [];

  _fetchPekerjaanDisimpan() {
    Future<dynamic> reqLowonganPopuler = _apiCall.getRiwayatLamaran(
        Constants.pathRiwayatLamaran, _page, _max, idPencaker);
    reqLowonganPopuler.then((value) {
      // log('result $value');
      if (mounted) {
        _apiHelper.apiCallResponseHandler(
            response: value,
            context: context,
            onSuccess: (response) {
              setState(() {
                _isLoadingLowongan = false;
                // _isLoadMore = false;
                List<dynamic> dresponse = response['data'];
                _dataRiwayatLamaran.addAll(dresponse);

                dynamic metadata = response['meta'];

                _totalPage = metadata['totalPage'];
                if (_page < _totalPage) {
                  _page++;
                } else {
                  // _lastpage = true;
                }
              });
            });
      }
    });
  }

  @override
  void initState() {
    idPencaker = int.parse(loginInfo['data']['id']);
    _isLoadingLowongan = true;
    _fetchPekerjaanDisimpan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Lamaran')),
      body: _isLoadingLowongan
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _dataRiwayatLamaran.isEmpty
              ? const BccNoDataInfo()
              : ListView.builder(
                  itemCount: _dataRiwayatLamaran.length,
                  itemBuilder: (context, index) {
                    dynamic whishedJob = _dataRiwayatLamaran[index];
                    return CardListPekerjaan(
                      whishedJob: whishedJob,
                      showAjukanLamaran: false,
                      isWhishList: false,
                    );
                  },
                ),
    );
  }
}
