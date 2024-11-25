import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/detail_kadidat.dart';
import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/row_data_info.dart';
import 'package:flutter/material.dart';

class CariKandidat extends StatefulWidget {
  const CariKandidat({super.key});

  @override
  State<CariKandidat> createState() => _CariKandidatState();
}

class _CariKandidatState extends State<CariKandidat> {
  @override
  Widget build(BuildContext context) {
    double headerHeight = MediaQuery.of(context).size.height * 0.20;
    double bodyHeight = MediaQuery.of(context).size.height - headerHeight;
    return Scaffold(
      body: Stack(
        children: [
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
                    title: Text('Nama Pelamar',
                        style: Theme.of(context).textTheme.headlineSmall),
                    subtitle: Column(
                      children: [
                        const RowDataInfo(
                          label: 'Alamat',
                          info:
                              'Jl Raya Bogor Jakarta no 24, gg Mangga, rt 12/rw 04 Kecamatan Cibinong Bogor',
                        ),
                        const RowDataInfo(
                            label: 'Pendidkan', info: 'Strata Satu (S1)'),
                        const RowDataInfo(
                            label: 'Keahlian', info: 'Microsoft Office'),
                        const RowDataInfo(
                            label: 'Email', info: 'pelamar@gmail.com'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const DetailKandidat(),
                                ));
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
        ],
      ),
    );
  }
}
