import 'package:bcc/contants.dart';
import 'package:bcc/screen/perusahaan/cari_kandidat.dart';
import 'package:bcc/screen/perusahaan/dashboard_perusahaan.dart';
import 'package:bcc/screen/perusahaan/management_lowongan.dart';
import 'package:bcc/screen/perusahaan/personalia.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan.dart';
import 'package:flutter/material.dart';

class DashboardTabPerusahaan extends StatefulWidget {
  const DashboardTabPerusahaan({super.key});

  @override
  State<DashboardTabPerusahaan> createState() => _DashboardTabPerusahaanState();
}

class _DashboardTabPerusahaanState extends State<DashboardTabPerusahaan> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardPerusahaan(),
    const ManagementLowongan(),
    const CariKandidat(),
    const Personalia(),
    const ProfilePerusahaan(),
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          useLegacyColorScheme: false,
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Constants.colorBiruGelap,
          unselectedItemColor: Constants.colorGrey,
          currentIndex: _selectedIndex, //New
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'Mng. Lowongan',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_pin_sharp),
              label: 'Kadidat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              label: 'Personalia',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assured_workload),
              label: 'Profil',
            ),
          ],
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
