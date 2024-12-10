// import 'dart:convert';
import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class AlamatPerusahaan extends StatefulWidget {
  const AlamatPerusahaan({super.key});

  @override
  State<AlamatPerusahaan> createState() => _AlamatPerusahaanState();
}

class _AlamatPerusahaanState extends State<AlamatPerusahaan> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  bool isLoading = false;
  final ApiHelper _apiHelper = ApiHelper();

  final List<dynamic> _alamats = [];

  _getAlamatPerusahaan() {
    String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getAlamatPerusahaan(idPerusahaan, token).then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                setState(() {
                  isLoading = false;
                  _alamats.addAll(response['data']);
                  log('alamat perusahaan result $response');
                  // _dataPengalamanBekerja.addAll(biodataPencaker['experience']);
                  // _dataPendidikanPencaker.addAll(biodataPencaker['education']);
                  // _dataSertifikat.addAll(biodataPencaker['certificate']);
                  // _dataSkill.addAll(biodataPencaker['skill']);
                });
              });
        }
      },
    );
  }

  @override
  void initState() {
    _getAlamatPerusahaan();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alamat Perusahaan'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: _alamats.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${_alamats[index]['title']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (_alamats[index]['is_primary'] == '1')
                            ? ' (Utama)'
                            : '',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: Text(
                              '${_alamats[index]['address']}, ${_alamats[index]['master_village_name']},${_alamats[index]['master_district_name']}, ${_alamats[index]['master_city_name']}, ${_alamats[index]['master_province_name']}'))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (_alamats[index]['is_primary'] != '1')
                          ? IconButton(
                              onPressed: () {}, icon: const Icon(Icons.check))
                          : const Center(),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
                    ],
                  )
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
