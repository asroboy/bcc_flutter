import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
// import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/bccwidgets/bcc_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
// import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/row_data_info.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/pelamar/ubah_jadwal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class JadwalInterview extends StatefulWidget {
  const JadwalInterview({super.key, required this.jobApplication});
  final dynamic jobApplication;
  @override
  State<JadwalInterview> createState() => _JadwalInterviewState();
}

class _JadwalInterviewState extends State<JadwalInterview> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool _isLoading = true;

  // final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();
  final List<dynamic> _jadwal = [];

  _ambilJadwalInterview() {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall
        .getJobInterview(widget.jobApplication['id'],
            widget.jobApplication['jobseeker_id'], token)
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _jadwal.addAll(response['data']);

                  _isLoading = false;
                });
              });
        }
      },
    );
  }

  _simpanJadwal(dynamic data, String jadwalId) {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];

    _apiPerusahaanCall.simpanJobInterview(jadwalId, data, token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                _jadwal.clear();
                _ambilJadwalInterview();
              });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _ambilJadwalInterview();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Interview'),
      ),
      body: _isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: const BccLoadingIndicator(),
            )
          : _jadwal.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: const BccNoDataInfo())
              : ListView.builder(
                  itemCount: _jadwal.length,
                  itemBuilder: (context, index) {
                    dynamic jadwal = _jadwal[index];

                    String tanggalJadwal = DateFormat('dd MMMM yyyy').format(
                        DateFormat('yyyy-MM-dd')
                            .parse(jadwal['schedule_date']));
                    return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.jobApplication['jobseeker_name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const BccLineSparator(
                                margin: EdgeInsets.symmetric(vertical: 10),
                              ),
                              RowDataInfo(
                                  label: 'Jenis Kelamin',
                                  info: widget
                                      .jobApplication['jobseeker_gender']),
                              RowDataInfo(
                                  label: 'Pendidikan',
                                  info: widget.jobApplication[
                                      'jobseeker_last_education']),
                              RowDataInfo(
                                  label: 'Tahun Lulus',
                                  info: widget.jobApplication[
                                      'jobseeker_graduation_year']),
                              RowDataInfo(
                                  label: 'Alamat',
                                  info: widget
                                      .jobApplication['jobseeker_address']),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
                              const BccLineSparator(
                                margin: EdgeInsets.symmetric(vertical: 10),
                              ),
                              const Text(
                                'Jadwal Interview',
                                style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                              const BccLineSparator(
                                margin: EdgeInsets.symmetric(vertical: 10),
                              ),
                              RowDataInfo(
                                  label: 'Tanggal', info: tanggalJadwal),
                              RowDataInfo(
                                  label: 'Catatan Detail',
                                  info: jadwal['description'] ?? ''),
                              const Padding(padding: EdgeInsets.only(top: 15)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      padding: const EdgeInsets.all(3),
                                      onPressed: () {
                                        //ubah jadwal

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return UbahJadwalDialog(
                                              jadwal: jadwal,
                                              onSave: (data) {
                                                Navigator.of(context).pop();
                                                setState(() {
                                                  _isLoading = true;
                                                  _simpanJadwal(
                                                      data, jadwal['id']);
                                                });
                                              },
                                            );
                                          },
                                        );
                                      },
                                      icon: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.edit,
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      right: 5)),
                                              Text(
                                                'Ubah',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          ))),
                                ],
                              )
                            ],
                          ),
                        ));
                  },
                ),
    );
  }
}
