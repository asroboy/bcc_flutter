import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/row_data.dart';
import 'package:bcc/state_management/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class RiwayatPelatihan extends StatefulWidget {
  const RiwayatPelatihan({super.key});

  @override
  State<RiwayatPelatihan> createState() => _RiwayatPelatihanState();
}

class _RiwayatPelatihanState extends State<RiwayatPelatihan> {
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);
  dynamic userInfo;
  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();
  bool _isLoading = true;
  bool _isLoadingMore = false;

  int _totalPage = 0;
  int _page = 1;
  final int _max = 10;
  bool _lastpage = false;

  final List<dynamic> _dataRiwayatPelatihan = [];

  @override
  void initState() {
    UserLoginModel model = Provider.of<UserLoginModel>(context, listen: false);
    userInfo = model.profilPencaker;
    if (userInfo == null) {
      model.reloadDataCompany();
    }
    _fetchDataRiwayatPelatihan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: _dataRiwayatPelatihan.length,
        itemBuilder: (context, index) {
          dynamic pelatihan = _dataRiwayatPelatihan[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
                      child: Text(
                        pelatihan['training_name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    const BccLineSparator(),
                    RowData(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        label: 'No Registrasi',
                        value: pelatihan['no_registration']),
                    RowData(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        label: 'Tanggal',
                        value: pelatihan['created_dt']),
                    RowData(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        label: 'Pelaksanaan',
                        value: pelatihan['from_date'] +
                            ' s/d ' +
                            pelatihan['to_date']),
                    RowData(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 3),
                        label: 'Status',
                        value: pelatihan['status']),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: ElevatedButton(
                              onPressed: () {},
                              child: const Row(
                                children: [
                                  Icon(Icons.print),
                                  Padding(padding: EdgeInsets.only(right: 5)),
                                  Text('Cetak')
                                ],
                              )),
                        )
                      ],
                    )
                  ],
                )),
          );
        },
      ),
    );
  }

  _fetchDataRiwayatPelatihan({String? cari}) {
    Future<dynamic> reqLowonganPopuler = _apiCall.getRiwayatPelatihanKerja(
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
                _dataRiwayatPelatihan.addAll(dresponse);

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
