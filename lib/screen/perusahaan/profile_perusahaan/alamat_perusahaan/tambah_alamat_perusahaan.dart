import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:flutter/material.dart';

class TambahAlamatPerusahaan extends StatefulWidget {
  const TambahAlamatPerusahaan({super.key});

  @override
  State<TambahAlamatPerusahaan> createState() => _TambahAlamatPerusahaanState();
}

class _TambahAlamatPerusahaanState extends State<TambahAlamatPerusahaan> {
  final TextEditingController _judulController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tambah Alamat Perusahaan'),
        ),
        body: Card(
          margin: const EdgeInsets.all(10),
          child: ListView(
            children: [
              const Padding(padding: EdgeInsets.only(top: 15)),
              BccTextFormFieldInput(
                hint: 'Judul',
                controller: _judulController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              ),
              BccTextFormFieldInput(
                hint: 'Alamat',
                controller: _alamatController,
                textInputType: TextInputType.multiline,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 7),
              ),
            ],
          ),
        ));
  }
}
