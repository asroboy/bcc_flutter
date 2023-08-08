import 'package:bcc/bccwidgets/bcc_big_menu_button.dart';
import 'package:flutter/material.dart';

class LandingGrid extends StatelessWidget {
  const LandingGrid({super.key});

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
      children: const <Widget>[
        BccBigMenuButton(
          iconData: Icons.description_outlined,
          label: "Pelayanan",
        ),
        BccBigMenuButton(
          iconData: Icons.work_outline_sharp,
          label: "Lowongan Kerja",
        ),
        BccBigMenuButton(
          iconData: Icons.filter_center_focus_rounded,
          label: "Career Center",
        ),
        BccBigMenuButton(
          iconData: Icons.info,
          label: "Informasi Publik",
        ),
        BccBigMenuButton(
          iconData: Icons.maps_home_work_outlined,
          label: "BCC-Preneur",
        ),
        BccBigMenuButton(
          iconData: Icons.light_mode_outlined,
          label: "Disnaker",
        ),
      ],
    );
  }
}
