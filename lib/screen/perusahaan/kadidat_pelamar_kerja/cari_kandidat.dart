import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field.dart';
// import 'package:bcc/bccwidgets/bcc_circle_loading_indicator.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/identitas_diri.dart';
import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/row_data_info.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class CariKandidat extends StatefulWidget {
  const CariKandidat({super.key});

  @override
  State<CariKandidat> createState() => _CariKandidatState();
}

class _CariKandidatState extends State<CariKandidat> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool _isLoading = true;

  // final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();
  final List<dynamic> _daftarPelamar = [];

  _ambilDataLowongan() {
    String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getPelamarByPerusahaan(idPerusahaan, token, '').then(
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
  void initState() {
    _ambilDataLowongan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.13,
                bottom: 5,
                left: 10,
                right: 10),
            height: MediaQuery.of(context).size.height,
            child: _isLoading
                ? const SizedBox(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ListView.builder(
                    itemCount: _daftarPelamar.length,
                    itemBuilder: (context, index) {
                      dynamic pelamar = _daftarPelamar[index];
                      return Card(
                        child: ListTile(
                          title: Text('${pelamar['jobseeker_name']}',
                              style: Theme.of(context).textTheme.headlineSmall),
                          subtitle: Column(
                            children: [
                              RowDataInfo(
                                label: 'Alamat',
                                info: pelamar['jobseeker_address'],
                              ),
                              RowDataInfo(
                                  label: 'Pendidkan',
                                  info: pelamar['jobseeker_last_education']),
                              RowDataInfo(
                                  label: 'Email',
                                  info: pelamar['jobseeker_email']),
                              RowDataInfo(
                                  label: 'Lamaran',
                                  info: pelamar['company_job_name']),
                              RowDataInfo(
                                  label: '', info: pelamar['company_name']),
                              RowDataInfo(
                                  label: 'Status', info: pelamar['status']),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => IdentitasDiri(
                                          isPerusahaan: true,
                                          pencakerId:
                                              pelamar['jobseeker_unique_id'],
                                        ),
                                      ));
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //   builder: (context) =>
                                      //       const DetailKandidat(),
                                      // ));
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
          Container(
            padding: const EdgeInsets.only(top: 80),
            height: MediaQuery.of(context).size.height * 0.20,
            width: MediaQuery.of(context).size.height,
            color: Theme.of(context).colorScheme.primary,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: const BccTextFormField(
                        autoFocus: false,
                        hint: 'Cari',
                      ),
                    ),
                    IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: Icon(
                            Icons.search,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
