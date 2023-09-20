import 'package:bcc/api/helper.dart';
import 'package:bcc/screen/landing/pelayanan/menumodel.dart';
import 'package:bcc/screen/landing/pelayanan/subcategory.dart';
import 'package:flutter/material.dart';

class PreneurScreen extends StatefulWidget {
  const PreneurScreen({super.key});

  @override
  State<PreneurScreen> createState() => _PreneurScreenState();
}

class _PreneurScreenState extends State<PreneurScreen> {
  List<Menu> data = [];
  List dataList = [
    {
      "icon": Icons.feed_outlined,
      "name": "Lapak Wirausaha Baru",
      "link": "https://bogorcareercenter.bogorkab.go.id/shop"
    },
    {
      "icon": Icons.feed_outlined,
      "name": "Produk Wirausaha Baru",
      "link": "https://bogorcareercenter.bogorkab.go.id/product"
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
      appBar: AppBar(title: const Text('BCC Preneur')),
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
