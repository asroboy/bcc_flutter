import 'package:bcc/bccwidgets/bcc_big_menu_button.dart';
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
      children: const <Widget>[
        BccBigMenuButton(
          iconData: Icons.description_outlined,
          label: "Identitas Diri",
        ),
        BccBigMenuButton(
          iconData: Icons.work_outline_sharp,
          label: "Antrian Online",
        ),
        BccBigMenuButton(
          iconData: Icons.filter_center_focus_rounded,
          label: "Info Lowongan ",
        ),
        BccBigMenuButton(
          iconData: Icons.info,
          label: "Riwayat Lamaran",
        ),
        BccBigMenuButton(
          iconData: Icons.maps_home_work_outlined,
          label: "Balai Latihan Kerja",
        ),
        BccBigMenuButton(
          iconData: Icons.light_mode_outlined,
          label: "BCC Preneur",
        ),
      ],
    );
  }
}
