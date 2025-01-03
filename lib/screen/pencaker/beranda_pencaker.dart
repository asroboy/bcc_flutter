// import 'package:bcc/bccwidgets/bcc_circle_loading_indicator.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/landing_tab.dart';
import 'package:bcc/screen/pencaker/landing_grid_pencaker.dart';
// import 'package:bcc/screen/pencaker/profil/ubah_biodata.dart';
import 'package:bcc/state_management/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class BerandaPencaker extends StatefulWidget {
  const BerandaPencaker({super.key});

  @override
  State<BerandaPencaker> createState() => _BerandaPencakerState();
}

class _BerandaPencakerState extends State<BerandaPencaker> {
  // final ApiCall _apiCall = ApiCall();
  // final ApiHelper _apiHelper = ApiHelper();
  // bool _isLoadingLowongan = false;
  // bool _isLoadingPerusahaan = false;

  // List<dynamic> dataLowonganPopuler = [];
  // List<dynamic> dataPerusahaanTerbaru = [];

  bool isErrorImageProfile = false;

  getProfileImage(UserLoginModel model) {
    if (model.isLoading) {
      return const AssetImage('assets/images/male.png');
    }
    dynamic userInfo_ = model.profilPencaker;
    if (userInfo_ == null) {
      return const AssetImage('assets/images/male.png');
    }
    return ((userInfo_['photo'] == null ||
            userInfo_['photo'] == '' ||
            isErrorImageProfile)
        ? const AssetImage('assets/images/male.png')
        : NetworkImage(userInfo_['photo']));

    // ((userInfo['photo'] == null ||
    //         userInfo['photo'] == '' ||
    //         isErrorImageProfile)
    //     ? const AssetImage('assets/images/male.png')
    //     : Image.network(
    //         userInfo['photo'],
    //         errorBuilder: (context, error, stackTrace) {
    //           return Image.asset('assets/images/male.png');
    //         },
    //       ));
  }

  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  dynamic userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = loginInfo['data'];
    Provider.of<UserLoginModel>(context, listen: false).loadDataPencaker(
      (response) {
        if (response['message'] ==
            'Token Akses Sudah Kedaluarsa, Silahkan Login Kembali.') {
          showAlertDialogWithAction(response['message'], context, () {
            _logout(context);
          }, 'Ok');
        } else {
          showAlertDialog(
              response['message'] ??
                  'Terjadi kendala silahkan coba lagi setelah beberapa saat',
              context);
        }
      },
    );
  }

  _logout(BuildContext context) {
    GetStorage().remove(Constants.loginInfo);
    GetStorage().remove(Constants.userType);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LandingTab()),
      (Route<dynamic> route) => true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, UserLoginModel model, _) => Scaffold(
              appBar: AppBar(
                title: const Text(''),
              ),
              body: ListView(children: [
                Stack(
                  children: [
                    Container(
                      height: 130,
                    ),
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          color: Constants.colorBiruGelap,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0))),
                    ),
                    Container(
                      height: 100,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(0),
                            bottomRight: Radius.circular(0)),
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/bg_batik_detil.png'),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                // borderRadius: BorderRadius.circular(35),
                                color: Colors.white,
                                border: Border.all(width: 0.25),
                                image: DecorationImage(
                                    onError: (e, s) {
                                      setState(() {
                                        isErrorImageProfile = true;
                                      });
                                    },
                                    fit: BoxFit.cover,
                                    image: getProfileImage(model)))),
                      ),
                    ),
                  ],
                ),
                model.isLoading
                    ? Padding(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.3),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : Container(
                        margin: const EdgeInsets.all(15),
                        child: Column(children: [
                          Text(
                            model.profilPencaker == null
                                ? ''
                                : '${model.profilPencaker['name'] ?? ''}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          Text(
                            model.profilPencaker == null
                                ? ''
                                : '${model.profilPencaker['headline'] ?? ''}',
                            style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          Text(
                            model.profilPencaker == null
                                ? ''
                                : '${model.profilPencaker['address']},  ${model.profilPencaker['master_village_name']}, ${model.profilPencaker['master_district_name']}, ${model.profilPencaker['master_city_name']}, ${model.profilPencaker['master_province_name']}',
                            textAlign: TextAlign.center,
                          ),
                          model.profilPencaker == null
                              ? const Center()
                              : model.profilPencaker['verified_email'] == '1'
                                  ? const Center()
                                  : Card(
                                      color: Colors.red[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          Constants.infoEmailNotVerified,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 136, 15, 6)),
                                        ),
                                      ),
                                    ),
                          model.profilPencaker == null
                              ? const Center()
                              : model.profilPencaker['photo'] != null &&
                                      model.profilPencaker['ktp_file'] !=
                                          null &&
                                      model.profilPencaker['ijazah_file'] !=
                                          null
                                  ? const Center()
                                  : Card(
                                      color: Colors.orange[100],
                                      child: Padding(
                                        padding: const EdgeInsets.all(
                                          10,
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                              Constants.infoFileBelumDiupload,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 121, 76, 9)),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                    model.profilPencaker[
                                                                'photo'] ==
                                                            null
                                                        ? Icons.close
                                                        : Icons.check,
                                                    color: model.profilPencaker[
                                                                'photo'] ==
                                                            null
                                                        ? Colors.red
                                                        : Colors.green),
                                                const Text(
                                                  '1. Foto Profil',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 121, 76, 9)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                    model.profilPencaker[
                                                                'ktp_file'] ==
                                                            null
                                                        ? Icons.close
                                                        : Icons.check,
                                                    color: model.profilPencaker[
                                                                'ktp_file'] ==
                                                            null
                                                        ? Colors.red
                                                        : Colors.green),
                                                const Text(
                                                  '2. KTP',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 121, 76, 9)),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                    model.profilPencaker[
                                                                'ijazah_file'] ==
                                                            null
                                                        ? Icons.close
                                                        : Icons.check,
                                                    color: model.profilPencaker[
                                                                'ijazah_file'] ==
                                                            null
                                                        ? Colors.red
                                                        : Colors.green),
                                                const Text(
                                                  '3. Ijazah Terakhir',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 121, 76, 9)),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              Constants.infoFileBelumDiupload2,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 121, 76, 9)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 10, top: 10),
                            height: 0.5,
                            color: Colors.white,
                          ),
                        ])),
                model.isLoading || model.profilPencaker == null
                    ? const Center()
                    : LandingGridPencaker(
                        userInfo: userInfo,
                        isAkunLengkap: _isAkunLengkap(model.profilPencaker),
                      ),
              ]),
            ));
  }

  bool _isAkunLengkap(dynamic profilPencaker) {
    return profilPencaker['photo'] != null &&
        profilPencaker['ktp_file'] != null &&
        profilPencaker['ijazah_file'] != null &&
        profilPencaker['verified_email'] == '1';
  }
}
