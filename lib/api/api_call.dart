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

  Future<dynamic> getLowonganWhishList(
      String path, int page, int max, int userId) {
    String apiPath = Constants.host + path;
    var body = {
      "page": page,
      "limit": max,
      'jobseeker_id': userId,
      "orderBy": "id",
      "sort": "desc",
    };
    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath).requestDataPost();
  }

  Future<dynamic> getRiwayatLamaran(
      String path, int page, int max, int userId) {
    String apiPath = Constants.host + path;
    var body = {
      "page": page,
      "limit": max,
      'jobseeker_id': userId,
      "orderBy": "id",
      "sort": "desc",
    };
    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath).requestDataPost();
  }

  Future<dynamic> getLowonganPaged(String path, int page, int max,
      String? title, int? companyId, int? cityId) {
    String apiPath = Constants.host + path;
    var body = {
      "page": 1,
      "limit": 10,
      "orderBy": "id",
      "sort": "desc",
    };

    if (title != null) {
      body['title'] = title;
    }

    if (companyId != null) {
      if (companyId > 0) {
        body['company_id'] = companyId;
      }
    }

    if (cityId != null) {
      if (cityId > 0) {
        body['master_city_id'] = cityId;
      }
    }

    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath).requestDataPost();
  }

  Future<dynamic> getCompanyPaged(
      String path, int page, int max, String? name) {
    String apiPath = Constants.host + path;
    var body = {
      "page": 1,
      "limit": 10,
      "orderBy": "id",
      "sort": "desc",
    };

    if (name != null) {
      body['name'] = name;
    }

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

  Future<dynamic> ajukanLamaran(dynamic body, String token) {
    String apiPath = Constants.host + Constants.pathAjukanLamaran;
    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath)
        .requestAuthenticatedDataPost(token);
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

  Future<dynamic> simpanSertifikatPencaker(dynamic body, String token) {
    String apiPath = Constants.host + Constants.pathSertifikatPencker;
    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath)
        .requestAuthenticatedDataPost(token);
  }

  Future<dynamic> simpanSkillPencaker(dynamic body, String token) {
    String apiPath = Constants.host + Constants.pathDataJobseekerSkill;
    log('path $apiPath');
    return ApiHelper(body: [body], apiUrl: apiPath)
        .requestAuthenticatedDataPost(token);
  }

  Future<dynamic> getDataPendukung(String path) {
    String apiPath = Constants.host + path;
    var body = {};
    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath).requestDataGet();
  }

  Future<dynamic> getDataRinci(String path, String id, String token) {
    return getDataPendukung(path + ('/') + (id) + ('/') + token);
  }

  Future<dynamic> hapusData(String path, String id, String token) {
    String apiPath = Constants.host + path + ('/') + id;
    var body = {};
    log('path $apiPath');
    return ApiHelper(body: body, apiUrl: apiPath)
        .requestAuthenticatedDataDelete(token);
  }
}
