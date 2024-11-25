import 'package:flutter/material.dart';

class DashboardPerusahaan extends StatefulWidget {
  const DashboardPerusahaan({super.key});

  @override
  State<DashboardPerusahaan> createState() => _DashboardPerusahaanState();
}

class _DashboardPerusahaanState extends State<DashboardPerusahaan> {
  @override
  Widget build(BuildContext context) {
    double headerHeight = MediaQuery.of(context).size.height * 0.20;
    double bodyHeight = MediaQuery.of(context).size.height - headerHeight;

    return Scaffold(
        body: Stack(children: [
      Container(
        height: headerHeight,
        color: Theme.of(context).colorScheme.primary,
        child: const Column(
          children: [
            Row(
              children: [],
            )
          ],
        ),
      ),
      Container(
        margin: EdgeInsets.only(
            top: (headerHeight + 2), bottom: 10, left: 10, right: 10),
        height: bodyHeight,
        child: ListView(
          children: [],
        ),
      )
    ]));
  }
}
