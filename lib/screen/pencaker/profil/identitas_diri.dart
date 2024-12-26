import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_line_break.dart';

// import 'package:bcc/bccwidgets/bcc_normal_button.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/bcc_subheader_label.dart';
import 'package:bcc/screen/pencaker/profil/pengalaman_bekerja.dart';
import 'package:bcc/screen/pencaker/profil/tambah_keterampilan.dart';
import 'package:bcc/screen/pencaker/profil/tambah_pendidikan.dart';
import 'package:bcc/screen/pencaker/profil/tambah_sertifikat.dart';
import 'package:bcc/screen/pencaker/profil/ubah_biodata.dart';
import 'package:bcc/screen/perusahaan/kadidat_pelamar_kerja/row_data_info.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class IdentitasDiri extends StatefulWidget {
  const IdentitasDiri({super.key, this.isPerusahaan, this.pencakerId});

  final bool? isPerusahaan;
  final String? pencakerId;

  @override
  State<IdentitasDiri> createState() => _IdentitasDiriState();
}

class _IdentitasDiriState extends State<IdentitasDiri> {
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool isLoading = false;

  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  dynamic userInfo;
  bool isErrorImageProfile = false;

  dynamic biodataPencaker;

  _fetchBiodataRinciPencaker() {
    String idPencaker = '';
    String token = loginInfo['data']['token'];
    if (widget.isPerusahaan != null) {
      if (widget.isPerusahaan == true) {
        idPencaker = widget.pencakerId.toString();
      }
    } else {
      idPencaker = loginInfo['data']['unique_id'];
    }

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
    // _fetchRiwayatPendidikan();
    // _fetchPengalamanBekerja();
    _fetchBiodataRinciPencaker();
  }

  getProfileImage() {
    return ((userInfo['photo'] == null ||
            userInfo['photo'] == '' ||
            isErrorImageProfile)
        ? const AssetImage('assets/images/male.png')
        : NetworkImage(userInfo['photo']));
    //NetworkImage(userInfo['photo'])
  }

  // ignore: unused_element
  _fetchRiwayatPendidikan() {
    log('data $loginInfo');
    String jobseekerId = loginInfo['data']['id'];
    String path = Constants.pathPendidiksnPencaker +
        ('?jobseeker_id=$jobseekerId&limit=10');
    _apiCall.getDataPendukung(path).then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          context: context,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                List<dynamic> dataResponse = response['data'];
                _dataPendidikanPencaker.addAll(dataResponse);
              });
            }
          });
    });
  }

  // ignore: unused_element
  _fetchPengalamanBekerja() {
    log('data $loginInfo');
    String jobseekerId = loginInfo['data']['id'];
    String path = Constants.pathPengalamanBekerja +
        ('?jobseeker_id=$jobseekerId&limit=10');
    _apiCall.getDataPendukung(path).then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          context: context,
          onSuccess: (response) {
            if (mounted) {
              setState(() {
                List<dynamic> dataResponse = response['data'];
                _dataPengalamanBekerja.addAll(dataResponse);
              });
            }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isPerusahaan == true
            ? 'Identitas Pelamar'
            : 'Identitas Diri'),
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
            widget.isPerusahaan == true
                ? const Center()
                : Positioned(
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
                                builder: (context) => UbahBiodata(
                                    biodataPencaker: biodataPencaker),
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
                widget.isPerusahaan == true
                    ? (biodataPencaker == null
                        ? '...'
                        : biodataPencaker['name'])
                    : '${userInfo['name']}',
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
                    BccSubheaderLabel(
                        label: widget.isPerusahaan == true
                            ? 'BIODATA PELAMAR'
                            : 'BIODATA DIRI'),
                    Row(
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 18,
                        ),
                        const Padding(padding: EdgeInsets.only(right: 10)),
                        Text(widget.isPerusahaan == true
                            ? (biodataPencaker == null
                                ? ''
                                : 'Terdaftar sejak ${biodataPencaker['created_at']}')
                            : 'Terdaftar sejak ${loginInfo['data']['created_at']}')
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
                          child: Text(widget.isPerusahaan == true
                              ? (biodataPencaker == null
                                  ? ''
                                  : biodataPencaker['address'])
                              : '${loginInfo['data']['address']}'),
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
                        Text(widget.isPerusahaan == true
                            ? (biodataPencaker == null
                                ? ''
                                : ('${biodataPencaker['email']} ${biodataPencaker['verified_email'] == '1' ? '(Terverifikasi)' : '(Belum terverifikasi)'}'))
                            : '${loginInfo['data']['email']}  ${loginInfo['data']['verified_email'] == '1' ? '(Terverifikasi)' : '(Belum terverifikasi)'}')
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
                        Text(widget.isPerusahaan == true
                            ? biodataPencaker['gender']
                            : '${loginInfo['data']['gender']}')
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(top: 5)),
                    BccSubheaderLabel(
                      label: widget.isPerusahaan == true
                          ? 'Tentang Pencari Kerja'
                          : 'Tentang Saya',
                    ),
                    Text(
                      '${biodataPencaker == null ? '' : (biodataPencaker['headline'] ?? '')}',
                      textAlign: TextAlign.justify,
                    ),
                    BccSubheaderLabel(
                      label: 'Riwayat Pendidikan',
                      showButton: widget.isPerusahaan == true ? false : true,
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
                        dynamic dataPendidikan = _dataPendidikanPencaker[index];
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
                                  '${dataPendidikan['master_degree_name']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                const BccLineSparator(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                ),
                                RowDataInfo(
                                  label: 'Jurusan',
                                  info:
                                      '${dataPendidikan['master_major_name']}',
                                ),
                                RowDataInfo(
                                  label: 'Tahun',
                                  info:
                                      '${dataPendidikan['start_year']}-${dataPendidikan['end_year']}',
                                ),
                                RowDataInfo(
                                  label: '',
                                  info:
                                      '${dataPendidikan['master_school_name']}',
                                ),
                                widget.isPerusahaan == true
                                    ? const Center()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              padding: const EdgeInsets.all(3),
                                              onPressed: () {
                                                _hapus(
                                                    Constants
                                                        .pathPendidiksnPencaker,
                                                    dataPendidikan['id'],
                                                    '${dataPendidikan['master_degree_name']} ${dataPendidikan['master_school_name']}');
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.grey,
                                              )),
                                          const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 5)),
                                          IconButton(
                                            padding: const EdgeInsets.all(3),
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
                                            icon: const Icon(
                                              Icons.edit,
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
                      showButton: widget.isPerusahaan == true ? false : true,
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
                        dynamic dataPengalaman = _dataPengalamanBekerja[index];
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
                                  '${dataPengalaman['title']} (${dataPengalaman['master_employment_type_name']})',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                const BccLineSparator(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                ),
                                RowDataInfo(
                                  label: 'Di Perusahaan',
                                  info: '${dataPengalaman['company_name']} ',
                                ),
                                RowDataInfo(
                                  label: 'Periode',
                                  info:
                                      '${dataPengalaman['start_month']} ${dataPengalaman['start_year']} - ${dataPengalaman['is_currently_working'] == '1' ? 'Sekarang' : ''} ${dataPengalaman['is_currently_working'] == '0' ? (dataPengalaman['end_month']) : ''} ${dataPengalaman['is_currently_working'] == '0' ? (dataPengalaman['end_year']) : ''}',
                                ),
                                widget.isPerusahaan == true
                                    ? const Center()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            padding: const EdgeInsets.all(3),
                                            onPressed: () {
                                              _hapus(
                                                  Constants
                                                      .pathPengalamanBekerja,
                                                  dataPengalaman['id'],
                                                  '${dataPengalaman['title']}');
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          IconButton(
                                            padding: const EdgeInsets.all(3),
                                            onPressed: () {
                                              Future<dynamic> tambahPendidikan =
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    PengalamanBekerja(
                                                        pengalamanEdit:
                                                            dataPengalaman),
                                              ));

                                              tambahPendidikan.then((value) {
                                                if (value != null) {
                                                  _reloadData();
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.edit,
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
                      showButton: widget.isPerusahaan == true ? false : true,
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
                                Text(
                                  '${lisensi['name']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                Text('${lisensi['issuing_organization']}',
                                    style: const TextStyle(
                                      fontStyle: FontStyle.italic,
                                    )),
                                const BccLineSparator(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                ),
                                RowDataInfo(
                                  label: 'Penerbit',
                                  info: '${lisensi['issuing_organization']}',
                                ),
                                RowDataInfo(
                                  label: 'Berlaku mulai',
                                  info:
                                      '${lisensi['start_month']} ${lisensi['start_year']}',
                                ),
                                RowDataInfo(
                                  label: 'Sampai',
                                  info: lisensi['is_not_expire'] == '0'
                                      ? 'Sekarang'
                                      : '${lisensi['end_month']} ${lisensi['end_year']}',
                                ),
                                widget.isPerusahaan == true
                                    ? const Center()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            padding: const EdgeInsets.all(3),
                                            onPressed: () {
                                              _hapus(
                                                  Constants
                                                      .pathSertifikatPencker,
                                                  lisensi['id'],
                                                  '${lisensi['name']}');
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          IconButton(
                                            padding: const EdgeInsets.all(3),
                                            onPressed: () {
                                              Future<dynamic> tambahSert =
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    const TambahSertifikat(),
                                              ));

                                              tambahSert.then((value) {
                                                if (value != null) {
                                                  _reloadData();
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.edit,
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
                      showButton: widget.isPerusahaan == true ? false : true,
                      onPressed: () {
                        Future<dynamic> tambahKetrampilan =
                            Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TambahKeterampilan(),
                        ));

                        tambahKetrampilan.then((value) {
                          if (value != null) {
                            _reloadData();
                          }
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
                                widget.isPerusahaan == true
                                    ? const Center()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            padding: const EdgeInsets.all(3),
                                            onPressed: () {
                                              _hapus(
                                                  Constants
                                                      .pathDataJobseekerSkill,
                                                  skill['id'],
                                                  '${skill['master_skill_name']}');
                                            },
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          IconButton(
                                              padding: const EdgeInsets.all(3),
                                              onPressed: () {
                                                Future<dynamic>
                                                    tambahKetrampilan =
                                                    Navigator.of(context)
                                                        .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      TambahKeterampilan(
                                                    ketetarampilanEdit: skill,
                                                  ),
                                                ));

                                                tambahKetrampilan.then((value) {
                                                  if (value != null) {
                                                    _reloadData();
                                                  }
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                              )),
                                        ],
                                      )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 50)),
                  ],
                ),
              )
      ]),
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
