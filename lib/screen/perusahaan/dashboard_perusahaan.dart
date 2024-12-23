import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/bccwidgets/bcc_loading_indicator.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/perusahaan/dashboard_perusahaan_grid.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/profile_perusahaan_model.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

class DashboardPerusahaan extends StatefulWidget {
  const DashboardPerusahaan({super.key});

  @override
  State<DashboardPerusahaan> createState() => _DashboardPerusahaanState();
}

class _DashboardPerusahaanState extends State<DashboardPerusahaan> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool _isLoading = false;

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
                  Provider.of<ProfilePerusahaanModel>(context, listen: false)
                      .set(_profilPerusahaan);
                  // log('profil perusahaan result $_profilPerusahaan');
                  // _dataPengalamanBekerja.addAll(biodataPencaker['experience']);
                  // _dataPendidikanPencaker.addAll(biodataPencaker['education']);
                  // _dataSertifikat.addAll(biodataPencaker['certificate']);
                  // _dataSkill.addAll(biodataPencaker['skill']);
                  _isLoading = false;
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
    double headerHeight = MediaQuery.of(context).size.height * 0.30;
    double bodyHeight = MediaQuery.of(context).size.height - headerHeight;

    return Consumer(
        builder: (context, ProfilePerusahaanModel model, _) => Scaffold(
                body: Scaffold(
                    body: Stack(children: [
              _isLoading
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                      child: const BccLoadingIndicator(),
                    )
                  : Container(
                      height: headerHeight,
                      padding: EdgeInsets.only(top: headerHeight / 2),
                      color: Theme.of(context).colorScheme.primary,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 25),
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color.fromARGB(
                                        255, 209, 208, 208)),
                                child: (model.profil == null ||
                                        model.profil['logo'] == null ||
                                        model.profil['logo'] == '')
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: const Icon(
                                          Icons.assured_workload,
                                          size: 45,
                                        ))
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          model.profil['logo'] ?? "",
                                          fit: BoxFit.fill,
                                        )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Selamat Datang',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      model.profil == null
                                          ? "..."
                                          : model.profil['name'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
              Container(
                margin: EdgeInsets.only(
                    top: (headerHeight - 20), bottom: 10, left: 10, right: 10),
                height: bodyHeight,
                child: ListView(
                  children: const [DashboardPerusahaanGrid()],
                ),
              )
            ]))));
  }
}
