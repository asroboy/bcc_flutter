import 'dart:ffi';

import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/login_screen.dart';
import 'package:bcc/screen/register/informasi_pendaftaran.dart';
import 'package:bcc/screen/register/register_pencari_next_screen.dart';
import 'package:flutter/material.dart';

class RegisterPencariKerjaScreen extends StatefulWidget {
  const RegisterPencariKerjaScreen({super.key});

  @override
  State<RegisterPencariKerjaScreen> createState() =>
      _RegisterPencariKerjaScreenState();
}

class _RegisterPencariKerjaScreenState
    extends State<RegisterPencariKerjaScreen> {
  final TextEditingController _usernameController = TextEditingController(),
      _emailController = TextEditingController(),
      _passwordController = TextEditingController(),
      _ulangiPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        // leading: BackButton(
        //   color: Constants.colorBiruGelap,
        // ),
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
            const Padding(
              padding: EdgeInsets.only(top: 15),
            ),
            const InformasiPendaftaran(),
            const Padding(
              padding: EdgeInsets.only(top: 40),
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
                      'BUAT AKUN PENCARI KERJA',
                      style: TextStyle(
                        color: Constants.colorBiruGelap,
                        fontSize: 14,
                        fontFamily: 'Jost',
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.14,
                      ),
                    ),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Username*',
                    controller: _usernameController,
                    padding: const EdgeInsets.only(top: 10),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Email*',
                    controller: _emailController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Password*',
                    controller: _passwordController,
                    textInputType: TextInputType.visiblePassword,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccTextFormFieldInput(
                    hint: 'Konfirmasi Password*',
                    textInputType: TextInputType.visiblePassword,
                    controller: _ulangiPasswordController,
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  BccButton(
                    onPressed: () {
                      String username = _usernameController.text;
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      String ulangiPassword = _ulangiPasswordController.text;

                      if (username == '') {
                        showAlertDialog('Harap isi username', context);
                        return;
                      }

                      if (username.characters.length < 6) {
                        showAlertDialog('Username minimal 6 karakter', context);
                        return;
                      }

                      if (RegExp(r"\s").hasMatch(username) ||
                          RegExp('[A-Z]').hasMatch(username)) {
                        showAlertDialog(
                            'Jangan gunakan spasi dan huruf bedar untuk username',
                            context);
                        return;
                      }

                      if (email == '' ||
                          !email.contains('@') ||
                          !email.contains('.')) {
                        showAlertDialog(
                            'Harap isi email dengan valid', context);
                        return;
                      }

                      if (password == '') {
                        showAlertDialog('Harap isi password', context);
                        return;
                      }
                      if (password.length < 3) {
                        showAlertDialog('Passowrd minimal 3 karakter', context);
                        return;
                      }
                      if (ulangiPassword == '') {
                        showAlertDialog('Harap isi ulangi password', context);
                        return;
                      }

                      if (password != ulangiPassword) {
                        showAlertDialog('Ulangi password harus sama', context);
                        return;
                      }

                      var registerData = {
                        'username': username,
                        'password': password,
                        'email': email,
                        'password_ori': password
                      };

                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => RegisterPencariKerjaNextScreen(
                            registerData: registerData),
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
                              (Route<dynamic> route) => true,
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
