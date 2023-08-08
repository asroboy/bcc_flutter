import 'package:bcc/bccwidgets/bcc_normal_button.dart';
import 'package:flutter/material.dart';

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
            Center(
              child: Container(
                width: 160,
                height: 30,
                child: Text(
                  '${dataLowongan == null ? 'PT Dummy Data' : dataLowongan['company_name']}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: dataLowongan == null
                  ? Image.asset(
                      'assets/images/dummy_logo_pt.png',
                      height: 90,
                      width: 90,
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
            Container(
              width: width,
              height: 70,
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
                          '${dataLowongan == null ? 'Job Title' : dataLowongan['title']}',
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
                  child: Text('Detail'),
                ))
          ],
        ),
      ),
    );
  }
}
