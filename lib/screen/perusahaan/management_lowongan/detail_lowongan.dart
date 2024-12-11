import 'package:bcc/screen/perusahaan/management_lowongan/tambah_lowongan.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/header_label.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/row_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailLowongan extends StatefulWidget {
  const DetailLowongan({super.key, this.lowongan});

  final dynamic lowongan;

  @override
  State<DetailLowongan> createState() => _DetailLowonganState();
}

class _DetailLowonganState extends State<DetailLowongan> {
  @override
  Widget build(BuildContext context) {
    DateTime tanggalKadaluarsa = DateFormat("yyyy-MM-dd")
        .parse(widget.lowongan['vacancies_expired'].toString());
    String tanggalKadaluarsaString =
        DateFormat("dd MMMM yyyy").format(tanggalKadaluarsa);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lowongan'),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: <Widget>[
      //       FloatingActionButton(
      //         backgroundColor: Colors.red,
      //         onPressed: () {},
      //         heroTag: 'fab1',
      //         child: const Icon(Icons.delete),
      //       ),
      //       const Padding(padding: EdgeInsets.only(right: 10)),
      //       FloatingActionButton(
      //         onPressed: () {
      //           Navigator.of(context).push(MaterialPageRoute(
      //             builder: (context) => TambahLowongan(
      //               label: 'Ubah Lowongan',
      //               lowongan: widget.lowongan,
      //             ),
      //           ));
      //         },
      //         heroTag: 'fab2',
      //         child: const Icon(Icons.edit),
      //       )
      //     ],
      //   ),
      // ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          HeaderLabel(label: widget.lowongan['title']),
          RowData(
            label: 'Deskripsi',
            isHtml: true,
            value: widget.lowongan['description'] ?? '',
          ),
          RowData(
            label: 'Jenis Pekerjaan',
            value: widget.lowongan['master_employment_type_name'] ?? '',
          ),
          RowData(
            label: 'Level Pekerjaan',
            value: widget.lowongan['master_job_level_name'] ?? '',
          ),
          RowData(
            label: 'Kota/Kab.',
            value:
                '${widget.lowongan['master_city_name']} - ${widget.lowongan['master_province_name']}',
          ),
          RowData(
            label: 'Gaji',
            value: widget.lowongan['is_show_salary'] == '0'
                ? 'Tidak ditampilkan'
                : ('${widget.lowongan['range_salary_from']} s.d ${widget.lowongan['range_salary_to']}'),
          ),
          RowData(
            label: 'Kadaluarsa',
            value: tanggalKadaluarsaString,
          ),
          Padding(
              padding: const EdgeInsets.only(right: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Status',
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Checkbox(
                        value: widget.lowongan['status'] == 'Aktif',
                        onChanged: (value) {}),
                    Text(widget.lowongan['status'])
                  ]),
                ],
              )),
          const Padding(padding: EdgeInsets.only(top: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.red)),
                  child: const Row(
                    children: [Icon(Icons.delete)],
                  )),
              const Padding(
                padding: EdgeInsets.only(left: 5),
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: const Row(
                    children: [Icon(Icons.people_alt)],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 15),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TambahLowongan(
                          label: 'Ubah Lowongan',
                          lowongan: widget.lowongan,
                        ),
                      ));
                    },
                    child: const Row(
                      children: [Icon(Icons.edit)],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
