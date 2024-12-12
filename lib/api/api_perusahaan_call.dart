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

  Future<dynamic> getLowongan(String companyId, String token) {
    String apiPath =
        '${Constants.host}${Constants.pathLowongan}?company_id=$companyId';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> getJenisPekerjaan(String token) {
    String apiPath = '${Constants.host}${Constants.pathMasterEmplymentType}';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> getLevelPekerjaan(String token) {
    String apiPath = '${Constants.host}${Constants.pathMasterLevelPerkerjaan}';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> getMasterProvinsi(String token) {
    String apiPath = '${Constants.host}${Constants.pathProvinsi}';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> getMasterKabkoByProvinsi(String provinsiId, String token) {
    String apiPath =
        '${Constants.host}${Constants.pathKota}?master_province_id=$provinsiId';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> simpanLowonganPekerjaan(
      {required dynamic requestBody,
      required String token,
      required String idPerusahaan}) {
    String apiPath = '${Constants.host}${Constants.pathLowongan}/$token';
    log('path $apiPath');
    return ApiHelper(body: requestBody, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> updateLowonganPekerjaan(
      {required dynamic requestBody,
      required String lowonganId,
      required String idPerusahaan,
      required String token}) {
    String apiPath = '${Constants.host}${Constants.pathLowongan}/$lowonganId';
    log('path $apiPath');
    return ApiHelper(body: requestBody, apiUrl: apiPath).requestDataPost();
  }
}
