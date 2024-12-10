import 'package:bcc/screen/perusahaan/profile_perusahaan/profile_perusahaan_model.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/ubah_profil_perusahaan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InformasiAkunPerusahaan extends StatefulWidget {
  const InformasiAkunPerusahaan({super.key, this.profilPerusahaan});

  final dynamic profilPerusahaan;

  @override
  State<InformasiAkunPerusahaan> createState() =>
      _InformasiAkunPerusahaanState();
}

class _InformasiAkunPerusahaanState extends State<InformasiAkunPerusahaan> {
  @override
  Widget build(BuildContext context) {
    ProfilePerusahaanModel profile = context.watch<ProfilePerusahaanModel>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => UbahProfilPerusahaan(
              profilPerusahaan: profile.profil,
            ),
          ));
        },
        child: const Icon(Icons.edit_outlined),
      ),
      appBar: AppBar(
        title: const Text('Akun Perusahaan'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          const HeaderLabel(label: 'Informasi Umum'),
          RowData(
            label: 'Username',
            value: profile.profil['username'] ?? '',
          ),
          RowData(
            label: 'Email',
            value: profile.profil['email'] ?? "",
          ),
          const HeaderLabel(label: 'Info Perusahaan'),
          RowData(
            label: 'Nama',
            value: profile.profil['name'] ?? '',
          ),
          RowData(
            label: 'Tentang',
            value: profile.profil['about_company'] ?? '',
          ),
          RowData(
            label: 'Telepon',
            value: profile.profil['phone_number_company'] ?? '',
          ),
          RowData(
            label: 'Website',
            value: profile.profil['website'] ?? '',
          ),
          RowData(
            label: 'Ukuran Perusahaan',
            value: profile.profil['master_company_size_name'] ?? '',
          ),
          RowData(
            label: 'Tahun Pendirian',
            value: profile.profil['founded'] ?? '',
          ),
          RowData(
            label: 'Klasifikasi',
            value: profile.profil['grade'] ?? '',
          ),
          RowData(
            label: 'Industri',
            value: profile.profil['master_industry_name'] ?? '',
          ),
          RowData(
            label: 'TK Perempuan',
            value: profile.profil['permanent'] ?? '',
          ),
          RowData(
            label: 'TK Laki-laki',
            value: profile.profil['pkwt'] ?? '',
          ),
          RowData(
            label: 'TKA Perempuan',
            value: profile.profil['e'] ?? '0',
          ),
          RowData(
            label: 'TKA Laki-laki',
            value: profile.profil['e'] ?? '0',
          ),
        ],
      ),
    );
  }
}

class HeaderLabel extends StatelessWidget {
  const HeaderLabel({super.key, required this.label, this.padding});

  final String label;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Text(
        label,
        style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
            fontSize: 18),
      ),
    );
  }
}

class RowData extends StatefulWidget {
  const RowData(
      {super.key, required this.label, required this.value, this.padding});

  final String label;
  final String value;
  final EdgeInsets? padding;
  @override
  State<RowData> createState() => _RowDataState();
}

class _RowDataState extends State<RowData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          Flexible(
            child: Text(
              widget.value,
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
