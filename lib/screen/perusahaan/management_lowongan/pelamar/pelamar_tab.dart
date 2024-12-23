// import 'package:bcc/contants.dart';
import 'package:bcc/screen/perusahaan/management_lowongan/pelamar/data_pelamar_kerja.dart';
import 'package:flutter/material.dart';

class PelamarTab extends StatefulWidget {
  const PelamarTab({super.key, this.lowongan});
  final dynamic lowongan;
  @override
  State<PelamarTab> createState() => _PelamarTabState();
}

class _PelamarTabState extends State<PelamarTab> {
  // int _selectedIndex = 0;

  // _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      DataPelamarKerja(
        lowongan: widget.lowongan,
        status: StatusLamaran.pending,
        title: 'Pending',
      ),
      DataPelamarKerja(
        lowongan: widget.lowongan,
        status: StatusLamaran.accepted,
        title: 'On Review',
      ),
      DataPelamarKerja(
        lowongan: widget.lowongan,
        status: StatusLamaran.interview,
        title: 'Interview',
      ),
      DataPelamarKerja(
        lowongan: widget.lowongan,
        status: StatusLamaran.approved,
        title: 'Approved',
      ),
      DataPelamarKerja(
        lowongan: widget.lowongan,
        status: StatusLamaran.rejected,
        title: 'Rejected',
      ),
    ];
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            isScrollable: true,
            unselectedLabelColor: Color.fromARGB(255, 93, 162, 189),
            labelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(Icons.list_alt),
                text: "Pelamar",
              ),
              Tab(icon: Icon(Icons.groups_2), text: "Lolos Adm."),
              Tab(icon: Icon(Icons.chat), text: "Interview"),
              Tab(icon: Icon(Icons.work), text: "Diterima"),
              Tab(icon: Icon(Icons.work_off), text: "Ditolak"),
            ],
          ),
          title: const Text('Data Pelamar'),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   useLegacyColorScheme: false,
        //   type: BottomNavigationBarType.shifting,
        //   selectedItemColor: Constants.colorBiruGelap,
        //   unselectedItemColor: Constants.colorGrey,
        //   currentIndex: _selectedIndex, //New
        //   onTap: _onItemTapped,
        //   items: const <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.list_alt),
        //       label: 'Pelamar',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.groups_2),
        //       label: 'Lolos Adm.',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.chat),
        //       label: 'Interview',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.work),
        //       label: 'Diterima',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.work_off),
        //       label: 'Ditolak',
        //     ),
        //   ],
        // ),
        body: TabBarView(children: pages),
      ),
    );
  }
}
