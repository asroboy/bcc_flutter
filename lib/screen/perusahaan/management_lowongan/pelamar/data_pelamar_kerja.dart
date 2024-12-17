import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/bccwidgets/bcc_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
// import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/identitas_diri.dart';
import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/row_data_info.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class DataPelamarKerja extends StatefulWidget {
  const DataPelamarKerja({super.key, this.lowongan});

  final dynamic lowongan;
  @override
  State<DataPelamarKerja> createState() => _DataPelamarKerjaState();
}

class _DataPelamarKerjaState extends State<DataPelamarKerja> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool _isLoading = true;

  // final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();
  final List<dynamic> _daftarPelamar = [];

  _ambilDataLowongan() {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall
        .getPelamarByLowongan(widget.lowongan['id'], token, 'PENDING')
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _daftarPelamar.addAll(response['data']);
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

  @override
  initState() {
    super.initState();
    _ambilDataLowongan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Pelamar'),
      ),
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
                                        color: Colors.orange,
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
                                  IconButton(
                                      padding: const EdgeInsets.all(3),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (context) => IdentitasDiri(
                                            isPerusahaan: true,
                                            pencakerId: mlowongan[
                                                'jobseeker_unique_id'],
                                          ),
                                        ));
                                      },
                                      icon: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                      )),
                                  IconButton(
                                      padding: const EdgeInsets.all(3),
                                      onPressed: () {},
                                      icon: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      )),
                                  IconButton(
                                      padding: const EdgeInsets.all(3),
                                      onPressed: () {},
                                      icon: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .error,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.close,
                                                color: Colors.white,
                                              ),
                                              Text(
                                                'Tolak',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            ],
                                          )))
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
