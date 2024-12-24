import 'package:bcc/screen/perusahaan/profile_perusahaan/header_label.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/profile_perusahaan_model.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/row_data.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/ubah_pic_perusahaan.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pic extends StatefulWidget {
  const Pic({super.key, this.profilPerusahaan});

  final dynamic profilPerusahaan;
  @override
  State<Pic> createState() => _PicState();
}

class _PicState extends State<Pic> {
  @override
  Widget build(BuildContext context) {
    ProfilePerusahaanModel profile = context.watch<ProfilePerusahaanModel>();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const UbahPICPerusahaan(),
          ));
        },
        child: const Icon(Icons.edit),
      ),
      appBar: AppBar(
        title: const Text('PIC'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          ),
          const HeaderLabel(label: 'Idnetitas Pimpinan '),
          Center(
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 15, bottom: 15),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(223, 134, 205, 226)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Icon(
                        Icons.person,
                        size: 35,
                      )

                      // const Image(
                      //     image: AssetImage('/icons/ic_back.png'))

                      ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: const Color.fromARGB(255, 83, 123, 161),
                            width: 0.2),
                        color: Colors.white),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 20)),
          RowData(
            label: 'No. KTP Direktur/HRD',
            value: profile.profil['director_ktp'] ?? '',
          ),
          RowData(
            label: 'Nama Direktur/HRD',
            value: profile.profil['director_name'] ?? '',
          ),
          RowData(
            label: 'Telepon Direktur',
            value: profile.profil['director_phone_number'] ?? '',
          ),
        ],
      ),
    );
  }
}
