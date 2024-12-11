import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
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
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double headerHeight = MediaQuery.of(context).size.height * 0.20;
    double bodyHeight = MediaQuery.of(context).size.height - headerHeight;

    return Scaffold(
      body: Stack(children: [
        Container(
          height: headerHeight,
          color: Theme.of(context).colorScheme.primary,
          child: const Column(
            children: [
              Row(
                children: [],
              )
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              top: (headerHeight + 2), bottom: 10, left: 10, right: 10),
          height: bodyHeight,
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
        )
      ]),
    );
  }
}
