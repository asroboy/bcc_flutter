import 'package:bcc/bccwidgets/bcc_dropdown_string.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TambahLowongan extends StatefulWidget {
  const TambahLowongan({super.key, this.label, this.lowongan});

  final String? label;
  final dynamic lowongan;

  @override
  State<TambahLowongan> createState() => _TambahLowonganState();
}

class _TambahLowonganState extends State<TambahLowongan> {
  String tanggalString = 'dd/MM/yyyy';
  String tampilGaji = 'Tidak';
  @override
  Widget build(BuildContext context) {
    TextEditingController judulC = TextEditingController(
        text: widget.lowongan == null ? '' : widget.lowongan['title']);
    TextEditingController descCont = TextEditingController(
        text: widget.lowongan == null ? '' : widget.lowongan['description']);

    TextEditingController gajiM = TextEditingController(
        text: widget.lowongan == null
            ? '0'
            : widget.lowongan['range_salary_from']);
    TextEditingController gajiS = TextEditingController(
        text:
            widget.lowongan == null ? '0' : widget.lowongan['range_salary_to']);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(widget.label ?? 'Tambah Lowongan'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              widget.label == null
                  ? 'Input Lowongan Pekerjaan'
                  : 'Ubah Lowongan Pekerjaan',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          BccTextFormFieldInput(
            hint: 'Judul Pekerjaan',
            controller: judulC,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          ),
          BccTextFormFieldInput(
            hint: 'Deskripsi Pekerjaan',
            textInputType: TextInputType.multiline,
            controller: descCont,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          ),
          const BccRowLabel(
            label: 'Jenis Pekerjaan',
            padding: EdgeInsets.only(left: 15),
          ),
          BccDropDownString(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
            data: ['', 'test', 'test 2'],
            value: '',
            onChanged: (value) {
              setState(() {
                // selectedUkuranPerusahaanName = value ?? '';
                // selectedUkuranPerusahaan = infoUkuranPerusahaan.firstWhere(
                //   (element) => element['name'] == value,
                // );
              });
            },
          ),
          const BccRowLabel(
            label: 'Level Pekerjaan',
            padding: EdgeInsets.only(left: 15),
          ),
          BccDropDownString(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
            data: ['', 'test', 'test 2'],
            value: '',
            onChanged: (value) {
              setState(() {
                // selectedUkuranPerusahaanName = value ?? '';
                // selectedUkuranPerusahaan = infoUkuranPerusahaan.firstWhere(
                //   (element) => element['name'] == value,
                // );
              });
            },
          ),
          const BccRowLabel(
            label: 'Provinsi',
            padding: EdgeInsets.only(left: 15),
          ),
          BccDropDownString(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
            data: ['', 'test', 'test 2'],
            value: '',
            onChanged: (value) {
              setState(() {
                // selectedUkuranPerusahaanName = value ?? '';
                // selectedUkuranPerusahaan = infoUkuranPerusahaan.firstWhere(
                //   (element) => element['name'] == value,
                // );
              });
            },
          ),
          const BccRowLabel(
            label: 'Kabupaten',
            padding: EdgeInsets.only(left: 15),
          ),
          BccDropDownString(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
            data: ['', 'test', 'test 2'],
            value: '',
            onChanged: (value) {
              setState(() {
                // selectedUkuranPerusahaanName = value ?? '';
                // selectedUkuranPerusahaan = infoUkuranPerusahaan.firstWhere(
                //   (element) => element['name'] == value,
                // );
              });
            },
          ),
          const BccRowLabel(
            label: 'Tampilkan Gaji',
            padding: EdgeInsets.only(left: 15),
          ),
          BccDropDownString(
            margin:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
            data: const ['Tidak', 'Ya'],
            value: tampilGaji,
            onChanged: (value) {
              setState(() {
                if (value == null) return;
                tampilGaji = value;
              });
            },
          ),
          tampilGaji == 'Ya'
              ? BccTextFormFieldInput(
                  hint: 'Gaji mulai',
                  textInputType: TextInputType.number,
                  controller: gajiM,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                )
              : const Center(),
          tampilGaji == 'Ya'
              ? BccTextFormFieldInput(
                  hint: 'Gaji sampai',
                  textInputType: TextInputType.number,
                  controller: gajiS,
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, top: 10, bottom: 10),
                )
              : const Center(),
          const BccRowLabel(
            label: 'Tanggal Kadaluarsa',
            padding: EdgeInsets.only(left: 15),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BccRowLabel(
                label: tanggalString,
                padding: const EdgeInsets.only(left: 35),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.blue[700])),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 5),
                              lastDate: DateTime(DateTime.now().year + 5))
                          .then((value) {
                        setState(() {
                          if (value == null) return;
                          tanggalString =
                              DateFormat('dd/MM/yyyy').format(value);
                        });
                      });
                    },
                    child: const Row(
                      children: [Icon(Icons.calendar_month), Text('Tanggal')],
                    )),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Row(
                      children: [Icon(Icons.save), Text('Simpan')],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }
}
