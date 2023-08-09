import 'package:bcc/api/helper.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/landing_tab.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ProfilPencakerScreen extends StatefulWidget {
  const ProfilPencakerScreen({super.key});

  @override
  State<ProfilPencakerScreen> createState() => _ProfilPencakerScreenState();
}

class _ProfilPencakerScreenState extends State<ProfilPencakerScreen> {
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  dynamic userInfo;
  bool isErrorImageProfile = false;

  @override
  void initState() {
    super.initState();
    userInfo = loginInfo['data'];
  }

  getProfileImage() {
    return ((userInfo['photo'] == null ||
            userInfo['photo'] == '' ||
            isErrorImageProfile)
        ? const AssetImage('assets/images/male.png')
        : NetworkImage(userInfo['photo']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
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
                      image: AssetImage('assets/images/bg_batik_detil.png'),
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
                                image: getProfileImage()))),
                  ))
            ],
          ),
          Container(
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Text(
                    '${userInfo['name']}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  Text(
                    '${userInfo['headline']}',
                  ),
                  Text(
                    '${userInfo['address']}',
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    height: 0.5,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tempat Lahir'),
                      Text('${userInfo['place_of_birth']}'),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tanggal Lahir'),
                      Text('${userInfo['date_of_birth']}'),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Jenis Kelamin'),
                      Text('${userInfo['gender']}'),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Agama'),
                      Text('${userInfo['religion']}'),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(top: 5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Agama'),
                      Text('${userInfo['religion']}'),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    height: 0.5,
                    color: Colors.white,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        showAlertDialogWithAction2(
                            'Apakah yakin ingin keluar', context, () {
                          Navigator.of(context).pop();
                        }, () {
                          _logout();
                        }, "Batal", 'OK');
                      },
                      child: const Text('Keluar'))
                ],
              )),
        ],
      ),
    );
  }

  _logout() {
    GetStorage().remove(Constants.loginInfo);
    GetStorage().remove(Constants.userType);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LandingTab()),
      (Route<dynamic> route) => true,
    );
  }
}
