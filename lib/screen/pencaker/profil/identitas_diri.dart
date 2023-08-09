import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/bcc_subheader_label.dart';
import 'package:bcc/screen/pencaker/profil/pengalaman_bekerja.dart';
import 'package:bcc/screen/pencaker/profil/tambah_pendidikan.dart';
import 'package:bcc/screen/pencaker/profil/tambah_sertifikat.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class IdentitasDiri extends StatefulWidget {
  const IdentitasDiri({super.key});

  @override
  State<IdentitasDiri> createState() => _IdentitasDiriState();
}

class _IdentitasDiriState extends State<IdentitasDiri> {
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  dynamic userInfo;

  @override
  void initState() {
    super.initState();
    userInfo = loginInfo['data'];
  }

  getProfileImage() {
    return ((userInfo['photo'] == null && userInfo['photo'] == '')
        ? const AssetImage('assets/images/male.png')
        : NetworkImage(userInfo['photo']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Identitas Diri'),
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
                              fit: BoxFit.cover, image: getProfileImage()))),
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
                        onPressed: () {},
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
                // Text(
                //   '${userInfo['headline']}',
                // ),
                Text(
                  '${userInfo['address']}',
                  textAlign: TextAlign.center,
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, top: 10),
                  height: 0.5,
                  color: Colors.white,
                ),
              ])),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BccSubheaderLabel(label: 'BIODATA DIRI'),
                const BccSubheaderLabel(
                  label: 'Tentang Saya',
                ),
                BccSubheaderLabel(
                  label: 'Riwayat Pendidikan',
                  showButton: true,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TambahPendidikan(),
                    ));
                  },
                ),
                BccSubheaderLabel(
                  label: 'Pengalaman Bekerja',
                  showButton: true,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const PengalamanBekerja(),
                    ));
                  },
                ),
                BccSubheaderLabel(
                  label: 'Lisensi & Sertifikat',
                  showButton: true,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const TambahSertifikat(),
                    ));
                  },
                ),
                const BccSubheaderLabel(label: 'Keterampilan'),
              ],
            ),
          )
        ]));
  }
}
