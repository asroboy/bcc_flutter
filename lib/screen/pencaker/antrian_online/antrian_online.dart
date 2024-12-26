import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/antrian_online/tambah_antrian_online.dart';
import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/row_data_info.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class AntrianOnline extends StatefulWidget {
  const AntrianOnline({super.key, required this.userType});

  final UserType userType;

  @override
  State<AntrianOnline> createState() => _AntrianOnlineState();
}

class _AntrianOnlineState extends State<AntrianOnline> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool isLoading = true;
  final ApiHelper _apiHelper = ApiHelper();
  bool _isLoadingLayanan = true;

  final List<dynamic> _dataLayanan = [];

  _getAntrian() {
    String idPengguna = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall
        .getQueue(
            token: token, userId: idPengguna, userType: UserType.jobseeker)
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _dataLayanan.addAll(response['data']);
                  _isLoadingLayanan = false;
                });
              });
        }
      },
    );
  }

  @override
  void initState() {
    _getAntrian();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Antrian Online'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
            builder: (context) => TambahAntrianOnlie(
              userType: widget.userType,
            ),
          ))
              .then(
            (value) {
              if (value == 'OK') {
                setState(() {
                  _isLoadingLayanan = true;
                  _dataLayanan.clear();
                  _getAntrian();
                });
              }
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: _isLoadingLayanan
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _dataLayanan.isEmpty
              ? const BccNoDataInfo()
              : ListView.builder(
                  itemCount: _dataLayanan.length,
                  itemBuilder: (context, index) {
                    String status = _dataLayanan[index]['status'];
                    String descriptionStatus = status == 'SUBMISSION'
                        ? _dataLayanan[index]['desc_received']
                        : status == 'RECEIVED'
                            ? _dataLayanan[index]['desc_received']
                            : status == 'PROCESS'
                                ? _dataLayanan[index]['desc_process']
                                : status == 'DONE'
                                    ? _dataLayanan[index]['desc_done']
                                    : _dataLayanan[index]['desc_done'];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            RowDataInfo(
                              label: 'Nama Layanan',
                              info: _dataLayanan[index]['queue_name'],
                            ),
                            RowDataInfo(
                              label: 'Tanggal',
                              info: _dataLayanan[index]['visit_date'],
                            ),
                            RowDataInfo(
                              label: 'Waktu',
                              info: _dataLayanan[index]['service_time'],
                            ),
                            RowDataInfo(
                              label: 'Tujuan',
                              info: _dataLayanan[index]['counter_name'],
                            ),
                            RowDataInfo(
                              label: 'Keterangan',
                              info: _dataLayanan[index]['description'],
                            ),
                            RowDataInfo(
                              label: 'Status',
                              info: status,
                              infoColor: getColorStatus(status),
                            ),
                            RowDataInfo(
                              label: 'Status Proses',
                              info: descriptionStatus,
                            ),
                            RowDataInfo(
                              label: 'Tanggal Dibuat',
                              info: DateFormat('dd-MM-yyyy HH:mm').format(
                                DateTime.parse(
                                    _dataLayanan[index]['created_dt']),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Color getColorStatus(String status) {
    if (status == 'SUBMISSION') {
      return const Color.fromARGB(255, 214, 133, 11);
    }
    if (status == 'RECEIVED') {
      return const Color.fromARGB(255, 51, 135, 204);
    }
    if (status == 'PROCESS') {
      return Colors.blueGrey;
    }
    if (status == 'DONE') {
      return Colors.green;
    }
    if (status == 'REJECTED') {
      return const Color.fromARGB(255, 224, 33, 33);
    }
    return Colors.orange;
  }
}
