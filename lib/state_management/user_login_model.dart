import 'package:bcc/api/api_call.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class UserLoginModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  dynamic profilePencaker;

  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  final ApiCall _apiCall = ApiCall();
  // final ApiHelper _apiHelper = ApiHelper();

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
    _getProfilPencaker();
  }

  _getProfilPencaker() {
    dynamic loginInfo = GetStorage().read(Constants.loginInfo);
    // String idPencaker = loginInfo['data']['id'];
    String uniqueIdPencaker = loginInfo['data']['unique_id'];
    String token = loginInfo['data']['token'];
    _apiCall
        .getDataPencakerByUniqueId(
            pencakerUniqueId: uniqueIdPencaker, token: token)
        .then(
      (response) {
        profilePencaker = response['data'];
        notifyListeners();
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
        notifyListeners();
      },
    );
  }
}
