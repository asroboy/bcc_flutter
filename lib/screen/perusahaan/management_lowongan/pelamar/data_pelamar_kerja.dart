import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/bccwidgets/bcc_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
// import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/identitas_diri.dart';
import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/row_data_info.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/pelamar/jadwal_interview.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/pelamar/terima_kerja.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/pelamar/ubah_jadwal_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

enum StatusLamaran {
  pending,
  onreview,
  approved,
  interview,
  rejected,
  accepted
}

class DataPelamarKerja extends StatefulWidget {
  const DataPelamarKerja(
      {super.key, this.lowongan, required this.status, required this.title});

  final dynamic lowongan;
  final StatusLamaran status;
  final String title;
  @override
  State<DataPelamarKerja> createState() => _DataPelamarKerjaState();
}

class _DataPelamarKerjaState extends State<DataPelamarKerja>
    with AutomaticKeepAliveClientMixin<DataPelamarKerja> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

// 'PENDING','ONREVIEW','APPROVED','INTERVIEW','REJECTED','ACCEPTED'
// 1,2,3,4,5,6

  bool _isLoading = true;

  // final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();
  final List<dynamic> _daftarPelamar = [];

  String _getStatus() {
    return widget.status == StatusLamaran.pending
        ? 'PENDING'
        : widget.status == StatusLamaran.onreview
            ? 'ACCPTED'
            : widget.status == StatusLamaran.approved
                ? 'APPROVED'
                : widget.status == StatusLamaran.interview
                    ? 'INTERVIEW'
                    : widget.status == StatusLamaran.accepted
                        ? 'ACCEPTED'
                        : 'REJECTED';
  }

  String _getStatusUpdateInfo() {
    return widget.status == StatusLamaran.pending
        ? 'Lolos Adm.'
        : widget.status == StatusLamaran.onreview
            ? 'Interview'
            : widget.status == StatusLamaran.approved
                ? 'Diterima'
                : widget.status == StatusLamaran.interview
                    ? 'Diterima Kerja'
                    : widget.status == StatusLamaran.accepted
                        ? 'Interview'
                        : 'Ditolak';
  }

// 'PENDING','ONREVIEW','APPROVED','INTERVIEW','REJECTED','ACCEPTED'
// 1,2,3,4,5,6
  String _getStatusUpdate({StatusLamaran? statusUpdate}) {
    return (statusUpdate ?? widget.status) == StatusLamaran.pending
        ? '6'
        : (statusUpdate ?? widget.status) == StatusLamaran.onreview
            ? '4'
            : (statusUpdate ?? widget.status) == StatusLamaran.approved
                ? '5'
                : (statusUpdate ?? widget.status) == StatusLamaran.interview
                    ? '3'
                    : (statusUpdate ?? widget.status) == StatusLamaran.accepted
                        ? '4'
                        : '5';
  }

  _ambilDataLowongan() {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];

    String mStatus = _getStatus();
    _apiPerusahaanCall
        .getPelamarByLowongan(widget.lowongan['id'], token, mStatus)
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _daftarPelamar.addAll(response['data']);

                  _isLoading = false;
                });
              });
        }
      },
    );
  }

  _updateStatusLamaran(
      {StatusLamaran? statusUpdate,
      required dynamic lamaran,
      bool? terimaKembali}) {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];

    String mStatus = _getStatusUpdate(statusUpdate: statusUpdate);
    if (terimaKembali == true) {
      mStatus = '1';
    }
    dynamic updateLowongan = {'id': lamaran['id'], 'status': mStatus};

    _apiPerusahaanCall.updateLamaran(updateLowongan, token, mStatus).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _daftarPelamar.clear();
                  _ambilDataLowongan();
                  // _isLoading = false;
                });
              });
        }
      },
    );
  }

  @override
  initState() {
    super.initState();
    _ambilDataLowongan();
  }

  @override
  bool get wantKeepAlive => false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Data Pelamar ${widget.title}'),
      // ),
      body: _isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: const BccLoadingIndicator(),
            )
          : _daftarPelamar.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: const BccNoDataInfo())
              : ListView.builder(
                  itemCount: _daftarPelamar.length,
                  itemBuilder: (context, index) {
                    dynamic mlowongan = _daftarPelamar[index];
                    return Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mlowongan['jobseeker_name'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              const BccLineSparator(
                                margin: EdgeInsets.symmetric(vertical: 10),
                              ),
                              RowDataInfo(
                                  label: 'Jenis Kelamin',
                                  info: mlowongan['jobseeker_gender']),
                              RowDataInfo(
                                  label: 'Pendidikan',
                                  info: mlowongan['jobseeker_last_education']),
                              RowDataInfo(
                                  label: 'Tahun Lulus',
                                  info: mlowongan['jobseeker_graduation_year']),
                              RowDataInfo(
                                  label: 'Alamat',
                                  info: mlowongan['jobseeker_address']),
                              // RowDataInfo(
                              //     label: 'Company',
                              //     info: mlowongan['company_id']),
                              // RowDataInfo(
                              //     label: 'Job',
                              //     info: mlowongan['company_job_id'] ?? ''),
                              RowDataInfo(
                                  label: 'Jobseeker',
                                  info: mlowongan['jobseeker_id']),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Status'),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: _getColorStatus(mlowongan),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Text(
                                      mlowongan['status'],
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  )
                                ],
                              ),
                              const BccLineSparator(
                                margin: EdgeInsets.symmetric(vertical: 10),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  _buttonViewProfilePencaker(mlowongan),
                                  _buttonJadwal(mlowongan),
                                  _buttonTerima(mlowongan),
                                  _buttonTolak(mlowongan),
                                  _buttonBatalkanTolak(mlowongan)
                                ],
                              )
                            ],
                          ),
                        ));
                  },
                ),
    );
  }

  Widget _buttonTolak(dynamic mlowongan) {
    return widget.status != StatusLamaran.rejected &&
            widget.status != StatusLamaran.approved
        ? IconButton(
            padding: const EdgeInsets.all(3),
            onPressed: () {
              showAlertDialogWithAction2(
                  'Apakah Anda yakin menolak lamaran ini?', context, () {
                Navigator.of(context).pop();
              }, () {
                Navigator.of(context).pop();
                setState(() {
                  _isLoading = true;
                });
                _updateStatusLamaran(
                    statusUpdate: StatusLamaran.rejected, lamaran: mlowongan);
              }, 'Batal', 'OK');
            },
            icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error,
                    borderRadius: BorderRadius.circular(15)),
                child: const Row(
                  children: [
                    Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                    Text(
                      'Tolak',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )))
        : const Center();
  }

  Widget _buttonTerima(dynamic mlowongan) {
    return widget.status == StatusLamaran.rejected ||
            widget.status == StatusLamaran.approved
        ? const Center()
        : IconButton(
            padding: const EdgeInsets.all(3),
            onPressed: () {
              if (mlowongan['status'] == 'INTERVIEW') {
                Navigator.of(context)
                    .push(MaterialPageRoute(
                  builder: (context) => TerimaKerja(
                    lamaran: mlowongan,
                  ),
                ))
                    .then(
                  (value) {
                    if (value == 'OK') {
                      _updateStatusLamaran(lamaran: mlowongan);
                    }
                  },
                );
              } else {
                showAlertDialogWithAction2(
                    'Apakah Anda yakin merubah status Pelamar ini untuk masuk ke proses  ${_getStatusUpdateInfo()}',
                    context, () {
                  Navigator.of(context).pop();
                }, () {
                  Navigator.of(context).pop();
                  setState(() {
                    _isLoading = true;
                  });
                  if (mlowongan['status'] == 'ACCEPTED') {
                    showDialog(
                      context: context,
                      builder: (context) {
                        String tglNow =
                            DateFormat('yyyy-MM-dd').format(DateTime.now());
                        // String tglNow2 = DateFormat(
                        //         'yyyy-MM-dd HH:mm:ss')
                        //     .format(DateTime.now());
                        dynamic newJadwal = {
                          'jobseeker_id': mlowongan['jobseeker_id'],
                          'company_job_application_id': mlowongan['id'],
                          'company_id': mlowongan['company_id'],
                          'company_job_id': mlowongan['company_job_id'],
                          'description': '',
                          'schedule_date': tglNow,
                          'created_by': mlowongan['company_id'],
                        };
                        return UbahJadwalDialog(
                          title: 'Buat Jadwal Interview',
                          jadwal: newJadwal,
                          onSave: (data) {
                            if (data != null) {
                              Navigator.of(context).pop();
                              setState(() {
                                _isLoading = true;
                                _simpanJadwal(data, mlowongan);
                              });
                            }
                          },
                        );
                      },
                    );
                  } else {
                    _updateStatusLamaran(lamaran: mlowongan);
                  }
                }, 'Batal', 'OK');
              }
            },
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ));
  }

  _simpanJadwal(dynamic data, dynamic mlowongan) {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];

    _apiPerusahaanCall.simpanJobInterview(data, token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                _updateStatusLamaran(lamaran: mlowongan);
              });
        }
      },
    );
  }

  Widget _buttonBatalkanTolak(dynamic mlowongan) {
    return widget.status == StatusLamaran.rejected
        ? IconButton(
            padding: const EdgeInsets.all(3),
            onPressed: () {
              showAlertDialogWithAction2(
                  'Apakah Anda yakin membuka kembali lamaran ini?', context,
                  () {
                Navigator.of(context).pop();
              }, () {
                Navigator.of(context).pop();
                setState(() {
                  _isLoading = true;
                });
                _updateStatusLamaran(terimaKembali: true, lamaran: mlowongan);
              }, 'Batal', 'OK');
            },
            icon: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
                child: const Row(
                  children: [
                    Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ),
                    Text(
                      'Buka Kembali',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )))
        : const Center();
  }

  Widget _buttonJadwal(dynamic mlowongan) {
    return widget.status == StatusLamaran.interview
        ? IconButton(
            padding: const EdgeInsets.all(3),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => JadwalInterview(
                  jobApplication: mlowongan,
                ),
              ));
            },
            icon: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15)),
              child: const Icon(
                Icons.calendar_today_outlined,
                color: Colors.white,
              ),
            ))
        : const Center();
  }

  Widget _buttonViewProfilePencaker(dynamic mlowongan) {
    return IconButton(
        padding: const EdgeInsets.all(3),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => IdentitasDiri(
              isPerusahaan: true,
              pencakerId: mlowongan['jobseeker_unique_id'],
            ),
          ));
        },
        icon: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(15)),
          child: const Icon(
            Icons.person,
            color: Colors.white,
          ),
        ));
  }

  Color _getColorStatus(dynamic mlowongan) {
    if (mlowongan['status'] == 'PENDING') {
      return Colors.orange;
    }
    if (mlowongan['status'] == 'ACCEPTED') {
      return const Color.fromARGB(255, 51, 135, 204);
    }
    if (mlowongan['status'] == 'INTERVIEW') {
      return Colors.blueGrey;
    }
    if (mlowongan['status'] == 'APPROVED') {
      return Colors.green;
    }
    if (mlowongan['status'] == 'REJECTED') {
      return const Color.fromARGB(255, 224, 33, 33);
    }
    return Colors.orange;
  }
}
