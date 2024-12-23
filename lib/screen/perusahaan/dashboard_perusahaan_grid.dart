import 'package:bcc/bccwidgets/bcc_big_menu_button.dart';
import 'package:bcc/screen/landing/careercanter/career_center_screen.dart';
import 'package:bcc/screen/landing/disnaker/disnaker_screen.dart';
import 'package:bcc/screen/landing/info/informasi_publik.dart';
// import 'package:bcc/screen/landing/lowongan/lowongan_list_screen.dart';
// import 'package:bcc/screen/landing/lowongan/lowongan_page_with_appbar.dart';
import 'package:bcc/screen/landing/pelayanan/pelayanan_screen.dart';
import 'package:bcc/screen/landing/preneur/preneur_screen.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/management_lowongan.dart';
import 'package:flutter/material.dart';

class DashboardPerusahaanGrid extends StatelessWidget {
  const DashboardPerusahaanGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      primary: false,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      childAspectRatio: (MediaQuery.of(context).size.height /
          MediaQuery.of(context).size.height *
          1.5),
      children: <Widget>[
        BccBigMenuButton(
          iconData: Icons.description_outlined,
          label: "Pelayanan",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PelayananScreen(),
            ));
          },
        ),
        BccBigMenuButton(
          iconData: Icons.work_outline_sharp,
          label: "Lowongan Kerja",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const ManagementLowongan(),
            ));
          },
        ),
        BccBigMenuButton(
          iconData: Icons.filter_center_focus_rounded,
          label: "Career Center",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const CareerCenterScreen(),
            ));
          },
        ),
        BccBigMenuButton(
          iconData: Icons.info,
          label: "Informasi Publik",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const InformasiPublik(),
            ));
          },
        ),
        BccBigMenuButton(
          iconData: Icons.maps_home_work_outlined,
          label: "BCC-Preneur",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const PreneurScreen(),
            ));
          },
        ),
        BccBigMenuButton(
          iconData: Icons.light_mode_outlined,
          label: "Disnaker",
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const DisnakerScreen(),
            ));
          },
        ),
      ],
    );
  }
}
