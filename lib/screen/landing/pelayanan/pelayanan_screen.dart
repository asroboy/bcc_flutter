import 'package:bcc/api/helper.dart';
import 'package:bcc/screen/landing/pelayanan/menumodel.dart';
import 'package:bcc/screen/landing/pelayanan/subcategory.dart';
import 'package:flutter/material.dart';

class PelayananScreen extends StatefulWidget {
  const PelayananScreen({super.key});

  @override
  State<PelayananScreen> createState() => _PelayananScreenState();
}

class _PelayananScreenState extends State<PelayananScreen> {
  List<Menu> data = [];
  List dataList = [
    {
      "name": "Hi Syaker, Pengaduan dan Media",
      "icon": Icons.feed_outlined,
      "subMenu": [
        {
          "name": "Layanan LKS Bipartid",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-lks-bipartit"
        },
        {
          "name": "Layanan Pengaduan dan Mediasi",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-pengaduan-dan-mediasi"
        },
        {
          "name": "Layanan Peraturan Perusahaan",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-peraturan-perusahaan"
        },
        {
          "name": "Layanan PWKT",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-pkwt"
        },
        {
          "name": "Layanan Serikat Kerja",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-serikat-pekerja-sp"
        },
        {
          "name": "Layanan Perjanjian Kerja Bersama",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/perjanjian-kerja-bersama"
        },
      ]
    },
    {
      "name": "Pelatihan dan Produktifitas Kerja",
      "icon": Icons.feed_outlined,
      "subMenu": [
        {
          "name": "Layanan Balai Latihan Kerja",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-balai-latihan-kerja-blk"
        },
        {
          "name": "Layanan Lembaga Pelatihan Kerja",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-lembaga-pelatihan-kerja"
        },
        {
          "name": "Layanan Lembaga Sertifikasi",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-lembaga-sertifikasi"
        },
        {
          "name": "Layanan Pemaangan",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-pemagangan"
        },
      ]
    },
    {
      "name": "Penembatan dan Perluasan Kerja",
      "icon": Icons.feed_outlined,
      "subMenu": [
        {
          "name": "Layanan Bursa Kerja Khusus",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-bursa-kerja-khusus-bkk"
        },
        {
          "name": "Layanan CPMI & PPTKIS",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-cpmi"
        },
        {
          "name": "Layanan Kartu AK1/Pencari Kerja/Kartu Kuning",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-ak-1-kartu-pencari-kerja"
        },
        {
          "name": "Layanan LPTKS",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-lptks"
        },
        {
          "name": "Layanan Tenaga Kerja Asing",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-tenaga-kerja-asing-tka"
        },
        {
          "name": "Layanan Tenaga Kerja Indonesia",
          "link":
              "https://bogorcareercenter.bogorkab.go.id/page/index/pelayanan-tenaga-kerja-indonesia"
        },
      ]
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
        // drawer: _drawer(data),
        appBar: AppBar(title: const Text('Pelayanan')),
        body: ListView.builder(
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) =>
              _buildList(data[index]),
        ));
  }

  // Widget _drawer(List<Menu> data) {
  //   return Drawer(
  //       child: SafeArea(
  //     child: SingleChildScrollView(
  //       child: Column(
  //         children: [
  //           const UserAccountsDrawerHeader(
  //               margin: EdgeInsets.only(bottom: 0.0),
  //               accountName: Text('demo'),
  //               accountEmail: Text('demo@webkul.com')),
  //           ListView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             itemCount: data.length,
  //             itemBuilder: (context, index) {
  //               return _buildList(data[index]);
  //             },
  //           )
  //         ],
  //       ),
  //     ),
  //   ));
  // }

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
