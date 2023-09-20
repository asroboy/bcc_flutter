import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/screen/landing/pelayanan/menumodel.dart';
import 'package:bcc/screen/landing/pelayanan/subcategory.dart';
import 'package:flutter/material.dart';

class DisnakerScreen extends StatefulWidget {
  const DisnakerScreen({super.key});

  @override
  State<DisnakerScreen> createState() => _DisnakerScreenState();
}

class _DisnakerScreenState extends State<DisnakerScreen> {
  List<Menu> data = [];
  List dataList = [
    {
      "icon": Icons.feed_outlined,
      "name": "Kepala Dinas",
      "link":
          "https://bogorcareercenter.bogorkab.go.id/page/index/kepala-dinas-tenaga-kerja"
    },
    {
      "icon": Icons.feed_outlined,
      "name": "Profil Dinas",
      "link":
          "https://bogorcareercenter.bogorkab.go.id/page/index/profil-dinas-tenaga-kerja"
    },
    {
      "icon": Icons.feed_outlined,
      "name": "Strategi",
      "link":
          "https://bogorcareercenter.bogorkab.go.id/page/index/rencana-strategis-dinas-tenaga-kerja"
    },
    {
      "icon": Icons.feed_outlined,
      "name": "Struktur Organisasi",
      "link":
          "https://bogorcareercenter.bogorkab.go.id/page/index/struktur-organisasi"
    },
    {
      "icon": Icons.feed_outlined,
      "name": "Tugas Pokok dan Fungsi",
      "link":
          "https://bogorcareercenter.bogorkab.go.id/page/index/tugas-pokok-fungsi-disnaker"
    },
    {
      "icon": Icons.feed_outlined,
      "name": "Visi dan Misi",
      "link":
          "https://bogorcareercenter.bogorkab.go.id/page/index/visi-misi-pancakarsa-kabupaten-bogor"
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
        title: const Text('Disnaker'),
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
            leading: Icon(list.icon),
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
