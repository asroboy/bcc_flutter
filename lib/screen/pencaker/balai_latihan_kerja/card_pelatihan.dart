import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/row_data.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardPelatihan extends StatefulWidget {
  const CardPelatihan({super.key, this.dataPelatihan});
  final dynamic dataPelatihan;

  @override
  State<CardPelatihan> createState() => _CardPelatihanState();
}

class _CardPelatihanState extends State<CardPelatihan> {
  @override
  Widget build(BuildContext context) {
    int pendaftar =
        int.parse(widget.dataPelatihan['total_participant'].toString());
    int kuota = int.parse(widget.dataPelatihan['quota'].toString());
    // int sisa = kuota - pendaftar;
    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                child: Text(
                  widget.dataPelatihan['training_name'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const BccLineSparator(),
              RowData(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  label: 'Tipe',
                  value: widget.dataPelatihan['training_type']),
              RowData(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  label: 'Kejuruan',
                  value: widget.dataPelatihan['master_vocational_name'] ?? '-'),
              RowData(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  label: 'Jenis Program',
                  value: widget.dataPelatihan['master_vocational_type_name'] ??
                      '-'),
              RowData(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  label: 'Pelaksanaan',
                  value: widget.dataPelatihan['from_date'] +
                      ' s/d ' +
                      widget.dataPelatihan['to_date']),
              RowData(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  label: 'Tahun',
                  value: widget.dataPelatihan['year'] ?? '-'),
              RowData(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  label: 'Lokasi',
                  value: widget.dataPelatihan['location'] ?? '-'),
              RowData(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  label: 'Jumlah Pendaftar',
                  value: '$pendaftar dari kuota $kuota'),
              RowData(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  label: 'Angkatan ke',
                  value: widget.dataPelatihan['generation']),
              const BccLineSparator(),
              widget.dataPelatihan['sudah'] == 1
                  ? const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                      child: Text(
                        'Kamu sudah mendaftar pelatihan ini',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    )
                  : (_pengecekanBisaDaftar(widget.dataPelatihan)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: ElevatedButton(
                                  onPressed: () {},
                                  child: const Text('Daftar Sekarang')),
                            )
                          ],
                        )
                      : widget.dataPelatihan['status'] == '0'
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 3),
                              child: Text(
                                'Pelatihan ini tidak aktif',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                            )
                          : const Center())
            ],
          ),
        ));
  }

  bool _pengecekanBisaDaftar(dynamic dataPelatihan) {
    bool bolehDaftar = true;
    DateTime now = DateTime.now();
    DateTime tanggalPulish = DateFormat('yyyy-MM-dd')
        .parse(dataPelatihan['publish_date'].toString());

    DateTime tanggalMulaiPelatihan =
        DateFormat('yyyy-MM-dd').parse(dataPelatihan['from_date'].toString());

    if (now.isBefore(tanggalPulish) && now.isAfter(tanggalMulaiPelatihan)) {
      bolehDaftar = false;
    }

    int pendaftar = int.parse(dataPelatihan['total_participant'].toString());
    int kuota = int.parse(dataPelatihan['quota'].toString());
    int sisa = kuota - pendaftar;
    if (sisa <= 0) {
      bolehDaftar = false;
    }

    if (dataPelatihan['status'] == 0) {
      bolehDaftar = false;
    }

    return bolehDaftar;
  }
}
