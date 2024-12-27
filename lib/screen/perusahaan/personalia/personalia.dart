import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/identitas_diri.dart';
import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/row_data_info.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Personalia extends StatefulWidget {
  const Personalia({super.key});

  @override
  State<Personalia> createState() => _PersonaliaState();
}

class _PersonaliaState extends State<Personalia> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool isLoading = false;
//
  // final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  List<dynamic> _personalia = [];

  bool _isLoading = true;

  _ambilDataPersonalia() {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    String idPerusahaan = loginInfo['data']['id'];

    _apiPerusahaanCall.getPersonalia(idPerusahaan, token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _personalia.addAll(response['data']);

                  _isLoading = false;
                });
              });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _ambilDataPersonalia();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.17,
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
              : _personalia.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: const BccNoDataInfo())
                  : ListView.builder(
                      itemCount: _personalia.length,
                      itemBuilder: (context, index) {
                        dynamic personil = _personalia[index];

                        return Card(
                          child: ListTile(
                            title: Text(personil['jobseeker_name'],
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            subtitle: Column(
                              children: [
                                RowDataInfo(
                                  label: 'Alamat',
                                  info: personil['jobseeker_address'],
                                ),
                                RowDataInfo(
                                    label: 'Jenis Kerja',
                                    info: personil[
                                        'master_employment_type_name']),
                                RowDataInfo(
                                    label: 'No. HP',
                                    info: personil['jobseeker_phone_number']),
                                RowDataInfo(
                                    label: 'Email',
                                    info: personil['jobseeker_email']),
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
                                                personil['jobseeker_unique_id'],
                                          ),
                                        ));
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
      ]),
    );
  }
}
