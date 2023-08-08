import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/screen/register/register_pencari_kerja_screen.dart';
import 'package:bcc/screen/register/register_perusahaan_screen.dart';
import 'package:flutter/material.dart';

class PilihJenisUserScreen extends StatefulWidget {
  const PilihJenisUserScreen({super.key});

  @override
  State<PilihJenisUserScreen> createState() => _PilihJenisUserScreenState();
}

class _PilihJenisUserScreenState extends State<PilihJenisUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/icons/ic_back.png',
            ),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
          child: Container(
        width: 320,
        margin: const EdgeInsets.only(top: 100),
        child: Column(
          children: [
            Image.asset(
              "assets/images/ICON_8.png",
              width: 120,
              height: 120,
            ),
            const Padding(padding: EdgeInsets.only(top: 20)),
            const Text(
              'Kamu ingin daftar sebagai apa?',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            BccButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPencariKerjaScreen()),
                  (Route<dynamic> route) => true,
                );
              },
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: const Text('Pencari Kerja'),
            ),
            BccButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterPerusahaanScreen()),
                  (Route<dynamic> route) => true,
                );
              },
              padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
              child: const Text('Perusahaan'),
            ),
          ],
        ),
      )),
    );
  }
}
