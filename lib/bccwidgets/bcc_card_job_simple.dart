import 'dart:developer';

import 'package:bcc/api/api.dart';
import 'package:bcc/api/api_perusahaan_call.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/contants.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

class BccCardJobSimple extends StatefulWidget {
  const BccCardJobSimple({super.key, this.dataLowongan, this.onTap});

  final dynamic dataLowongan;
  final Function()? onTap;

  @override
  State<BccCardJobSimple> createState() => _BccCardJobSimpleState();
}

class _BccCardJobSimpleState extends State<BccCardJobSimple> {
  final ApiPerusahaanCall _apiPerusahaanCall = ApiPerusahaanCall();
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  String? jobseekerWishlistId;

  bool isLoading = true;
  final ApiHelper _apiHelper = ApiHelper();

  @override
  void initState() {
    jobseekerWishlistId = widget.dataLowongan['jobseeker_wishlist_id'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
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
                            child: widget.dataLowongan['company_logo'] !=
                                        null &&
                                    widget.dataLowongan['company_logo'] != ''
                                ? Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.grey, width: 0.5),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(45)),
                                      image: DecorationImage(
                                          image: NetworkImage(widget
                                              .dataLowongan['company_logo']),
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
                                widget.dataLowongan['title'].toString().length >
                                        35
                                    ? widget.dataLowongan['title']
                                            .toString()
                                            .substring(0, 35) +
                                        ('...')
                                    : widget.dataLowongan['title'].toString(),
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                    color: Constants.colorBiruGelap,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.dataLowongan['company_name']
                                            .toString()
                                            .length >
                                        40
                                    ? widget.dataLowongan['company_name']
                                            .toString()
                                            .substring(0, 37) +
                                        ('...')
                                    : widget.dataLowongan['company_name']
                                        .toString(),
                                style: const TextStyle(fontSize: 11),
                              ),
                              Text(
                                widget.dataLowongan['master_city_name'] +
                                    (widget
                                        .dataLowongan['master_province_name']),
                                style: const TextStyle(fontSize: 11),
                              ),
                              Text(
                                'Rp. ${widget.dataLowongan['range_salary_from']} - Rp. ${widget.dataLowongan['range_salary_to']}',
                                style: const TextStyle(fontSize: 11),
                              ),
                              Text(
                                widget.dataLowongan['status'],
                                style: TextStyle(
                                    fontSize: 11,
                                    color: (widget.dataLowongan['status'] ==
                                                'active' ||
                                            widget.dataLowongan['status'] ==
                                                'Aktif')
                                        ? Colors.blue
                                        : Colors.red),
                              ),
                            ],
                          )
                        ]),
                  ),
                  Positioned(
                      top: -15,
                      right: 5,
                      child: IconButton(
                          onPressed: () {
                            if (jobseekerWishlistId != null) {
                              _hapusBookmark(dataLowongan: widget.dataLowongan);
                            } else {
                              _bookmark(dataLowongan: widget.dataLowongan);
                            }
                          },
                          icon: Icon(
                            Icons.bookmark,
                            color: jobseekerWishlistId != null
                                ? const Color.fromARGB(255, 3, 66, 117)
                                : Colors.grey,
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
                          (daysBetween(DateTime.parse(widget
                                      .dataLowongan['created_at']
                                      .toString())) <
                                  7)
                              ? '${daysBetween(DateTime.parse(widget.dataLowongan['created_at'].toString()))} hari yang lalu'
                              : DateFormat.yMMMd().format(DateTime.parse(widget
                                  .dataLowongan['created_at']
                                  .toString())),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                      ))
                ],
              ))),
    );
  }

  _getBookmark({required dynamic dataLowongan}) {
    String idJobSeeker = loginInfo['data']['id'];
    // String token = loginInfo['data']['token'];

    _apiPerusahaanCall
        .getWishListLowongan(
            companyJobId: dataLowongan['id'], jobseekerId: idJobSeeker)
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                log('response: $response');
                setState(() {
                  List<dynamic> d = response['data'];
                  if (d.isNotEmpty) {
                    jobseekerWishlistId = d[0]['id'];
                  } else {
                    jobseekerWishlistId = null;
                  }
                });
              });
        }
      },
    );
  }

  _bookmark({required dynamic dataLowongan}) {
    if (loginInfo == null) {
      showAlertDialog(
          'Silahkan login untuk dapat mengakses fitur ini', context);
      return;
    }
    String jobSeekerId = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];

    dynamic dataBody = {
      'jobseeker_id': jobSeekerId,
      'company_job_id': dataLowongan['id']
    };
    _apiPerusahaanCall
        .simpanWishListLowongan(requestBody: dataBody, token: token)
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                log('response: $response');
                _getBookmark(dataLowongan: dataLowongan);
              });
        }
      },
    );
  }

  _hapusBookmark({required dynamic dataLowongan}) {
    // String idPerusahaan = loginInfo['data']['id'];
    String token = loginInfo['data']['token'];

    _apiPerusahaanCall
        .hapusnWishListLowongan(id: jobseekerWishlistId!, token: token)
        .then(
      (value) {
        if (mounted) {
          _apiHelper.apiCallResponseHandler(
              response: value,
              context: context,
              onSuccess: (response) {
                log('response: $response');
                _getBookmark(dataLowongan: dataLowongan);
              });
        }
      },
    );
  }

  int daysBetween(DateTime from) {
    from = DateTime(from.year, from.month, from.day);
    DateTime to = DateTime.now();
    return (to.difference(from).inHours / 24).round();
  }
}
