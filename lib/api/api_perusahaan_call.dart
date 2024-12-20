import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/contants.dart';

class ApiPerusahaanCall {
  static int STATUS_PENDING = 0;
  // static int STATUS_PENDING = 1;
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

  Future<dynamic> getPelamarByLowongan(
      String lowonganId, String token, String status) {
    String apiPath =
        '${Constants.host}${Constants.pathAjukanLamaran}?company_job_id=$lowonganId';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> getPelamarByPerusahaan(
      String companyId, String token, String status) {
    String apiPath =
        '${Constants.host}${Constants.pathAjukanLamaran}?company_id=$companyId';
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
    String apiPath = '${Constants.host}${Constants.pathLowongan}';
    log('path $apiPath');
    return ApiHelper(body: requestBody, apiUrl: apiPath)
        .requestDataPost(token: token);
  }

  Future<dynamic> updateLowonganPekerjaan(
      {required dynamic requestBody,
      required String lowonganId,
      required String token}) {
    String apiPath = '${Constants.host}${Constants.pathLowongan}/$lowonganId';
    log('path $apiPath');
    return ApiHelper(body: requestBody, apiUrl: apiPath)
        .requestAuthenticatedDataPut(token);
  }

  Future<dynamic> deleteLowonganPekerjaan(
      {required String lowonganId, required String token}) {
    String apiPath = '${Constants.host}${Constants.pathLowongan}/$lowonganId';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath)
        .requestAuthenticatedDataDelete(token);
  }
}
