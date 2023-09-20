import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_big_menu_button.dart';
import 'package:bcc/screen/landing/lowongan/lowongan_page_with_appbar.dart';
import 'package:bcc/screen/pencaker/antrian_online.dart';
import 'package:bcc/screen/pencaker/balai_latihan_kerja.dart';
import 'package:bcc/screen/pencaker/whishlist/list_pekerjaan_disimpan.dart';
import 'package:bcc/screen/pencaker/profil/identitas_diri.dart';
import 'package:bcc/screen/pencaker/riwayat/riwayat_lamaran.dart';
import 'package:flutter/material.dart';

class LandingGridPencaker extends StatelessWidget {
  const LandingGridPencaker({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      childAspectRatio: (MediaQuery.of(context).size.height /
          MediaQuery.of(context).size.height *
          1.5),
      children: <Widget>[
        BccBigMenuButton(
          iconData: Icons.badge_outlined,
          label: "Identitas Diri",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const IdentitasDiri(),
            ));
          },
        ),
        BccBigMenuButton(
          iconData: Icons.work_outline,
          label: "Lowongan Pekerjaan ",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const LowonganPageWithAppBar(),
            ));
          },
        ),
        BccBigMenuButton(
          iconData: Icons.work_history_outlined,
          label: "Riwayat Lamaran",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const RiwayatLamaran(),
            ));
          },
        ),
        BccBigMenuButton(
          iconData: Icons.bookmark_outline,
          label: "Pekerjaan Disimpan",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ListPekerjaanDisimpan(),
            ));
          },
        ),
        BccBigMenuButton(
          iconData: Icons.confirmation_num_outlined,
          label: "Antrian Online",
          onTap: () {
            showAlertDialogWithAction(
                'Fitur ini untuk saat ini belum bisa digunakan', context, () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AntrianOnline(),
              ));
            }, 'OK');
          },
        ),
        BccBigMenuButton(
          iconData: Icons.business_center_outlined,
          label: "Balai Latihan Kerja",
          onTap: () {
            showAlertDialogWithAction(
                'Fitur ini untuk saat ini belum bisa digunakan', context, () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BalaiLatihanKerja(),
              ));
            }, 'OK');
          },
        ),
      ],
    );
  }
}
