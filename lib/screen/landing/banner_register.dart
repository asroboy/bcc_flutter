import 'package:bcc/bccwidgets/bcc_big_banner_button.dart';
import 'package:bcc/screen/landing/banner_text_rich.dart';
import 'package:bcc/screen/register/register_pencari_kerja_screen.dart';
import 'package:bcc/screen/register/register_perusahaan_screen.dart';
import 'package:flutter/material.dart';

class BannerRegister extends StatelessWidget {
  const BannerRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370,
      padding: const EdgeInsets.all(15),
      child: Stack(children: [
        Image.asset(
          'assets/images/img_banner_register.png',
          width: MediaQuery.of(context).size.width / 2,
        ),
        const Positioned(right: 10, top: 45, child: BannerTextRich()),
        Positioned(
            bottom: 5,
            left: 5,
            right: 5,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: BccBigBannerButton(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterPencariKerjaScreen()),
                              (Route<dynamic> route) => true,
                            );
                          },
                          iconData: Icons.people_alt_outlined,
                          label: 'Daftar Akun \nPencari Kerja'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: BccBigBannerButton(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterPerusahaanScreen()),
                              (Route<dynamic> route) => true,
                            );
                          },
                          iconData: Icons.maps_home_work_outlined,
                          label: 'Daftar Akun \nPerusahaan'),
                    )
                  ],
                )
              ],
            ))
      ]),
    );
  }
}
