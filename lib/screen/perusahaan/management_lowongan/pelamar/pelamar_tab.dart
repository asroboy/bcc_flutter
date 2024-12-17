import 'package:bcc/contants.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/pelamar/data_pelamar_kerja.dart';
import 'package:flutter/material.dart';

class PelamarTab extends StatefulWidget {
  const PelamarTab({super.key, this.lowongan});
  final dynamic lowongan;
  @override
  State<PelamarTab> createState() => _PelamarTabState();
}

class _PelamarTabState extends State<PelamarTab> {
  int _selectedIndex = 0;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      DataPelamarKerja(
        lowongan: widget.lowongan,
      ),
      DataPelamarKerja(
        lowongan: widget.lowongan,
      ),
      DataPelamarKerja(
        lowongan: widget.lowongan,
      ),
      DataPelamarKerja(
        lowongan: widget.lowongan,
      ),
      DataPelamarKerja(
        lowongan: widget.lowongan,
      ),
    ];
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
              icon: Icon(Icons.list_alt),
              label: 'Pelamar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_2),
              label: 'Lolos Adm.',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Interview',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              label: 'Diterima',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work_off),
              label: 'Ditolak',
            ),
          ],
        ),
        body: pages[_selectedIndex],
      ),
    );
  }
}
