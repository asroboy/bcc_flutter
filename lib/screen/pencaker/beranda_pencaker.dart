// import 'package:bcc/bccwidgets/bcc_circle_loading_indicator.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/landing_grid_pencaker.dart';
import 'package:bcc/screen/pencaker/profil/ubah_biodata.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

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

  getProfileImage() {
    return ((userInfo['photo'] == null ||
            userInfo['photo'] == '' ||
            isErrorImageProfile)
        ? const AssetImage('assets/images/male.png')
        : NetworkImage(userInfo['photo']));

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              ),
            ),
            Positioned(
              right: MediaQuery.of(context).size.width / 2 - 65,
              bottom: 0,
              child: Material(
                elevation: 4,
                color: Colors.white,
                type: MaterialType.circle,
                child: Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Center(
                    child: IconButton(
                      color: Constants.colorBiruGelap,
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const UbahBiodata(),
                        ));
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        Container(
            margin: const EdgeInsets.all(15),
            child: Column(children: [
              Text(
                '${userInfo['name']}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: Theme.of(context).colorScheme.primary),
              ),

              //  Text(
              //     '${userInfo['headline']}',
              //   ),
              Text(
                '${userInfo['address']}',
                textAlign: TextAlign.center,
              ),
              userInfo['verified_email'] == '1'
                  ? const Center()
                  : Text(
                      Constants.infoEmailNotVerified,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 60, 0)),
                    ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                height: 0.5,
                color: Colors.white,
              ),
            ])),
        LandingGridPencaker(
          userInfo: userInfo,
        ),
      ]),
    );
  }
}
