import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_call.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BccProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final ApiCall _apiCall = ApiCall();
  final ApiHelper _apiHelper = ApiHelper();

  bool _isLoadingDataPerusahaan = false;
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  final List<dynamic> _dataPerusahaanTerbaru = [];

  List<dynamic> get dataPerusahaanTerbaru => _dataPerusahaanTerbaru;

  bool get isLoadingDataPerusahan => _isLoadingDataPerusahaan;

  void initLandingDataPerusahaanTerbaru() {
    _isLoadingDataPerusahaan = true;
    notifyListeners();

    _fetchPerusahaanTerbaru();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('count', count));
  }

  _fetchPerusahaanTerbaru() {
    Future<dynamic> reqLowonganPopuler = _apiCall.getDataPendukung(
        Constants.pathLandingCompany +
            ('?limit=10&page=1&orderBy=id&sort=desc'));
    reqLowonganPopuler.then((value) {
      log('result $value');
      _isLoadingDataPerusahaan = false;
      _dataPerusahaanTerbaru.addAll(value['data']);

      notifyListeners();
    });
  }
}
