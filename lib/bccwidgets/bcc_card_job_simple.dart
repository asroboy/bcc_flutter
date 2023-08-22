import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BccCardJobSimple extends StatelessWidget {
  const BccCardJobSimple({super.key, this.dataLowongan});

  final dynamic dataLowongan;

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
                          child: dataLowongan != null
                              ? Image.asset(
                                  'assets/images/dummy_logo_pt.png',
                                  width: 50,
                                  height: 50,
                                )
                              : (dataLowongan['company_logo'] != null &&
                                      dataLowongan['company_logo'] != ''
                                  ? Image.network(
                                      dataLowongan['company_logo'],
                                      height: 90,
                                      width: 90,
                                    )
                                  : Image.asset(
                                      'assets/images/dummy_logo_pt.png',
                                      height: 90,
                                      width: 90,
                                    )),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              dataLowongan['title'].toString().length > 35
                                  ? dataLowongan['title']
                                          .toString()
                                          .substring(0, 35) +
                                      ('...')
                                  : dataLowongan['title'].toString(),
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  color: Constants.colorBiruGelap,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              dataLowongan['company_name'].toString().length >
                                      40
                                  ? dataLowongan['company_name']
                                          .toString()
                                          .substring(0, 37) +
                                      ('...')
                                  : dataLowongan['company_name'].toString(),
                              style: const TextStyle(fontSize: 11),
                            ),
                            Text(
                              dataLowongan['master_city_name'] +
                                  (dataLowongan['master_province_name']),
                              style: const TextStyle(fontSize: 11),
                            ),
                            Text(
                              'Rp. ${dataLowongan['range_salary_from']} - Rp. ${dataLowongan['range_salary_to']}',
                              style: const TextStyle(fontSize: 11),
                            ),
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
                          color: Colors.grey,
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
                      child: Text(
                        (daysBetween(DateTime.parse(
                                    dataLowongan['created_at'].toString())) <
                                7)
                            ? '${daysBetween(DateTime.parse(dataLowongan['created_at'].toString()))} hari yang lalu'
                            : DateFormat.yMMMd().format(DateTime.parse(
                                dataLowongan['created_at'].toString())),
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ))
              ],
            )));
  }

  int daysBetween(DateTime from) {
    from = DateTime(from.year, from.month, from.day);
    DateTime to = DateTime.now();
    return (to.difference(from).inHours / 24).round();
  }
}
