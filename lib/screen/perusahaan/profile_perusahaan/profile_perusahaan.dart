import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/landing_tab.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/alamat_perusahaan/alamat_perusahaan.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/badan_hukum/badan_hukum_usaha.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/dokumen_perusahaan.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/informasi_akun.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/pic.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/profle_menu_widget.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/ubah_password.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/ubah_profil_perusahaan.dart';
import 'package:bcc/state_management/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class ProfilePerusahaan extends StatefulWidget {
  const ProfilePerusahaan({super.key});

  @override
  State<ProfilePerusahaan> createState() => _ProfilePerusahaanState();
}

class _ProfilePerusahaanState extends State<ProfilePerusahaan> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool isLoading = false;

  // final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();
  dynamic _profilPerusahaan;

  _getProfilPerusahaan() {
    String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getProfilPerusahaan(idPerusahaan, token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  _profilPerusahaan = response['data'];
                  Provider.of<UserLoginModel>(context, listen: false)
                      .setProfilePerusahaan(_profilPerusahaan);
                  // log('profil perusahaan result $_profilPerusahaan');
                  // _dataPengalamanBekerja.addAll(biodataPencaker['experience']);
                  // _dataPendidikanPencaker.addAll(biodataPencaker['education']);
                  // _dataSertifikat.addAll(biodataPencaker['certificate']);
                  // _dataSkill.addAll(biodataPencaker['skill']);
                  isLoading = false;
                });
              });
        }
      },
    );
  }

  @override
  void initState() {
    _getProfilPerusahaan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, UserLoginModel model, _) => Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                /// -- IMAGE
                Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: const Color.fromARGB(255, 209, 208, 208)),
                      child: model.profilPerusahaan['logo'] == '' ||
                              model.profilPerusahaan['logo'] == null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: const Icon(
                                Icons.assured_workload,
                                size: 45,
                              ))
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                model.profilPerusahaan['logo'],
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) {
                                  return ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: const Icon(
                                        Icons.assured_workload,
                                        size: 45,
                                      ));
                                },
                              )),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: const Color.fromARGB(255, 83, 123, 161),
                                width: 0.2),
                            color: Colors.white),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                isLoading
                    ? const Text('')
                    : Text(
                        model.profilPerusahaan == null
                            ? ''
                            : model.profilPerusahaan['name'],
                        style: Theme.of(context).textTheme.headlineSmall),
                isLoading
                    ? const Text('')
                    : Text(
                        model.profilPerusahaan == null
                            ? ''
                            : model.profilPerusahaan['about_company'],
                        style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 10),

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        builder: (context) => UbahProfilPerusahaan(
                          profilPerusahaan: _profilPerusahaan,
                        ),
                      ))
                          .then(
                        (value) {
                          if (value == 'OK') {
                            _getProfilPerusahaan();
                          }
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text('Ubah Profil',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                const SizedBox(height: 15),
                const Divider(
                  endIndent: 10,
                  indent: 10,
                  thickness: 0.65,
                ),
                const SizedBox(height: 10),

                /// -- MENU
                ProfileMenuWidget(
                    title: "Informasi Akun",
                    icon: Icons.info,
                    onPress: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(
                        builder: (context) => InformasiAkunPerusahaan(
                          profilPerusahaan: _profilPerusahaan,
                        ),
                      ))
                          .then(
                        (value) {
                          if (value == 'OK') {
                            _getProfilPerusahaan();
                          }
                        },
                      );
                    }),
                ProfileMenuWidget(
                    title: "Alamat Perusahaan",
                    icon: Icons.location_on,
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AlamatPerusahaan(),
                      ));
                    }),
                ProfileMenuWidget(
                    title: "Identitas PIC",
                    icon: Icons.person,
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Pic(
                          profilPerusahaan: _profilPerusahaan,
                        ),
                      ));
                    }),
                ProfileMenuWidget(
                    title: "Dokumen Perusahaan",
                    icon: Icons.description,
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DokumenPerusahaan(),
                      ));
                    }),
                ProfileMenuWidget(
                    title: "Badan Hukum/Usaha",
                    icon: Icons.policy,
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BadanHukumUsaha(),
                      ));
                    }),
                const Divider(
                  endIndent: 10,
                  indent: 10,
                  thickness: 0.65,
                ),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                    title: "Kata Sandi",
                    icon: Icons.password,
                    onPress: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UbahPassword(
                          profilPerusahaan: _profilPerusahaan,
                        ),
                      ));
                    }),
                ProfileMenuWidget(
                    title: "Keluar",
                    icon: Icons.logout,
                    textColor: Colors.red,
                    endIcon: false,
                    onPress: () {
                      showAlertDialogWithAction2(
                          'Apakah yakin ingin keluar?', context, () {
                        Navigator.of(context).pop();
                      }, () {
                        _logout(context);
                      }, 'Batal', 'OK');
                      // Get.defaultDialog(
                      //   title: "LOGOUT",
                      //   titleStyle: const TextStyle(fontSize: 20),
                      //   content: const Padding(
                      //     padding: EdgeInsets.symmetric(vertical: 15.0),
                      //     child: Text("Are you sure, you want to Logout?"),
                      //   ),
                      //   confirm: Expanded(
                      //     child: ElevatedButton(
                      //       onPressed: () =>
                      //           AuthenticationRepository.instance.logout(),
                      //       style: ElevatedButton.styleFrom(
                      //           backgroundColor: Colors.redAccent,
                      //           side: BorderSide.none),
                      //       child: const Text("Yes"),
                      //     ),
                      //   ),
                      //   cancel: OutlinedButton(
                      //       onPressed: () => Get.back(), child: const Text("No")),
                      // );
                    }),
              ],
            ),
          ),
        ),
      ),
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
}
