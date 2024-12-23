import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/contants.dart';

class ApiPerusahaanCall {
  static int statusPending = 0;
  // static int STATUS_PENDING = 1;
  ApiPerusahaanCall();

  Future<dynamic> simpanProfilPerusahaan(
      String idPerusahaan, String token, dynamic data) {
    String apiPath =
        '${Constants.host}${Constants.pathProfilPerusahaan}$idPerusahaan';
    log('path $apiPath');
    return ApiHelper(body: data, apiUrl: apiPath)
        .requestAuthenticatedDataPut(token);
  }

  Future<dynamic> updatePasswordPerusahaan(
      {required String idPerusahaan,
      required String token,
      required dynamic data}) {
    String apiPath =
        '${Constants.host}${Constants.pathUbahPasswordPerusahaan}$idPerusahaan';
    log('path $apiPath');
    return ApiHelper(body: data, apiUrl: apiPath)
        .requestAuthenticatedDataPost(token);
  }

  Future<dynamic> updateJobInterview(
      String jobInterviewId, dynamic data, String token) {
    String apiPath =
        '${Constants.host}${Constants.pathJobInterview}/$jobInterviewId/$token';
    log('path $apiPath');
    return ApiHelper(body: data, apiUrl: apiPath)
        .requestAuthenticatedDataPut(token);
  }

  Future<dynamic> simpanJobInterview(dynamic data, String token) {
    String apiPath = '${Constants.host}${Constants.pathSimpanInterview}';
    log('path $apiPath');
    return ApiHelper(body: data, apiUrl: apiPath)
        .requestAuthenticatedDataPost(token);
  }

  Future<dynamic> getJobInterview(
      String idLamaran, String pelamarId, String token) {
    String apiPath =
        '${Constants.host}${Constants.pathJobInterview}?company_job_application_id=$idLamaran&jobseeker_id=$pelamarId';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

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

  Future<dynamic> simpanAlamatPerusahaan(
      {dynamic data, required String token}) {
    String apiPath = '${Constants.host}${Constants.pathAlamatPerusahaan}';
    log('path $apiPath');
    return ApiHelper(body: data, apiUrl: apiPath)
        .requestAuthenticatedDataPost(token);
  }

  Future<dynamic> updateAlamatPerusahaan(
      {dynamic data, required String idAlamat, required String token}) {
    String apiPath =
        '${Constants.host}${Constants.pathAlamatPerusahaan}/$idAlamat';
    log('path $apiPath');
    return ApiHelper(body: data, apiUrl: apiPath)
        .requestAuthenticatedDataPut(token);
  }

  Future<dynamic> hapusAlamatPerusahaan(
      {required String idAlamat, required String token}) {
    String apiPath =
        '${Constants.host}${Constants.pathAlamatPerusahaan}/$idAlamat';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath)
        .requestAuthenticatedDataDelete(token);
  }

  Future<dynamic> setAlamatUtamaPerusahaan(
      {required String idAlamat,
      required String token,
      required dynamic data}) {
    String apiPath =
        '${Constants.host}${Constants.pathAlamatPrimary}/$idAlamat';
    log('path $apiPath');
    return ApiHelper(body: data, apiUrl: apiPath)
        .requestAuthenticatedDataPut(token);
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

  Future<dynamic> simpanLegalitasHukum({dynamic data, required String token}) {
    String apiPath = '${Constants.host}${Constants.pathCompanyLegality}';
    log('path $apiPath');
    return ApiHelper(body: data, apiUrl: apiPath)
        .requestAuthenticatedDataPost(token);
  }

  Future<dynamic> updateLegalitasHukum(
      {dynamic data, required String token, required String idLegalitas}) {
    String apiPath =
        '${Constants.host}${Constants.pathCompanyLegality}/$idLegalitas';
    log('path $apiPath');
    return ApiHelper(body: data, apiUrl: apiPath)
        .requestAuthenticatedDataPut(token);
  }

  Future<dynamic> hapusLegalitasHukum(
      {required String token, required String idLegalitas}) {
    String apiPath =
        '${Constants.host}${Constants.pathCompanyLegality}/$idLegalitas';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath)
        .requestAuthenticatedDataDelete(token);
  }

  Future<dynamic> getLowongan(String companyId, String token) {
    String apiPath =
        '${Constants.host}${Constants.pathLowongan}?company_id=$companyId';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> tambahkanUserExperienceTerimaKerja(
      {required dynamic data, required String token}) {
    String apiPath = '${Constants.host}${Constants.pathPengalamanBekerja}';
    log('path $apiPath');
    return ApiHelper(body: data, apiUrl: apiPath)
        .requestAuthenticatedDataPost(token);
  }

  Future<dynamic> getPersonalia(String companyid, String status) {
    String apiPath =
        '${Constants.host}${Constants.pathPersonalia}?company_id=$companyid';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> getPelamarByLowongan(
      String lowonganId, String token, String status) {
    String apiPath =
        '${Constants.host}${Constants.pathAjukanLamaran}?company_job_id=$lowonganId&status=$status';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> updateLamaran(
      dynamic dataLamaran, String token, String status) {
    String apiPath =
        '${Constants.host}${Constants.pathAjukanLamaran}/${dataLamaran['id']}';
    log('path $apiPath');
    return ApiHelper(body: dataLamaran, apiUrl: apiPath)
        .requestAuthenticatedDataPut(token);
  }

  Future<dynamic> getPelamarByPerusahaan(
      String companyId, String token, String status) {
    String apiPath =
        '${Constants.host}${Constants.pathAjukanLamaran}?company_id=$companyId';
    log('path $apiPath');
    return ApiHelper(body: {}, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> getPelamarByPerusahaanAndName(
      String companyId, String token, String name) {
    String apiPath =
        '${Constants.host}${Constants.pathAjukanLamaran}?company_id=$companyId&jobseeker_name=$name';
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
