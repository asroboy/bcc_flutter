import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';

class BccCardPerusahaanSimple extends StatelessWidget {
  const BccCardPerusahaanSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
        child: Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Image.asset(
                            'assets/images/dummy_logo_pt.png',
                            width: 50,
                            height: 50,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'PT Kerja Keras',
                              style: TextStyle(
                                  color: Constants.colorBiruGelap,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text('Perusahaan tanpa henti'),
                            const Text('10 Lowongan'),
                            const Text('20 Pelamar'),
                          ],
                        )
                      ]),
                ),
                Positioned(
                    top: -15,
                    right: 5,
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.bookmark,
                          color: Colors.green,
                        ))),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Constants.colorBiruGelap,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10))),
                      padding: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 5, top: 5),
                      child: const Text(
                        '5 Hari yang lalu',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ))
              ],
            )));
  }
}
