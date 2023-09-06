import 'dart:developer';

import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/hubungi_kami/hubungi_kami_screen.dart';
import 'package:bcc/screen/landing/lowongan/lowongan_list_screen.dart';
import 'package:bcc/screen/landing/perusahaan/perusahaan_list_screen.dart';
import 'package:bcc/screen/pencaker/beranda_pencaker.dart';
import 'package:bcc/screen/pencaker/profil_screen.dart';
import 'package:flutter/material.dart';

class DashboardTabPencaker extends StatefulWidget {
  const DashboardTabPencaker({super.key});

  @override
  State<DashboardTabPencaker> createState() => _DashboardTabPencakerState();
}

class _DashboardTabPencakerState extends State<DashboardTabPencaker> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const BerandaPencaker(),
    const LowonganListScreen(),
    const PerusahaanListScreen(),
    const HubungiKamiScreen(),
    const ProfilPencakerScreen(),
  ];

  _onItemTapped(int index) {
    setState(() {
      log('index $index');
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          // backgroundColor: Colors.transparent,
          // elevation: 0,
          useLegacyColorScheme: false,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Constants.colorBiruGelap,
          unselectedItemColor: const Color.fromARGB(255, 144, 144, 144),
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Beranda',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'Lowongan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_work),
              label: 'Perusahaan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Pesan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
