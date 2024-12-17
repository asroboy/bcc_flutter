import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/bccwidgets/bcc_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/row_data_info.dart';
// import 'package:bcc/screen/perusahaan/management_lowongan/pelamar/data_pelamar_kerja.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/detail_lowongan.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/pelamar/pelamar_tab.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/tambah_lowongan.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class ManagementLowongan extends StatefulWidget {
  const ManagementLowongan({super.key});

  @override
  State<ManagementLowongan> createState() => _ManagementLowonganState();
}

class _ManagementLowonganState extends State<ManagementLowongan> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool _isLoading = true;

  // final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();
  final List<dynamic> _daftarLowongan = [];

  _ambilDataLowongan() {
    String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getLowongan(idPerusahaan, token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _daftarLowongan.addAll(response['data']);
                  // Provider.of<ProfilePerusahaanModel>(context, listen: false)
                  //     .set(_profilPerusahaan);
                  // log('profil perusahaan result $_profilPerusahaan');
                  // _dataPengalamanBekerja.addAll(biodataPencaker['experience']);
                  // _dataPendidikanPencaker.addAll(biodataPencaker['education']);
                  // _dataSertifikat.addAll(biodataPencaker['certificate']);
                  // _dataSkill.addAll(biodataPencaker['skill']);
                  _isLoading = false;
                });
              });
        }
      },
    );
  }

  _reload(value) {
    if (value == 'OK') {
      setState(() {
        _daftarLowongan.clear();
        _isLoading = true;
      });
      _ambilDataLowongan();
    }
  }

  @override
  void initState() {
    super.initState();
    _ambilDataLowongan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Management Lowongan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab0',
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(
                builder: (context) => const TambahLowongan(),
              ))
              .then(
                (value) => _reload(value),
              );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: _isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: const BccLoadingIndicator(),
              )
            : _daftarLowongan.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: const BccNoDataInfo(),
                  )
                : ListView.builder(
                    itemCount: _daftarLowongan.length,
                    itemBuilder: (context, index) {
                      dynamic lowongan = _daftarLowongan[index];

                      DateTime tanggalKadaluarsa = DateFormat("yyyy-MM-dd")
                          .parse(lowongan['vacancies_expired'].toString());
                      String tanggalKadaluarsaString =
                          DateFormat("dd MMMM yyyy").format(tanggalKadaluarsa);

                      return Card(
                        child: ListTile(
                          title: Text(lowongan['title'],
                              style: Theme.of(context).textTheme.headlineSmall),
                          subtitle: Column(
                            children: [
                              RowDataInfo(
                                label: 'Total Pelamar',
                                info:
                                    '${lowongan['total_application']} Pelamar',
                              ),
                              RowDataInfo(
                                  label: 'Kadaluarsa',
                                  info: tanggalKadaluarsaString),
                              RowDataInfo(
                                label: 'Status',
                                info: lowongan['status'],
                                infoColor: lowongan['status'] == 'Aktif'
                                    ? Colors.green
                                    : Colors.red,
                              ),
                              const Padding(padding: EdgeInsets.only(top: 15)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => PelamarTab(
                                            lowongan: lowongan,
                                          ),
                                        ));
                                        // Navigator.of(context)
                                        //     .push(MaterialPageRoute(
                                        //   builder: (context) =>
                                        //       DataPelamarKerja(
                                        //     lowongan: lowongan,
                                        //   ),
                                        // ));
                                      },
                                      child: const Row(
                                        children: [Icon(Icons.people_alt)],
                                      )),
                                  const Padding(
                                      padding: EdgeInsets.only(right: 5)),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                            builder: (context) =>
                                                DetailLowongan(
                                                    lowongan: lowongan),
                                          ))
                                          .then(
                                            (value) => _reload(value),
                                          );
                                      ;
                                    },
                                    style: ElevatedButton.styleFrom(
                                        foregroundColor: Colors.white,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Detail'),
                                        Icon(Icons.navigate_next)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}
