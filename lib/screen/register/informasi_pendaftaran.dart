import 'package:bcc/bccwidgets/bcc_row_info1.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';

class InformasiPendaftaran extends StatelessWidget {
  const InformasiPendaftaran({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PENDAFTARAN AKUN \nPENCARI KERJA / TENAGA KERJA',
            style: TextStyle(
              color: Constants.colorBiruGelap,
              fontSize: 18,
              fontFamily: 'Jost',
              fontWeight: FontWeight.w800,
              letterSpacing: -0.18,
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, left: 5, right: 5),
            child: BccRowInfo1(
                assetName: 'assets/icons/clarity_check-circle-solid.png',
                info:
                    'Form Pendaftaran ini untuk pencari kerja atau tenaga kerja yang sedang bekerja ( Karyawan, Buruh, Peserta Pelatihan / Anggota Lembaga Ketenagakerjaan )'),
          ),
          const Padding(
              padding: EdgeInsets.only(top: 5, left: 5, right: 5),
              child: BccRowInfo1(
                  assetName: 'assets/icons/clarity_check-circle-solid.png',
                  info:
                      'Lengkapi form dibawah ini dengan mengisi data yang benar')),
          const Padding(
              padding: EdgeInsets.only(top: 5, left: 5, right: 5),
              child: BccRowInfo1(
                  assetName: 'assets/icons/clarity_check-circle-solid.png',
                  info:
                      'Setelah pendaftaran selesai, lakukan aktivasi email dan isi biodata dengan baik')),
        ],
      ),
    );
  }
}
