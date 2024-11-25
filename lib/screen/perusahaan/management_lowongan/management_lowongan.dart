import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/row_data_info.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/detail_lowongan.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/tambah_lowongan.dart';
import 'package:flutter/material.dart';

class ManagementLowongan extends StatefulWidget {
  const ManagementLowongan({super.key});

  @override
  State<ManagementLowongan> createState() => _ManagementLowonganState();
}

class _ManagementLowonganState extends State<ManagementLowongan> {
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
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const TambahLowongan(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Office Boy',
                    style: Theme.of(context).textTheme.headlineSmall),
                subtitle: Column(
                  children: [
                    const RowDataInfo(
                      label: 'Total Pelamar',
                      info: '0 Pelamar',
                    ),
                    const RowDataInfo(
                        label: 'Kadaluarsa', info: '12 Desember 2024'),
                    const RowDataInfo(label: 'Status', info: 'Aktif'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const DetailLowongan(),
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
      ),
    );
  }
}
