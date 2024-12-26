import 'dart:async';
import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_button.dart';
import 'package:bcc/bccwidgets/bcc_dropdown_search.dart';
import 'package:bcc/bccwidgets/bcc_normal_button.dart';
import 'package:bcc/bccwidgets/bcc_row_label.dart';
import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/pencaker/profil/bcc_subheader_label.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class TambahKeterampilan extends StatefulWidget {
  const TambahKeterampilan({super.key, this.ketetarampilanEdit});

  final dynamic ketetarampilanEdit;

  @override
  State<TambahKeterampilan> createState() => _TambahKeterampilanState();
}

class _TambahKeterampilanState extends State<TambahKeterampilan> {
  final ApiCall _apiCall = ApiCall();
  late ApiHelper _apiHelper;

  final List<dynamic> masterSkillObj = [];
  dynamic selectedMasterSkillObj;
  String? selectedMasterSkillString;

  final TextEditingController _prosentaseController = TextEditingController();

  _fetchMasterSkillByName(String filter) {
    var completer = Completer<List<dynamic>>();
    Future<dynamic> req = _apiCall
        .getDataPendukung(Constants.pathDataMasterSkill + ('?name=') + filter);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            completer.complete(response['data']);
          });
    });
    return completer.future;
  }

  List<dynamic> dataSkill = [];

  _fetchMasterSkill(String filter) {
    Future<dynamic> req = _apiCall
        .getDataPendukung(Constants.pathDataMasterSkill + ('?name=') + filter);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            setState(() {
              dataSkill = response['data'];
            });
          });
    });
  }

  _fetchMasterSkillInit(String filter) {
    Future<dynamic> req = _apiCall
        .getDataPendukung(Constants.pathDataMasterSkill + ('?name=') + filter);
    req.then((value) {
      _apiHelper.apiCallResponseHandler(
          response: value,
          onSuccess: (response) {
            setState(() {
              dataSkill = response['data'];
              if (widget.ketetarampilanEdit != null) {
                selectedMasterSkillObj = dataSkill.firstWhere((element) =>
                    element['id'] ==
                    widget.ketetarampilanEdit['master_skill_id']);
                ;
              }
            });
          });
    });
  }

  @override
  void initState() {
    _apiHelper = ApiHelper(buildContext: context);

    if (widget.ketetarampilanEdit != null) {
      selectedMasterSkillString =
          widget.ketetarampilanEdit['master_skill_name'];
      _fetchMasterSkillInit(selectedMasterSkillString!);
      _prosentaseController.text =
          widget.ketetarampilanEdit['percentage'].toString();
    } else {
      _fetchMasterSkill('');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Keterampilan')),
      body: ListView(children: [
        Center(
          child: Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Constants.boxColorBlueTrans),
            child: Column(
              children: [
                const BccSubheaderLabel(
                  label: 'Tambah Keterampilan',
                ),
                const BccRowLabel(label: 'Keterampilan'),
                BccDropdownSearch(
                    items: dataSkill,
                    getData: _fetchMasterSkill,
                    hint: "Cari keterampilan yang sesuai",
                    itemAsString: (dynamic u) => u['name'],
                    selectedItem: selectedMasterSkillObj,
                    onChange: (dynamic data) {
                      setState(() {
                        selectedMasterSkillString = data['name'];
                        selectedMasterSkillObj = data;
                      });
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    BccNormalButton(
                      backgroundColor: Constants.colorBiruGelap,
                      onPressed: () {
                        setState(() {
                          selectedMasterSkillObj = null;
                          selectedMasterSkillString = null;
                        });
                      },
                      size: const Size(120, 40),
                      child: const Row(children: [
                        Icon(Icons.refresh),
                        Padding(padding: EdgeInsets.only(right: 5)),
                        Text('Reset')
                      ]),
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                BccTextFormFieldInput(
                  hint: 'Prosentasi(%)',
                  padding: EdgeInsets.zero,
                  controller: _prosentaseController,
                  textInputType: TextInputType.number,
                ),
                BccButton(
                  onPressed: () {
                    if (selectedMasterSkillObj == null) {
                      showAlertDialog(
                          'Harap isi ketrampilan anda yang sesuai', context);
                      return;
                    }
                    if (_prosentaseController.text == '') {
                      showAlertDialog(
                          'Harap isi prosentase ketrampilan Kamu', context);
                      return;
                    }

                    dynamic loginData = GetStorage().read(Constants.loginInfo);

                    String token = loginData['data']['token'];
                    log('token $token');
                    String jobseekerId = loginData['data']['id'];

                    dynamic dataKetrampilanPekerja = {
                      'master_skill_id': selectedMasterSkillObj['id'],
                      'percentage': _prosentaseController.text,
                      'jobseeker_id': jobseekerId,
                    };

                    showDialog(
                        // The user CANNOT close this dialog  by pressing outsite it
                        barrierDismissible: false,
                        context: context,
                        builder: (_) {
                          return const Dialog(
                            // The background color
                            backgroundColor: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  // The loading indicator
                                  CircularProgressIndicator(),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  // Some text
                                  Text('Loading...')
                                ],
                              ),
                            ),
                          );
                        });
                    if (widget.ketetarampilanEdit != null) {
                      String id = widget.ketetarampilanEdit['id'];
                      dataKetrampilanPekerja['id'] = id;
                      _apiCall
                          .updateSkillPencaker(
                              dataKetrampilanPekerja, token, id)
                          .then((value) {
                        if (!mounted) return;
                        _apiHelper.apiCallResponseHandler(
                            response: value,
                            onSuccess: (response) {
                              Navigator.of(context).pop();
                              showAlertDialogWithAction(
                                  'Data berhasil disimpan', context, () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop(response);
                              }, 'OK');
                            });
                      });
                    } else {
                      _apiCall
                          .simpanSkillPencaker(dataKetrampilanPekerja, token)
                          .then((value) {
                        if (!mounted) return;
                        _apiHelper.apiCallResponseHandler(
                            response: value,
                            onSuccess: (response) {
                              Navigator.of(context).pop();
                              showAlertDialogWithAction(
                                  'Data berhasil disimpan', context, () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pop(response);
                              }, 'OK');
                            });
                      });
                    }
                  },
                  padding: const EdgeInsets.only(top: 20),
                  child: const Text('Simpan'),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
