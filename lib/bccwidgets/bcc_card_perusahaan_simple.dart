import 'dart:developer';

import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';

class BccCardPerusahaanSimple extends StatelessWidget {
  const BccCardPerusahaanSimple({super.key, this.perusahaan, this.onTap});

  final dynamic perusahaan;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    log('perusahaan $perusahaan');
    return GestureDetector(
      onTap: onTap,
      child: Card(
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
                            child: perusahaan['logo'] != null &&
                                    perusahaan['logo'] != ''
                                ? Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(45)),
                                      image: DecorationImage(
                                          image:
                                              NetworkImage(perusahaan['logo']),
                                          fit: BoxFit.fill),
                                    ),
                                  )
                                : Image.asset(
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
                                perusahaan['name'],
                                style: TextStyle(
                                    color: Constants.colorBiruGelap,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Flex(
                                direction: Axis.vertical,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Text(
                                      perusahaan['master_industry_name'] ?? '-',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Colors.blueGrey[400]),
                                    ),
                                  )
                                ],
                              ),
                              perusahaan['email_company'] == null
                                  ? const Center()
                                  : Text(perusahaan['email_company'] ?? '-'),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10))
                            ],
                          )
                        ]),
                  ),
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
                          perusahaan['founded'],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ))
                ],
              ))),
    );
  }
}
