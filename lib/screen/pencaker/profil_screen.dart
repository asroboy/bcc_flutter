import 'dart:async';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/bccwidgets/bcc_normal_button.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/landing_tab.dart';
import 'package:bcc/screen/pencaker/profil/bcc_subheader_label.dart';
import 'package:bcc/screen/pencaker/profil/pengalaman_bekerja.dart';
import 'package:bcc/screen/pencaker/profil/tambah_keterampilan.dart';
import 'package:bcc/screen/pencaker/profil/tambah_pendidikan.dart';
import 'package:bcc/screen/pencaker/profil/tambah_sertifikat.dart';
import 'package:bcc/screen/pencaker/profil/ubah_biodata.dart';
import 'package:bcc/state_management/user_login_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class ProfilPencakerScreen extends StatefulWidget {
  const ProfilPencakerScreen({super.key});

  @override
  State<ProfilPencakerScreen> createState() => _ProfilPencakerScreenState();
}

class _ProfilPencakerScreenState extends State<ProfilPencakerScreen> {
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();
  dynamic userInfo;
  bool isErrorImageProfile = false;

  bool isLoading = false;

  dynamic biodataPencaker;

  _fetchBiodataRinciPencaker() {
    String idPencaker = loginInfo['data']['unique_id'];
    String token = loginInfo['data']['token'];
    _apiCall
        .getDataRinci(Constants.pathDataPencaker, idPencaker, token)
        .then((value) {
      if (mounted) {
        _apiHelper.apiCallResponseHandler(
            response: value,
            context: context,
            onSuccess: (response) {
              setState(() {
                isLoading = false;
                biodataPencaker = response['data'];
                _dataPengalamanBekerja.addAll(biodataPencaker['experience']);
                _dataPendidikanPencaker.addAll(biodataPencaker['education']);
                _dataSertifikat.addAll(biodataPencaker['certificate']);
                _dataSkill.addAll(biodataPencaker['skill']);
              });
            },
            onFailedCallback: () {
              setState(() {
                isLoading = false;
              });
            });
      }
    });
  }

  final List<dynamic> _dataPendidikanPencaker = [];
  final List<dynamic> _dataPengalamanBekerja = [];
  final List<dynamic> _dataSertifikat = [];
  final List<dynamic> _dataSkill = [];

  @override
  void initState() {
    super.initState();
    isLoading = true;
    userInfo = loginInfo['data'];
    _fetchBiodataRinciPencaker();
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
    return Consumer(
      builder: (context, UserLoginModel model, _) => Scaffold(
        appBar: AppBar(
          title: const Text('Identitas Diri'),
          actions: [
            IconButton(
                onPressed: () {
                  _logout();
                },
                icon: const Icon(Icons.lock))
          ],
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
                            builder: (context) =>
                                UbahBiodata(biodataPencaker: biodataPencaker),
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
              margin: const EdgeInsets.only(left: 15, right: 15, top: 15),
              child: Column(children: [
                Text(
                  '${userInfo['name']}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.primary),
                ),
                // Text(
                //   '${userInfo['headline']}',
                // ),
                // Text(
                //   '${userInfo['address']}',
                //   textAlign: TextAlign.center,
                // ),
                Container(
                  margin: const EdgeInsets.only(bottom: 0, top: 10),
                  height: 0.5,
                  color: Colors.white,
                ),
              ])),
          isLoading
              ? Container(
                  margin: const EdgeInsets.only(top: 100),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BccSubheaderLabel(label: 'BIODATA DIRI'),
                      Row(
                        children: [
                          const Icon(
                            Icons.timer_outlined,
                            size: 18,
                          ),
                          const Padding(padding: EdgeInsets.only(right: 10)),
                          Text(
                              'Terdaftar sejak ${loginInfo['data']['created_at']}')
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.pin_drop_outlined,
                            size: 18,
                          ),
                          const Padding(padding: EdgeInsets.only(right: 10)),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text('${loginInfo['data']['address']}'),
                          )
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        children: [
                          const Icon(
                            Icons.alternate_email_outlined,
                            size: 18,
                          ),
                          const Padding(padding: EdgeInsets.only(right: 10)),
                          Text(
                              '${loginInfo['data']['email']}  ${loginInfo['data']['verified_email'] == '1' ? '(Terverifikasi)' : '(Belum terverifikasi)'}')
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      Row(
                        children: [
                          const Icon(
                            Icons.male_outlined,
                            size: 18,
                          ),
                          const Padding(padding: EdgeInsets.only(right: 10)),
                          Text('${loginInfo['data']['gender']}')
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5)),
                      const BccSubheaderLabel(
                        label: 'Tentang Saya',
                      ),
                      Text(
                        '${biodataPencaker == null ? '' : biodataPencaker['headline']}',
                        textAlign: TextAlign.justify,
                      ),
                      BccSubheaderLabel(
                        label: 'Riwayat Pendidikan',
                        showButton: true,
                        onPressed: () {
                          Future<dynamic> tambahPendidikan =
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const TambahPendidikan(),
                          ));

                          tambahPendidikan.then((value) {
                            if (value != null) {
                              _reloadData();
                            }
                          });
                        },
                      ),
                      ListView.builder(
                        itemCount: _dataPendidikanPencaker.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          dynamic dataPendidikan =
                              _dataPendidikanPencaker[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: const BorderSide(width: 0.3)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${dataPendidikan['master_degree_name']}'),
                                  Text(
                                    '${dataPendidikan['master_major_name']}',
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Text(
                                    '${dataPendidikan['master_school_name']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      BccNormalButton(
                                        onPressed: () {
                                          _hapus(
                                              Constants.pathPendidiksnPencaker,
                                              dataPendidikan['id'],
                                              '${dataPendidikan['master_degree_name']} ${dataPendidikan['master_school_name']}');
                                        },
                                        size: const Size(50, 40),
                                        backgroundColor: Colors.red,
                                        child: const Icon(
                                          Icons.delete,
                                          size: 16,
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 5)),
                                      BccNormalButton(
                                        onPressed: () {
                                          Future<dynamic> tambahPendidikan =
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                            builder: (context) =>
                                                TambahPendidikan(
                                              riwayatPendidikanEdit:
                                                  dataPendidikan,
                                            ),
                                          ));

                                          tambahPendidikan.then((value) {
                                            if (value != null) {
                                              _reloadData();
                                            }
                                          });
                                        },
                                        size: const Size(50, 40),
                                        child: const Icon(
                                          Icons.edit,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      BccSubheaderLabel(
                        label: 'Pengalaman Bekerja',
                        showButton: true,
                        onPressed: () {
                          Future<dynamic> tambahPengalaman =
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const PengalamanBekerja(),
                          ));

                          tambahPengalaman.then((value) {
                            if (value != null) {
                              _reloadData();
                            }
                          });
                        },
                      ),
                      ListView.builder(
                        itemCount: _dataPengalamanBekerja.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          dynamic dataPengalaman =
                              _dataPengalamanBekerja[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: const BorderSide(width: 0.3)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${dataPengalaman['title']}'),
                                  Text(
                                    '${dataPengalaman['company_name']}|${dataPengalaman['master_employment_type_name']}',
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Text(
                                    '${dataPengalaman['start_month']} ${dataPengalaman['start_year']} - ${dataPengalaman['end_month']} ${dataPengalaman['start_year']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      BccNormalButton(
                                        onPressed: () {
                                          _hapus(
                                              Constants.pathPengalamanBekerja,
                                              dataPengalaman['id'],
                                              '${dataPengalaman['title']}');
                                        },
                                        size: const Size(50, 40),
                                        backgroundColor: Colors.red,
                                        child: const Icon(
                                          Icons.delete,
                                          size: 16,
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 5)),
                                      BccNormalButton(
                                        onPressed: () {},
                                        size: const Size(50, 40),
                                        child: const Icon(
                                          Icons.edit,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      BccSubheaderLabel(
                        label: 'Lisensi & Sertifikat',
                        showButton: true,
                        onPressed: () {
                          Future<dynamic> tambahSert =
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const TambahSertifikat(),
                          ));

                          tambahSert.then((value) {
                            if (value != null) {
                              _reloadData();
                            }
                          });
                        },
                      ),
                      ListView.builder(
                        itemCount: _dataSertifikat.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          dynamic lisensi = _dataSertifikat[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: const BorderSide(width: 0.3)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${lisensi['name']}'),
                                  Text(
                                    '${lisensi['issuing_organization']}',
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      BccNormalButton(
                                        onPressed: () {
                                          _hapus(
                                              Constants.pathSertifikatPencker,
                                              lisensi['id'],
                                              '${lisensi['name']}');
                                        },
                                        size: const Size(50, 40),
                                        backgroundColor: Colors.red,
                                        child: const Icon(
                                          Icons.delete,
                                          size: 16,
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 5)),
                                      BccNormalButton(
                                        onPressed: () {},
                                        size: const Size(50, 40),
                                        child: const Icon(
                                          Icons.edit,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      BccSubheaderLabel(
                        label: 'Keterampilan',
                        showButton: true,
                        onPressed: () {
                          Future<dynamic> tambahKetrampilan =
                              Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const TambahKeterampilan(),
                          ));

                          tambahKetrampilan.then((value) {
                            _reloadData();
                          });
                        },
                      ),
                      ListView.builder(
                        itemCount: _dataSkill.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          dynamic skill = _dataSkill[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: const BorderSide(width: 0.3)),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${skill['master_skill_name']} (${skill['percentage']} %)'),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      BccNormalButton(
                                        onPressed: () {
                                          _hapus(
                                              Constants.pathDataJobseekerSkill,
                                              skill['id'],
                                              '${skill['master_skill_name']}');
                                        },
                                        size: const Size(50, 40),
                                        backgroundColor: Colors.red,
                                        child: const Icon(
                                          Icons.delete,
                                          size: 16,
                                        ),
                                      ),
                                      const Padding(
                                          padding: EdgeInsets.only(right: 5)),
                                      BccNormalButton(
                                        onPressed: () {},
                                        size: const Size(50, 40),
                                        child: const Icon(
                                          Icons.edit,
                                          size: 16,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const BccLineSparator(
                        margin: EdgeInsets.only(bottom: 10, top: 20),
                      ),
                      // const BccSubheaderLabel(
                      //   label: 'Tentang BCC',
                      //   showButton: false,
                      // ),
                      // const BccLineSparator(
                      //   margin: EdgeInsets.only(bottom: 20, top: 10),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BccNormalButton(
                            size: const Size(120, 40),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [Icon(Icons.lock), Text('Keluar')],
                            ),
                            onPressed: () {
                              showAlertDialogWithAction2(
                                  'Apakah kamu yakin ingin keluar?', context,
                                  () {
                                Navigator.of(context).pop();
                              }, () {
                                Navigator.of(context).pop();
                                _logout();
                              }, 'Batal', 'OK');
                            },
                          ),
                        ],
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 50))
                    ],
                  ),
                )
        ]),
      ),
    );
  }

  _logout() {
    GetStorage().remove(Constants.loginInfo);
    GetStorage().remove(Constants.userType);
    Provider.of<UserLoginModel>(context, listen: false).hapusStatePencaker();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LandingTab()),
      (Route<dynamic> route) => true,
    );
  }

  _hapus(String path, String id, String messageTambahan) {
    String token = loginInfo['data']['token'];
    showAlertDialogWithAction2(
        'Apakah yakin ingin menghapus data ini: "$messageTambahan" ?', context,
        () {
      Navigator.of(context).pop();
    }, () {
      Navigator.of(context).pop();
      _apiCall.hapusData(path, id, token).then((value) {
        _reloadData();
      });
    }, 'Batal', 'OK');
  }

  _reloadData() {
    setState(() {
      _dataPendidikanPencaker.clear();
      _dataPengalamanBekerja.clear();
      _dataSertifikat.clear();
      _dataSkill.clear();
      isLoading = true;
    });
    _fetchBiodataRinciPencaker();
  }
}
