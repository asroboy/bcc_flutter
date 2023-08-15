import 'package:bcc/bccwidgets/bcc_normal_button.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';

class BccCardPerusahaan extends StatelessWidget {
  const BccCardPerusahaan({super.key, required this.dataPerusahaan});

  final dynamic dataPerusahaan;
  final double width = 160;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 160,
                height: 30,
                child: Text(
                  '${dataPerusahaan['name'] ?? '-'}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: dataPerusahaan['logo'] == ''
                    ? Image.asset(
                        'assets/images/dummy_logo_pt.png',
                        height: 90,
                        width: 90,
                      )
                    : Image.network(
                        dataPerusahaan['logo'],
                        height: 90,
                        width: 90,
                      )),
            Container(
              width: width,
              height: 70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 5, right: 5, top: 0),
                        child: Icon(
                          Icons.info,
                          size: 14,
                          color: Constants.colorBiruGelap,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '${dataPerusahaan['master_industry_name']}',
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Icon(
                            Icons.pin_drop,
                            size: 14,
                            color: Constants.colorBiruGelap,
                          )),
                      Flexible(
                        child: Text(
                          '${dataPerusahaan['master_city_name']}, ${dataPerusahaan['master_province_name']}',
                          overflow: TextOverflow.clip,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
            ),
            SizedBox(
                width: width,
                child: BccNormalButton(
                  onPressed: () {},
                  child: const Text('Detail'),
                ))
          ],
        ),
      ),
    );
  }
}
