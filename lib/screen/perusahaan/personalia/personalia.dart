import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field.dart';
import 'package:bcc/contants.dart';
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

  // final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();
  dynamic _profilPerusahaan;

  _ambilDataPersonalia() {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.13,
              bottom: 5,
              left: 10,
              right: 10),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  title: Text('Siti Jubaedah',
                      style: Theme.of(context).textTheme.headlineSmall),
                  subtitle: Column(
                    children: [
                      const RowDataInfo(
                        label: 'Alamat',
                        info:
                            'Jl Raya Bogor Jakarta no 24, gg Mangga, rt 12/rw 04 Kecamatan Cibinong Bogor',
                      ),
                      const RowDataInfo(label: 'Jenis Kerja', info: 'Magang'),
                      const RowDataInfo(label: 'No. HP', info: '08123456789'),
                      const RowDataInfo(
                          label: 'Email', info: 'personil@gmail.com'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Navigator.of(context).push(MaterialPageRoute(
                              //   builder: (context) => const DetailKandidat(),
                              // ));
                            },
                            style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    Theme.of(context).colorScheme.primary),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
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
