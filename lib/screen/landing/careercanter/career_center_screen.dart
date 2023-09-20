import 'package:bcc/api/helper.dart';
import 'package:bcc/screen/landing/pelayanan/menumodel.dart';
import 'package:bcc/screen/landing/pelayanan/subcategory.dart';
import 'package:flutter/material.dart';

class CareerCenterScreen extends StatefulWidget {
  const CareerCenterScreen({super.key});

  @override
  State<CareerCenterScreen> createState() => _CareerCenterScreenState();
}

class _CareerCenterScreenState extends State<CareerCenterScreen> {
  List<Menu> data = [];
  List dataList = [
    {
      "icon": Icons.feed_outlined,
      "name": "Data Statistik",
      "subMenu": [
        {
          "name": "Grafik Kandidat",
          "link": "https://bogorcareercenter.bogorkab.go.id/chart"
        },
        {
          "name": "Grafik Status Bekerja",
          "link": "https://bogorcareercenter.bogorkab.go.id/chart/work_status"
        },
      ]
    },
    {
      "icon": Icons.feed_outlined,
      "name": "Lembaga Sertifikasi Profesi",
      "subMenu": [
        {
          "name": "Profil LSP KKB",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/profil-lsp-ketenagakerjaan-kabupaten-bogor"
        },
        {
          "name": "Skema Sertifikasi",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/skema-sertifikasi-lsp"
        },
        {
          "name": "Struktur Organisasi LSP",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/struktur-organisasi-lsp-ketenagakerjaan-kabupaten-bogor"
        },
      ]
    },
    {
      "icon": Icons.feed_outlined,
      "name": "Balai Latihan Kerja",
      "link": "https://bogorcareercenter.bogorkab.go.id/content/blk"
    },
  ];

  @override
  void initState() {
    for (var element in dataList) {
      data.add(Menu.fromJson(element));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Career Center'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) =>
            _buildList(data[index]),
      ),
    );
  }

  Widget _buildList(Menu list) {
    if (list.subMenu.isEmpty) {
      return Builder(builder: (context) {
        return ListTile(
            onTap: () {
              if (list.link == null || list.link == '') {
                showAlertDialog('Url tidak ditemukan', context);
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SubCategory(list.name, list.link)));
              }
            },
            leading: const SizedBox(),
            title: Text(list.name));
      });
    } else {
      return ExpansionTile(
        leading: Icon(list.icon),
        title: Text(
          list.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        children: list.subMenu.map(_buildList).toList(),
      );
    }
  }
}
