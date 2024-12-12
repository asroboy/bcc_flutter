import 'dart:convert';
import 'dart:developer';

import 'package:bcc/api/helper.dart';
import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/landing_tab.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class ApiHelper {
  String? apiUrl;
  String apiUrlGlobalLogin = 'https://bogorcareercenter.bogorkab.go.id/';

  final dynamic body;

  ApiHelper({
    this.body,
    this.apiUrl,
  });

  setApiUrl(String mApiUrl) {
    apiUrl = mApiUrl;
  }

  dynamic loginData() {
    dynamic loginData = GetStorage().read(Constants.loginInfo);
    return loginData;
  }

  String token() {
    dynamic loginData = GetStorage().read(Constants.loginInfo);
    dynamic loginInfo = (loginData['loginInfo']);
    return loginInfo['token'];
  }

  String link() {
    dynamic loginData = GetStorage().read(Constants.loginInfo);
    return loginData['link'];
  }

  String userType() {
    String userType = GetStorage().read(Constants.userType);
    return userType;
  }

  requestDataGet() async {
    log('body $body');

    if (apiUrl!.contains('http://')) {
      apiUrl = apiUrl!.replaceAll('http://', 'https://');
    }
    log('url $apiUrl');
    // try {
    //   final result = await InternetAddress.lookup(apiUrl);
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    log('connected');
    // final encoding = Encoding.getByName('utf-8');
    // try {
    Response response = await get(
      Uri.parse(apiUrl ?? apiUrlGlobalLogin),
      // body: json.encode(body),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
    ).timeout(
      const Duration(minutes: 2),
      onTimeout: () {
        const info = {'code': 408, 'message': 'Request timeout'};
        Response response = Response(json.encode(info), 408);
        return response; // Request Timeout response status code
      },
    );
    dynamic data = {
      'message': 'Tidak ada informasi yang bisa ditampilkan',
      'status': 'Failed',
      'code': 500
    };

    if (response.body != '') {
      try {
        data = json.decode(response.body);
      } catch (ex) {
        data = {
          'message': 'Terjadi kendala. \nError: $ex',
          'status': 'Failed',
          'code': 500
        };
      }
    }
    return data;
  }

  requestDataPost({String? token}) async {
    log('body $body');

    if (apiUrl!.contains('http://')) {
      apiUrl = apiUrl!.replaceAll('http://', 'https://');
    }
    log('url $apiUrl');
    // try {
    //   final result = await InternetAddress.lookup(apiUrl);
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    log('connected');
    // final encoding = Encoding.getByName('utf-8');
    // try {

    dynamic header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
    };
    if (token != null) {
      header['Authorization'] = 'Bearer $token';
    }
    Response response = await post(
      Uri.parse(apiUrl ?? apiUrlGlobalLogin),
      body: json.encode(body),
      headers: header,
    ).timeout(
      const Duration(minutes: 2),
      onTimeout: () {
        const info = {'code': 408, 'message': 'Request timeout'};
        Response response = Response(json.encode(info), 408);
        return response; // Request Timeout response status code
      },
    );
    dynamic data = {
      'message': 'Tidak ada informasi yang bisa ditampilkan',
      'status': 'Failed',
      'code': 500
    };

    if (response.body != '') {
      try {
        data = json.decode(response.body);
      } catch (ex) {
        data = {
          'message': 'Terjadi kendala. \nError: $ex',
          'status': 'Failed',
          'code': 500
        };
      }
    }
    return data;
  }

  requestAuthenticatedDataPut(String token) async {
    log('body $body');

    if (apiUrl!.contains('http://')) {
      apiUrl = apiUrl!.replaceAll('http://', 'https://');
    }
    log('url $apiUrl');
    // try {
    //   final result = await InternetAddress.lookup(apiUrl);
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    log('connected');
    // final encoding = Encoding.getByName('utf-8');
    // try {
    Response response = await put(
      Uri.parse(apiUrl ?? apiUrlGlobalLogin),
      body: json.encode(body),
      headers: {
        'Authorization': token,
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
    ).timeout(
      const Duration(minutes: 2),
      onTimeout: () {
        const info = {'code': 408, 'message': 'Request timeout'};
        Response response = Response(json.encode(info), 408);
        return response; // Request Timeout response status code
      },
    );
    dynamic data = {
      'message': 'Tidak ada informasi yang bisa ditampilkan',
      'status': 'Failed',
      'code': 500
    };

    if (response.body != '') {
      try {
        data = json.decode(response.body);
      } catch (ex) {
        data = {
          'message': 'Terjadi kendala. \nError: $ex',
          'status': 'Failed',
          'code': 500
        };
      }
    }
    return data;
  }

  requestAuthenticatedDataPost(String token) async {
    log('body $body');

    if (apiUrl!.contains('http://')) {
      apiUrl = apiUrl!.replaceAll('http://', 'https://');
    }
    log('url $apiUrl');
    // try {
    //   final result = await InternetAddress.lookup(apiUrl);
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    log('connected');
    // final encoding = Encoding.getByName('utf-8');
    // try {
    Response response = await post(
      Uri.parse(apiUrl ?? apiUrlGlobalLogin),
      body: json.encode(body),
      headers: {
        'Authorization': token,
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
    ).timeout(
      const Duration(minutes: 2),
      onTimeout: () {
        const info = {'code': 408, 'message': 'Request timeout'};
        Response response = Response(json.encode(info), 408);
        return response; // Request Timeout response status code
      },
    );
    dynamic data = {
      'message': 'Tidak ada informasi yang bisa ditampilkan',
      'status': 'Failed',
      'code': 500
    };

    if (response.body != '') {
      try {
        data = json.decode(response.body);
      } catch (ex) {
        data = {
          'message': 'Terjadi kendala. \nError: $ex',
          'status': 'Failed',
          'code': 500
        };
      }
    }
    return data;
  }

  requestAuthenticatedDataDelete(String token) async {
    log('body $body');

    if (apiUrl!.contains('http://')) {
      apiUrl = apiUrl!.replaceAll('http://', 'https://');
    }
    log('url $apiUrl');
    // try {
    //   final result = await InternetAddress.lookup(apiUrl);
    //   if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
    log('connected');
    // final encoding = Encoding.getByName('utf-8');
    // try {
    Response response = await delete(
      Uri.parse(apiUrl ?? apiUrlGlobalLogin),
      // body: json.encode(body),
      headers: {
        'Authorization': token,
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
    ).timeout(
      const Duration(minutes: 2),
      onTimeout: () {
        const info = {'code': 408, 'message': 'Request timeout'};
        Response response = Response(json.encode(info), 408);
        return response; // Request Timeout response status code
      },
    );
    dynamic data = {
      'message': 'Tidak ada informasi yang bisa ditampilkan',
      'status': 'Failed',
      'code': 500
    };

    if (response.body != '') {
      try {
        data = json.decode(response.body);
      } catch (ex) {
        data = {
          'message': 'Terjadi kendala. \nError: $ex',
          'status': 'Failed',
          'code': 500
        };
      }
    }
    return data;
  }

  MultipartRequest initMultipartReqest() {
    if (apiUrl!.contains('http://')) {
      apiUrl = apiUrl!.replaceAll('http://', 'https://');
    }

    //   LoadingIndicatorDialog().show(context);
    var request =
        MultipartRequest('POST', Uri.parse(apiUrl ?? apiUrlGlobalLogin));

    return request;
  }

  Future<StreamedResponse> sendMultipartRequest(
      MultipartRequest request) async {
    StreamedResponse response = await request.send().timeout(
      const Duration(minutes: 2),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        const info = {'code': 408, 'message': 'Request timeout'};
        Response response = Response(json.encode(info), 408);
        var data = json.decode(response.body);
        // log('data: $data');
        return data; // Request Timeout response status code
      },
    );

    return response;
  }

  apiCallResponseHandler(
      {required dynamic response,
      required BuildContext? context,
      required Function onSuccess,
      Function? onFailedCallback}) {
    // log('response $response');
    if (context == null) {
      return;
    }
    if (response['code'] == 200 && response['success'] == true) {
      onSuccess(response);
    } else {
      if (response['message'] ==
          'Token Akses Sudah Kedaluarsa, Silahkan Login Kembali.') {
        showAlertDialogWithAction(response['message'], context, () {
          _logout(context);
        }, 'Ok');
      } else {
        if (onFailedCallback != null) {
          showAlertDialogWithAction(
              response['message'] ??
                  'Terjadi kendala silahkan coba lagi setelah beberapa saat',
              context,
              onFailedCallback,
              'OK');
        } else {
          showAlertDialog(
              response['message'] ??
                  'Terjadi kendala silahkan coba lagi setelah beberapa saat',
              context);
        }
      }
    }
  }

  _logout(BuildContext context) {
    GetStorage().remove(Constants.loginInfo);
    GetStorage().remove(Constants.userType);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LandingTab()),
      (Route<dynamic> route) => true,
    );
  }
}
