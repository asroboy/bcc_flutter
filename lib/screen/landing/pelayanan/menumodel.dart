import 'package:flutter/material.dart';

class Menu {
  String name = '';
  IconData? icon;
  List<Menu> subMenu = [];

  String? link;

  Menu({required this.name, required this.subMenu, this.icon, this.link});

  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    link = json['link'];
    if (json['subMenu'] != null) {
      subMenu.clear();
      json['subMenu'].forEach((v) {
        subMenu.add(Menu.fromJson(v));
      });
    }
  }
}
