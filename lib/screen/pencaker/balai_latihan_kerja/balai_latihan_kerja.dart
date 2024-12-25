import 'package:bcc/screen/pencaker/balai_latihan_kerja/daftar_pelatihan_kerja.dart';
import 'package:bcc/screen/pencaker/balai_latihan_kerja/riwayat_pelatihan.dart';
import 'package:flutter/material.dart';

class BalaiLatihanKerja extends StatefulWidget {
  const BalaiLatihanKerja({super.key});

  @override
  State<BalaiLatihanKerja> createState() => _BalaiLatihanKerjaState();
}

class _BalaiLatihanKerjaState extends State<BalaiLatihanKerja> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const DaftarPelatihanKerja(),
      const RiwayatPelatihan(),
    ];

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Balai Latihan Kerja'),
            bottom: TabBar(
              isScrollable: true,
              unselectedLabelColor: const Color.fromARGB(255, 93, 162, 189),
              labelColor: Colors.white,
              tabs: [
                SizedBox(
                  height: 70,
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: const Tab(
                    icon: Icon(Icons.list_alt),
                    text: "Daftar Pelatihan",
                  ),
                ),
                SizedBox(
                    height: 70,
                    width: MediaQuery.of(context).size.width * 0.3,
                    child:
                        const Tab(icon: Icon(Icons.groups_2), text: "Riwayat")),
              ],
            ),
          ),
          body: TabBarView(children: pages),
          // const BccNoDataInfo(),
        ));
  }
}
