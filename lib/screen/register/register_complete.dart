import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/landing_screen.dart';
import 'package:bcc/screen/landing/landing_tab.dart';
import 'package:flutter/material.dart';

class RegisterComplete extends StatelessWidget {
  const RegisterComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/img_complete.png',
              height: 200,
              width: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                'Pendaftaran Berhasil di Buat Silahkan\ncek email untuk verifikasi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.colorGrey,
                  fontSize: 14,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.24,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 80),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LandingTab()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text(
                    'Kembali ke Beranda',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF15406A),
                      fontSize: 14,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.24,
                    ),
                  ),
                ))
          ],
        ),
      ),
    ));
  }
}
