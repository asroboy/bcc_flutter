import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class UserLoginModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  dynamic profilePencaker;

  bool isLoading = true;

  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  final ApiCall _apiCall = ApiCall();

  /// An unmodifiable view of the items in the cart.
  dynamic get profilPencaker => profilePencaker;

  void setProfilPencaker(dynamic profile) {
    profilePencaker = profile;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  hapusStatePencaker() {
    profilePencaker = null;
    notifyListeners();
  }

  reloadDataPencaker() {
    isLoading = true;
    notifyListeners();
    _getProfilPencaker(null);
  }

  loadDataPencaker(Function(dynamic response)? onFailed) {
    _getProfilPencaker(onFailed);
  }

  _getProfilPencaker(Function(dynamic response)? onFailed) {
    dynamic loginInfo = GetStorage().read(Constants.loginInfo);
    // String idPencaker = loginInfo['data']['id'];
    String uniqueIdPencaker = loginInfo['data']['unique_id'];
    String token = loginInfo['data']['token'];
    _apiCall
        .getDataPencakerByUniqueId(
            pencakerUniqueId: uniqueIdPencaker, token: token)
        .then(
      (response) {
        if (response['code'] == 200 && response['success'] == true) {
          profilePencaker = response['data'];
          isLoading = false;
          notifyListeners();
        } else {
          onFailed!(response);
        }
      },
    );
  }

  /// Internal, private state of the cart.
  dynamic profilePerusahaan;

  /// An unmodifiable view of the items in the cart.
  dynamic get profilPerusahaan => profilePerusahaan;

  void setProfilePerusahaan(dynamic profile) {
    profilePerusahaan = profile;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  hapusStateCompany() {
    profilePerusahaan = null;
    notifyListeners();
  }

  reloadDataCompany() {
    isLoading = true;
    notifyListeners();
    _getCompanyProfile();
  }

  loadDataCompany() {
    _getCompanyProfile();
  }

  _getCompanyProfile() {
    dynamic loginInfo = GetStorage().read(Constants.loginInfo);
    // String idPencaker = loginInfo['data']['id'];
    String uniqueIdCompany = loginInfo['data']['unique_id'];
    String token = loginInfo['data']['token'];
    _apiPerusahaanCall.getProfilPerusahaan(uniqueIdCompany, token).then(
      (response) {
        profilePerusahaan = response['data'];
        isLoading = false;
        notifyListeners();
      },
    );
  }
}
