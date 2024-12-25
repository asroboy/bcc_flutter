import 'package:bcc/screen/perusahaan/profile_perusahaan/header_label.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/row_data.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/ubah_profil_perusahaan.dart';
import 'package:bcc/state_management/user_login_model.dart';
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
    UserLoginModel profile = context.watch<UserLoginModel>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Future<dynamic> req = Navigator.of(context).push(MaterialPageRoute(
            builder: (context_) => UbahProfilPerusahaan(
              profilPerusahaan: profile.profilePerusahaan,
            ),
          ));

          req.then((value) {
            if (value == 'OK') {
              if (mounted) {
                Navigator.of(context).pop('OK');
              }
            }
          });
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
            value: profile.profilePerusahaan['username'] ?? '',
          ),
          RowData(
            label: 'Email',
            value: profile.profilePerusahaan['email'] ?? "",
          ),
          const HeaderLabel(label: 'Info Perusahaan'),
          RowData(
            label: 'Nama',
            value: profile.profilePerusahaan['name'] ?? '',
          ),
          RowData(
            label: 'Tentang',
            value: profile.profilePerusahaan['about_company'] ?? '',
          ),
          RowData(
            label: 'Tagline',
            value: profile.profilePerusahaan['tagline'] ?? '',
          ),
          RowData(
            label: 'Telepon',
            value: profile.profilePerusahaan['phone_number_company'] ?? '',
          ),
          RowData(
            label: 'Website',
            value: profile.profilePerusahaan['website'] ?? '',
          ),
          RowData(
            label: 'Ukuran Perusahaan',
            value: profile.profilePerusahaan['master_company_size_name'] ?? '',
          ),
          RowData(
            label: 'Tahun Pendirian',
            value: profile.profilePerusahaan['founded'] ?? '',
          ),
          RowData(
            label: 'Klasifikasi',
            value: profile.profilePerusahaan['grade'] ?? '',
          ),
          RowData(
            label: 'Industri',
            value: profile.profilePerusahaan['master_industry_name'] ?? '',
          ),
          RowData(
            label: 'TK Perempuan',
            value: profile.profilePerusahaan['permanent'] ?? '',
          ),
          RowData(
            label: 'TK Laki-laki',
            value: profile.profilePerusahaan['pkwt'] ?? '',
          ),
          RowData(
            label: 'TKA Perempuan',
            value: profile.profilePerusahaan['internship'] ?? '0',
          ),
          RowData(
            label: 'TKA Laki-laki',
            value:
                profile.profilePerusahaan['termination_of_employment'] ?? '0',
          ),
        ],
      ),
    );
  }
}
