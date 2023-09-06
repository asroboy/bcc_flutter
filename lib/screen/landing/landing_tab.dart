import 'package:bcc/contants.dart';
import 'package:bcc/screen/landing/hubungi_kami/hubungi_kami_screen.dart';
import 'package:bcc/screen/landing/landing_screen.dart';
import 'package:bcc/screen/landing/lowongan/lowongan_list_screen.dart';
import 'package:bcc/screen/landing/perusahaan/perusahaan_list_screen.dart';
import 'package:bcc/screen/login_screen.dart';
import 'package:flutter/material.dart';

class LandingTab extends StatefulWidget {
  const LandingTab({super.key});

  @override
  State<LandingTab> createState() => _LandingTabState();
}

class _LandingTabState extends State<LandingTab> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const LandingScreen(),
    const LowonganListScreen(),
    const PerusahaanListScreen(),
    const HubungiKamiScreen(),
    const LoginScreen(),
  ];

  _onItemTapped(int index) {
    setState(() {
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
          useLegacyColorScheme: false,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Constants.colorBiruGelap,
          unselectedItemColor: Constants.colorGrey,
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
              icon: Icon(Icons.phone),
              label: 'Hubungi Kami',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.lock),
              label: 'Login',
            ),
          ],
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
