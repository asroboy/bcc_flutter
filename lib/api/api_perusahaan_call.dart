import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/contants.dart';

class ApiPerusahaanCall {
  ApiPerusahaanCall();

  Future<dynamic> getProfilPerusahaan(String idPerusahaan, String token) {
    String apiPath =
        '${Constants.host}${Constants.pathProfilPerusahaan}$idPerusahaan/$token';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> getAlamatPerusahaan(String idPerusahaan, String token) {
    String apiPath =
        '${Constants.host}${Constants.pathAlamatPerusahaan}?company_id=$idPerusahaan';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> getUkuranPerusahaan(String token) {
    String apiPath = '${Constants.host}${Constants.pathMasterCompanySize}';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> getLegalitasHukum(String companyId, String token) {
    String apiPath =
        '${Constants.host}${Constants.pathCompanyLegality}?company_id=$companyId';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }
}
