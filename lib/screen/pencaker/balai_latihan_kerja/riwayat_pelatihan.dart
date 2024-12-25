import 'dart:async';
import 'dart:developer';
import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pdf/pdf_screen.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/row_data.dart';
import 'package:bcc/state_management/user_login_model.dart';
import 'package:flutter/foundation.dart';
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

  int _totalPage = 0;
  int _page = 1;
  final int _max = 30;

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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _dataRiwayatPelatihan.length,
              itemBuilder: (context, index) {
                dynamic pelatihan = _dataRiwayatPelatihan[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: ElevatedButton(
                                    onPressed: () {
                                      String url =
                                          '${Constants.pathDataPelatihanProof}?jobseeker_id=${pelatihan['jobseeker_id']}&id=${pelatihan['id']}';
                                      log('url $url');
                                      createFileOfPdfUrl(
                                              url, pelatihan['no_registration'])
                                          .then((f) {
                                        String path = f.path;
                                        Navigator.push(
                                          // ignore: use_build_context_synchronously
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PdfScreen(path: path),
                                          ),
                                        );
                                      });
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(Icons.print),
                                        Padding(
                                            padding: EdgeInsets.only(right: 5)),
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

  Future<File> createFileOfPdfUrl(String url, String id) async {
    Completer<File> completer = Completer();
    log("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      // final url = url;
      final filename = '$id.pdf';
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      log("Download files");
      log("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
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
                // _isLoadMore = false;
                List<dynamic> dresponse = response['data'];
                _dataRiwayatPelatihan.addAll(dresponse);

                dynamic metadata = response['meta'];

                _totalPage = metadata['totalPage'];
                if (_page < _totalPage) {
                  _page++;
                } else {}
              });
            });
      }
    });
  }
}
