import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/bcc_no_data_info.dart';
import 'package:bcc/screen/landing/pelayanan/menumodel.dart';
import 'package:bcc/screen/landing/pelayanan/subcategory.dart';
import 'package:flutter/material.dart';

class InformasiPublik extends StatefulWidget {
  const InformasiPublik({super.key});

  @override
  State<InformasiPublik> createState() => _InformasiPublikState();
}

class _InformasiPublikState extends State<InformasiPublik> {
  List<Menu> data = [];
  List dataList = [
    {
      "icon": Icons.feed_outlined,
      "name": "Artikel Berita",
      "link": "https://bogorcareercenter.bogorkab.go.id/news"
    },
    {
      "icon": Icons.feed_outlined,
      "name": "Hubungi Kami",
      "link": "https://bogorcareercenter.bogorkab.go.id/content/contact"
    },
    {
      "icon": Icons.feed_outlined,
      "name": "Info Freelancer",
      "link": "https://bogorcareercenter.bogorkab.go.id/post/freelance"
    },
    {
      "icon": Icons.feed_outlined,
      "name": "Informasi Beasiswa",
      "link": "https://bogorcareercenter.bogorkab.go.id/post/beasiswa"
    },
    {
      "icon": Icons.feed_outlined,
      "name": "Layanan Bantuan & FAQ",
      "link": "https://bogorcareercenter.bogorkab.go.id/content/faq"
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
      appBar: AppBar(title: const Text('Informasi Publik')),
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
