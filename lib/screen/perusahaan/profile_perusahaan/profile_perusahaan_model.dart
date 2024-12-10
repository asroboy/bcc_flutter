import 'package:flutter/material.dart';

class ProfilePerusahaanModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  dynamic profilePerusahaan;

  /// An unmodifiable view of the items in the cart.
  dynamic get profil => profilePerusahaan;

  void set(dynamic profile) {
    profilePerusahaan = profile;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
