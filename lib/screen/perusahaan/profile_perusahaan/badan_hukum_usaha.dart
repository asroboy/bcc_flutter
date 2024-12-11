import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/bccwidgets/bcc_loading_indicator.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/row_data.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class BadanHukumUsaha extends StatefulWidget {
  const BadanHukumUsaha({super.key});

  @override
  State<BadanHukumUsaha> createState() => _BadanHukumUsahaState();
}

class _BadanHukumUsahaState extends State<BadanHukumUsaha> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool isLoading = true;

  // final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  List<dynamic> legalitas = [];

  _getBadanHukumUsahaPerusahaan() {
    String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getLegalitasHukum(idPerusahaan, token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  isLoading = false;
                  legalitas.addAll(response['data']);
                });
              });
        }
      },
    );
  }

  @override
  void initState() {
    _getBadanHukumUsahaPerusahaan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Badan Hukum Perusahaan'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: const BccLoadingIndicator(),
            )
          : legalitas.isEmpty
              ? const BccNoDataInfo()
              : ListView.builder(
                  itemCount: legalitas.length,
                  itemBuilder: (context, index) {
                    dynamic mlegalitas = legalitas[index];
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Card(
                        child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: ListView(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                RowData(
                                    label: 'Nomor Akta',
                                    value: mlegalitas['deed_number']),
                                RowData(
                                    label: 'Notaris',
                                    value: mlegalitas['notary_name']),
                                RowData(
                                    label: 'No.SK KEMENKUMHAM',
                                    value: mlegalitas['sk_number_kemenkumham']),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                WidgetStatePropertyAll(
                                                    Colors.red)),
                                        child: const Icon(Icons.delete)),
                                    const Padding(
                                        padding: EdgeInsets.only(right: 5)),
                                    ElevatedButton(
                                        onPressed: () {},
                                        child: const Icon(Icons.edit))
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  },
                ),
    );
  }
}
