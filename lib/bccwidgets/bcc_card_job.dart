import 'package:bcc/bccwidgets/bcc_normal_button.dart';
import 'package:flutter/material.dart';

import '../screen/landing/lowongan/lowongan_detail.dart';

class BccCardJob extends StatelessWidget {
  const BccCardJob({super.key, this.dataLowongan});

  final dynamic dataLowongan;
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
            Flexible(
                child: Text(
              dataLowongan['company_name'],
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            )),
            Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10),
                child: dataLowongan['company_logo'] != null &&
                        dataLowongan['company_logo'] != ''
                    ? Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(45)),
                          image: DecorationImage(
                              image: NetworkImage(dataLowongan['company_logo']),
                              fit: BoxFit.fill),
                        ),
                      )
                    : Image.asset(
                        'assets/images/dummy_logo_pt.png',
                        height: 50,
                        width: 50,
                      )),
            ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 70,
                minWidth: width,
                maxHeight: 90.0,
                maxWidth: width,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child:
                            Image.asset('assets/icons/bx_bxs-user-circle.png'),
                      ),
                      Flexible(
                        child: Text(
                          (dataLowongan['title'].toString().length > 20
                              ? (dataLowongan['title']
                                      .toString()
                                      .substring(0, 20) +
                                  ('...'))
                              : dataLowongan['title'].toString()),
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child:
                            Image.asset('assets/icons/mdi_cash-multiple.png'),
                      ),
                      Flexible(
                        child: Text(
                          dataLowongan == null
                              ? 'Salary'
                              : (dataLowongan['range_salary_from']) +
                                  ' - ' +
                                  dataLowongan['range_salary_to'],
                          overflow: TextOverflow.clip,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Image.asset(
                            'assets/icons/carbon_location-filled.png'),
                      ),
                      Flexible(
                        child: Text(
                          dataLowongan == null
                              ? 'Salary'
                              : (dataLowongan['master_city_name']) +
                                  ' - ' +
                                  dataLowongan['master_province_name'],
                          overflow: TextOverflow.clip,
                          style: const TextStyle(fontSize: 12),
                        ),
                      )
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LowonganDetail(job: dataLowongan),
                    ));
                  },
                  child: const Text(
                    'Detail',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
