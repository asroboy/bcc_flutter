import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/dashboard_tab_pencaker.dart';
import 'package:bcc/state_management/user_login_model.dart';
import 'package:bcc/screen/perusahaan/dashboard_tab_perusahaan.dart';
import 'package:bcc/screen/pilih_jenis_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _loginSebagai = 'Pencari Kerja';

  final TextEditingController _usernameController = TextEditingController(),
      _passwordController = TextEditingController();

  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  @override
  void initState() {
    _loginSebagai = 'Pencari Kerja';
    super.initState();
  }

  _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username == '') {
      showAlertDialog('Masukkan username', context);
      return;
    }

    if (password == '') {
      showAlertDialog('Masukkan password', context);
      return;
    }
    if (_loginSebagai == 'Pencari Kerja') {
      _apiCall
          .login(username, password, Constants.pathLoginPencaker)
          .then((value) {
        // log('result login $value');
        log('success ${value['success']}');
        log('code ${value['code']}');
        _apiHelper.apiCallResponseHandler(
            response: value,
            context: mounted ? context : null,
            onSuccess: (response) {
              log('result login $response');
              _simpanUser(response, Constants.userPencaker);
              _redirectToMainPagePencaker();
            });
      });
    } else {
      _apiCall
          .login(username, password, Constants.pathLoginPerusahaan)
          .then((value) {
        log('success ${value['success']}');
        log('code ${value['code']}');
        _apiHelper.apiCallResponseHandler(
            response: value,
            context: mounted ? context : null,
            onSuccess: (response) {
              _simpanUser(response, Constants.userPerusahaan);
              _redirectToMainPagePerusahaan();
            });
      });
    }
  }

  _simpanUser(dynamic loginResult, String userType) {
    final box = GetStorage();
    box.write(Constants.loginInfo, loginResult);
    box.write(Constants.userType, userType);
    if (userType == Constants.userPencaker) {
      Provider.of<UserLoginModel>(context, listen: false).reloadDataPencaker();
    } else {
      Provider.of<UserLoginModel>(context, listen: false).reloadDataCompany();
    }
  }

  _redirectToMainPagePencaker() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DashboardTabPencaker()),
      (Route<dynamic> route) => false,
    );
  }

  _redirectToMainPagePerusahaan() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const DashboardTabPerusahaan()),
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, UserLoginModel model, _) => Scaffold(
              body: Center(
                child: Container(
                  width: 320,
                  height: 450,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Constants.boxColorBlueTrans),
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/ICON_8.png",
                        width: 120,
                        height: 120,
                      ),
                      Text(
                        'Login Sebagai',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Constants.colorBiruGelap),
                      ),
                      Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          margin: const EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.blue, width: 1),
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              DropdownButton(
                                  isExpanded: true,
                                  isDense: true,
                                  underline: const SizedBox(),
                                  alignment: Alignment.center,
                                  value: _loginSebagai,
                                  items: const [
                                    DropdownMenuItem(
                                      value: 'Pencari Kerja',
                                      child: Center(
                                          child: Text(
                                        'Pencari Kerja',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                    DropdownMenuItem(
                                      value: 'Perusahaan',
                                      child: Center(
                                          child: Text(
                                        'Perusahaan',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      )),
                                    )
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      _loginSebagai = value!;
                                    });
                                  })
                            ],
                          )),
                      BccTextFormField(
                        hint: 'Username',
                        controller: _usernameController,
                        inputType: TextInputType.emailAddress,
                      ),
                      BccTextFormField(
                        hint: 'Password',
                        inputType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        padding:
                            const EdgeInsets.only(left: 15, right: 15, top: 5),
                      ),
                      BccButton(
                        onPressed: () {
                          _login();
                        },
                        padding:
                            const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: const Text(
                          'Masuk',
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
                              'Belum Punya Akun?',
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
                                          const PilihJenisUserScreen()),
                                  (Route<dynamic> route) => true,
                                );
                              },
                              child: const Text(
                                'Daftar Disini',
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
                ),
              ),
            ));
  }
}
