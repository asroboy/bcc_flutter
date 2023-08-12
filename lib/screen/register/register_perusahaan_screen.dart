import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_row_info1.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/login_screen.dart';
import 'package:bcc/screen/register/register_complete.dart';
import 'package:flutter/material.dart';

class RegisterPerusahaanScreen extends StatefulWidget {
  const RegisterPerusahaanScreen({super.key});

  @override
  State<RegisterPerusahaanScreen> createState() =>
      _RegisterPerusahaanScreenState();
}

class _RegisterPerusahaanScreenState extends State<RegisterPerusahaanScreen> {
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
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 20),
        child: ListView(
          children: [
            Text(
              'PENDAFTARAN AKUN \nSEGABAI PERUSAHAAN',
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
                  info: ('Setelah pendaftaran selesai dan telah melengkapi semua data yang ') +
                      ('dibutuhkan, Anda diharuskan datang ke Disnaker Kabupaten Bogor ') +
                      ('untuk verifikasi data dengan membawa kelengkapan sebagai berikut:\n') +
                      ('1.) Fotocopy Nomor Induk Berusaha (NIB) Perusahaan.\n') +
                      ('2.) Surat Permohonan Pengajuan Kebutuhan Tenaga Kerja dari ') +
                      ('Perusahaan yang ditujukan kepada Disnaker Kabupaten Bogor.\n') +
                      ('3.) KTP Penanggung Jawab Perusahaan.\n') +
                      ('4.) Cap Perusahaan.')),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                child: BccRowInfo1(
                    assetName: 'assets/icons/clarity_check-circle-solid.png',
                    info:
                        'Setelah verifikasi data selesai maka administrator Disnaker akan mengaktifkan akun anda.')),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: ShapeDecoration(
                color: Constants.boxColorBlueTrans,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      'BUAT AKUN  PERUSAHAAN',
                      style: TextStyle(
                        color: Constants.colorBiruGelap,
                        fontSize: 14,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.14,
                      ),
                    ),
                  ),
                  const BccTextFormFieldInput(
                    hint: 'Username*',
                    padding: EdgeInsets.only(top: 15),
                  ),
                  const BccTextFormFieldInput(
                    hint: 'Password*',
                    padding: EdgeInsets.only(top: 15),
                  ),
                  const BccTextFormFieldInput(
                    hint: 'Konfirmasi Password',
                    padding: EdgeInsets.only(top: 15),
                  ),
                  const BccTextFormFieldInput(
                    hint: 'Email',
                    padding: EdgeInsets.only(top: 15),
                  ),
                  BccButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RegisterComplete(),
                      ));
                    },
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: const Text('Selanjutnya'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Sudah Punya Akun?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFB5B2B2),
                            fontSize: 14,
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.14,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(left: 10)),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: const Text(
                            'Login Disini',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF003673),
                              fontSize: 14,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.14,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
