import 'dart:convert';
import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/contants.dart';

class ApiCall {
  ApiCall();

  Future<dynamic> login(
    String username,
    String password,
    String path,
  ) {
    var body = {
      "email_username": username,
      "password": password,
    };
    log('$body');
    String apiPath = Constants.host + path;
    return ApiHelper(body: body, apiUrl: apiPath).requestDataPost();
  }

  Future<dynamic> logout(String token, String path) {
    var body = {
      // 'action': ApiHelper.reqLogout,
      // 'token': token,
    };

    String apiPath = Constants.host + path;
    return ApiHelper(body: body, apiUrl: apiPath).requestDataPost();
  }

  Future<dynamic> getLowonganPopuler(String path) {
    String apiPath = Constants.host + path;
    var body = {
      "page": 1,
      "limit": 10,
      "orderBy": "id",
      "sort": "desc",
    };
    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath).requestDataPost();
  }

  Future<dynamic> getData(String path) {
    String apiPath = Constants.host + path;
    var body = {
      "page": 1,
      "limit": 10,
      "orderBy": "id",
      "sort": "desc",
    };
    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath).requestDataPost();
  }

  Future<dynamic> getAuthenticatedData(
      String path, dynamic body, String token) {
    String apiPath = Constants.host + path;

    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath)
        .requestAuthenticatedDataPost(token);
  }

  Future<dynamic> daftar(dynamic body) {
    String apiPath = Constants.host + Constants.pathDaftarPencaker;
    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath).requestDataPost();
  }

  Future<dynamic> simpanPendidikan(dynamic body, String token) {
    String apiPath = Constants.host + Constants.pathPendidiksnPencaker;
    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath)
        .requestAuthenticatedDataPost(token);
  }

  Future<dynamic> simpanPengalamanBekerja(dynamic body, String token) {
    String apiPath = Constants.host + Constants.pathPengalamanBekerja;
    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath)
        .requestAuthenticatedDataPost(token);
  }

  Future<dynamic> getDataPendukung(String path) {
    String apiPath = Constants.host + path;
    var body = {};
    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath).requestDataGet();
  }
}
