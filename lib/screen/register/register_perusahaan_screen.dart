import 'dart:developer';

import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_row_info1.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/login_screen.dart';
import 'package:bcc/screen/register/register_company_next_screen.dart';
// import 'package:bcc/screen/register/register_complete.dart';
import 'package:flutter/material.dart';

class RegisterPerusahaanScreen extends StatefulWidget {
  const RegisterPerusahaanScreen({super.key});

  @override
  State<RegisterPerusahaanScreen> createState() =>
      _RegisterPerusahaanScreenState();
}

class _RegisterPerusahaanScreenState extends State<RegisterPerusahaanScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

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
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      BccTextFormFieldInput(
                        hint: 'Username*',
                        controller: _usernameController,
                        autofocus: true,
                        validator: _usernameErrorType,
                        onChanged: _validasiUsername,
                        padding: const EdgeInsets.only(top: 15),
                      ),
                      BccTextFormFieldInput(
                        hint: 'Password*',
                        textInputType: TextInputType.visiblePassword,
                        onChanged: _validasiPassword,
                        validator: _passwordErrorType,
                        controller: _passwordController,
                        padding: const EdgeInsets.only(top: 15),
                      ),
                      BccTextFormFieldInput(
                        hint: 'Konfirmasi Password',
                        textInputType: TextInputType.visiblePassword,
                        validator: _konfirmasiPasswordErrorType,
                        controller: _ulangiPasswordController,
                        onChanged: _validasiKonfirmasiPassword,
                        padding: const EdgeInsets.only(top: 15),
                      ),
                      BccTextFormFieldInput(
                        hint: 'Email*',
                        controller: _emailController,
                        validator: _emailErrorType,
                        onChanged: _validateEmail,
                        padding: const EdgeInsets.only(top: 15),
                      ),
                      BccButton(
                        onPressed: _submitForm,
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 10),
                        child: const Text(
                          'Selanjutnya',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
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
                                      builder: (context) =>
                                          const LoginScreen()),
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
                ))
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    _validasiUsername(_usernameController.text);
    _validasiPassword(_passwordController.text);
    _validasiKonfirmasiPassword(_ulangiPasswordController.text);
    _validateEmail(_emailController.text);

    if (_isValidAllInput()) {
      if (_formKey.currentState!.validate()) {
        // Form is valid, proceed with your logic here
        // For this example, we will simply print the email
        log('Email: ${_emailController.text}');

        dynamic registerData = {
          'username': _usernameController.text,
          'password': _passwordController.text,
          'email': _emailController.text
        };
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => RegisterCompnayNextScreen(
            registerData: registerData,
          ),
        ));
      }
    }
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _ulangiPasswordController =
      TextEditingController();

  String? _usernameErrorType;
  String? _emailErrorType;
  String? _passwordErrorType;
  String? _konfirmasiPasswordErrorType;

  bool _isValidAllInput() {
    return (_usernameErrorType == null || _usernameErrorType == '') &&
        (_emailErrorType == null || _emailErrorType == '') &&
        (_passwordErrorType == null || _passwordErrorType == '') &&
        (_konfirmasiPasswordErrorType == null ||
            _konfirmasiPasswordErrorType == '');
  }

  void _validasiUsername(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _usernameErrorType = 'Username wajib diisi';
      });
    } else if (value.length <= 5) {
      setState(() {
        _usernameErrorType = 'Panjang username minimal 6 karakter';
      });
    } else if (value.contains(' ')) {
      setState(() {
        _usernameErrorType = 'Username tidak boleh menggunakan spasi';
      });
    } else {
      setState(() {
        _usernameErrorType = null;
      });
    }
  }

  void _validasiPassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _passwordErrorType = 'Password wajib diisi';
      });
    } else if (value.length <= 5) {
      setState(() {
        _passwordErrorType = 'Panjang password minimal 6 karakter';
      });
    } else {
      setState(() {
        _passwordErrorType = null;
      });
    }
  }

  void _validasiKonfirmasiPassword(String value) {
    if (value.isEmpty) {
      setState(() {
        _konfirmasiPasswordErrorType = 'Validasi password wajib diisi';
      });
    } else if (value.length <= 5) {
      setState(() {
        _konfirmasiPasswordErrorType = 'Panjang password minimal 6 karakter';
      });
    } else if (value != _passwordController.text) {
      setState(() {
        _konfirmasiPasswordErrorType = 'Validasi password tidak sesuai';
      });
    } else {
      setState(() {
        _konfirmasiPasswordErrorType = null;
      });
    }
  }

  void _validateEmail(String value) {
    if (value.isEmpty) {
      setState(() {
        _emailErrorType = 'Email wajib diisi';
      });
    } else if (!isEmailValid(value)) {
      setState(() {
        _emailErrorType = 'Masukkan alamat email yang valid';
      });
    } else {
      setState(() {
        _emailErrorType = null;
      });
    }
  }

  bool isEmailValid(String email) {
    // Basic email validation using regex
    // You can implement more complex validation if needed
    return RegExp(r'^[\w-\.]+@[a-zA-Z]+\.[a-zA-Z]{2,}$').hasMatch(email);
  }
}
