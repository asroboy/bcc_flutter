import 'package:bcc/bccwidgets/bcc_normal_button.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';

class BccCardPerusahaan extends StatelessWidget {
  const BccCardPerusahaan(
      {super.key, required this.dataPerusahaan, this.onTap});

  final dynamic dataPerusahaan;
  final double width = 160;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        margin: const EdgeInsets.all(5),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 35,
                child: Text(
                  dataPerusahaan['name'],
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: dataPerusahaan['company_logo'] != null &&
                          dataPerusahaan['company_logo'] != ''
                      ? Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(45)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    dataPerusahaan['company_logo']),
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
                  maxHeight: 75.0,
                  maxWidth: width,
                ),
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
                            dataPerusahaan['master_industry_name']
                                        .toString()
                                        .length >
                                    40
                                ? dataPerusahaan['master_industry_name']
                                        .toString()
                                        .substring(0, 37) +
                                    ('...')
                                : '${dataPerusahaan['master_industry_name'] ?? '-'}',
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.bold),
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
                            (dataPerusahaan['master_city_name'].toString() +
                                            (', ${dataPerusahaan['master_province_name']}'))
                                        .toString()
                                        .length >
                                    33
                                ? (dataPerusahaan['master_city_name']
                                                .toString() +
                                            (', ${dataPerusahaan['master_province_name']}'))
                                        .toString()
                                        .substring(0, 30)
                                        .toLowerCase() +
                                    ('...')
                                : '${dataPerusahaan['master_city_name'] ?? '-'}, ${dataPerusahaan['master_province_name'] ?? '-'}',
                            overflow: TextOverflow.clip,
                            style: const TextStyle(fontSize: 11),
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
                    onPressed: onTap,
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
      ),
    );
  }
}
