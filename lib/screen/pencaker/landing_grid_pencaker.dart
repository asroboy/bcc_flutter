import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_big_menu_button.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/lowongan/lowongan_page_with_appbar.dart';
import 'package:bcc/screen/pencaker/antrian_online/antrian_online.dart';
import 'package:bcc/screen/pencaker/balai_latihan_kerja/balai_latihan_kerja.dart';
import 'package:bcc/screen/pencaker/whishlist/list_pekerjaan_disimpan.dart';
import 'package:bcc/screen/pencaker/profil/identitas_diri.dart';
import 'package:bcc/screen/pencaker/riwayat/riwayat_lamaran.dart';
import 'package:flutter/material.dart';

class LandingGridPencaker extends StatelessWidget {
  const LandingGridPencaker(
      {super.key, required this.userInfo, required this.isAkunLengkap});
  final dynamic userInfo;
  final bool isAkunLengkap;

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
            label: "Lowongan Pekerjaan",
            onTap: () {
              if (isAkunLengkap) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LowonganPageWithAppBar(),
                ));
              } else {
                showAlertDialogWithTitle(
                    'Lengkapi data diri',
                    'Lengkapi data diri terlebih dahulu untuk mengakses menu ini',
                    context);
              }
            }),
        BccBigMenuButton(
            iconData: Icons.work_history_outlined,
            label: "Riwayat Lamaran",
            onTap: () {
              if (isAkunLengkap) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RiwayatLamaran(),
                ));
              } else {
                showAlertDialogWithTitle(
                    'Lengkapi data diri',
                    'Lengkapi data diri terlebih dahulu untuk mengakses menu ini',
                    context);
              }
            }),
        BccBigMenuButton(
          iconData: Icons.bookmark_outline,
          label: "Pekerjaan Disimpan",
          onTap: () {
            if (isAkunLengkap) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ListPekerjaanDisimpan(),
              ));
            } else {
              showAlertDialogWithTitle(
                  'Lengkapi data diri',
                  'Lengkapi data diri terlebih dahulu untuk mengakses menu ini',
                  context);
            }
          },
        ),
        BccBigMenuButton(
          iconData: Icons.confirmation_num_outlined,
          label: "Antrian Online",
          onTap: () {
            if (isAkunLengkap) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const AntrianOnline(
                  userType: UserType.jobseeker,
                ),
              ));
            } else {
              showAlertDialogWithTitle(
                  'Lengkapi data diri',
                  'Lengkapi data diri terlebih dahulu untuk untuk mengakses menu ini',
                  context);
            }
          },
        ),
        BccBigMenuButton(
          iconData: Icons.business_center_outlined,
          label: "Balai Latihan Kerja",
          onTap: () {
            if (isAkunLengkap) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const BalaiLatihanKerja(),
              ));
            } else {
              showAlertDialogWithTitle(
                  'Lengkapi data diri',
                  'Lengkapi data diri terlebih dahulu untuk mengakses menu ini',
                  context);
            }
          },
        ),
      ],
    );
  }
}
