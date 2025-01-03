import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bcc/bccwidgets/bcc_line_break.dart';
import 'package:bcc/bccwidgets/display_picture_screen.dart';
import 'package:bcc/screen/pdf/pdf_screen.dart';
import 'package:bcc/screen/pencaker/profil/bcc_subheader_label.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class BiodataLengkap extends StatefulWidget {
  const BiodataLengkap({super.key, this.biodataPencaker});

  final dynamic biodataPencaker;

  @override
  State<BiodataLengkap> createState() => BiodataLengkapState();
}

class BiodataLengkapState extends State<BiodataLengkap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biodata Lengkap'),
      ),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: BccSubheaderLabel(label: 'BIODATA DIRI'),
          ),
          const BccLineSparator(
            margin: EdgeInsets.symmetric(horizontal: 15),
          ),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: const Text(
              'Username',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.biodataPencaker['username'],
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.alternate_email_outlined),
            title: const Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['email']),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.person_pin_outlined),
            title: const Text(
              'Nama Lengkap',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['name']),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.assignment_ind_outlined),
            title: const Text(
              'KTP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['ktp_number']),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.phone_outlined),
            title: const Text(
              'No. Telp',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['phone_number']),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.pin_drop_outlined),
            title: const Text(
              'Alamat',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                '${widget.biodataPencaker['address']},  ${widget.biodataPencaker['master_village_name']}, ${widget.biodataPencaker['master_district_name']}, ${widget.biodataPencaker['master_city_name']}, ${widget.biodataPencaker['master_province_name']}'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.person_pin_circle_outlined),
            title: const Text(
              'Tempat Lahir',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['place_of_birth']),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today_outlined),
            title: const Text(
              'Tanggal Lahir',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['date_of_birth']),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.male_outlined),
            title: const Text(
              'Jenis Kelamin',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['gender']),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.star_outline),
            title: const Text(
              'Agama',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['religion']),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.flag_outlined),
            title: const Text(
              'Kewarganegaraan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['nationality']),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.favorite_outline),
            title: const Text(
              'Status Perkawainan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['marital_status']),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text(
              'Status Bekerja',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['work_status']),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.school_outlined),
            title: const Text(
              'Pendidikan Terakhir',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['master_degree_name'] ?? ''),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today_rounded),
            title: const Text(
              'Tahun Lulus',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(widget.biodataPencaker['graduation_year'] ?? ''),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.height),
            title: const Text(
              'Tinggi Badan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${widget.biodataPencaker['height']} cm'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.monitor_weight_outlined),
            title: const Text(
              'Berat Badan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${widget.biodataPencaker['weight']} kg'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.health_and_safety_outlined),
            title: const Text(
              'BPJS Kesehatan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${widget.biodataPencaker['bpjs_health_number']}'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.security_outlined),
            title: const Text(
              'BPJS Ketenagakerjaan',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${widget.biodataPencaker['bpjs_number']}'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: BccSubheaderLabel(label: 'TENTANG SAYA'),
          ),
          const BccLineSparator(
            margin: EdgeInsets.symmetric(horizontal: 15),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text(
              'Tentang Saya',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${widget.biodataPencaker['headline']}'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: BccSubheaderLabel(label: 'DOKUMEN SAYA'),
          ),
          const BccLineSparator(
            margin: EdgeInsets.symmetric(horizontal: 15),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'CV (Riwayat Hidup)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.biodataPencaker['cv_file'] != null
                  ? 'Klik untuk melihat CV'
                  : 'Belum upload CV',
              style: TextStyle(
                  color: widget.biodataPencaker['cv_file'] != null
                      ? Colors.blue
                      : Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: widget.biodataPencaker['cv_file'] != null
                ? const Icon(Icons.navigate_next)
                : null,
            onTap: widget.biodataPencaker['cv_file'] != null
                ? () {
                    String url = widget.biodataPencaker['cv_file'];
                    log('url ${widget.biodataPencaker['cv_file']}');

                    String fileName = getFileNameFromUrl(url);
                    createFileOfPdfUrl(url, fileName).then((f) {
                      String path = f.path;
                      Navigator.push(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) => PdfScreen(
                            path: path,
                            title: 'CV (Riwayat Hidup)',
                          ),
                        ),
                      );
                    });
                  }
                : null,
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Scan/Foto KTP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.biodataPencaker['ktp_file'] != null
                  ? 'Klik untuk melihat KTP'
                  : 'Belum upload KTP',
              style: TextStyle(
                  color: widget.biodataPencaker['ktp_file'] != null
                      ? Colors.blue
                      : Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: widget.biodataPencaker['ktp_file'] != null
                ? const Icon(Icons.navigate_next)
                : null,
            onTap: widget.biodataPencaker['ktp_file'] != null
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        imageUrl: widget.biodataPencaker['ktp_file'],
                        title: 'KTP Saya',
                      ),
                    ));
                  }
                : null,
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Scan/Foto Ijazah Terakhir',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.biodataPencaker['ijazah_file'] != null
                  ? 'Klik untuk melihat Ijazah'
                  : 'Belum upload Ijazah',
              style: TextStyle(
                  color: widget.biodataPencaker['ijazah_file'] != null
                      ? Colors.blue
                      : Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: widget.biodataPencaker['ijazah_file'] != null
                ? const Icon(Icons.navigate_next)
                : null,
            onTap: widget.biodataPencaker['ijazah_file'] != null
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        imageUrl: widget.biodataPencaker['ijazah_file'],
                        title: 'Ijazah Saya',
                      ),
                    ));
                  }
                : null,
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Scan/Foto N P W P',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.biodataPencaker['npwp_file'] != null
                  ? 'Klik untuk melihat NPWP'
                  : 'Belum upload NPWP',
              style: TextStyle(
                  color: widget.biodataPencaker['npwp_file'] != null
                      ? Colors.blue
                      : Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: widget.biodataPencaker['npwp_file'] != null
                ? const Icon(Icons.navigate_next)
                : null,
            onTap: widget.biodataPencaker['npwp_file'] != null
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        imageUrl: widget.biodataPencaker['npwp_file'],
                        title: 'NPWP',
                      ),
                    ));
                  }
                : null,
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Sertifikat Vaksin 1 - 3',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.biodataPencaker['vaksin_file'] != null
                  ? 'Klik untuk melihat Vaksin'
                  : 'Belum upload Vaksin',
              style: TextStyle(
                  color: widget.biodataPencaker['vaksin_file'] != null
                      ? Colors.blue
                      : Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: widget.biodataPencaker['vaksin_file'] != null
                ? const Icon(Icons.navigate_next)
                : null,
            onTap: widget.biodataPencaker['vaksin_file'] != null
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        imageUrl: widget.biodataPencaker['vaksin_file'],
                        title: 'Sertifikat Vaksin',
                      ),
                    ));
                  }
                : null,
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Scan/Foto Akta Kelahiran',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.biodataPencaker['akta_file'] != null
                  ? 'Klik untuk melihat Akta Kelahiran'
                  : 'Belum upload Akta Kelahiran',
              style: TextStyle(
                  color: widget.biodataPencaker['akta_file'] != null
                      ? Colors.blue
                      : Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: widget.biodataPencaker['akta_file'] != null
                ? const Icon(Icons.navigate_next)
                : null,
            onTap: widget.biodataPencaker['akta_file'] != null
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        imageUrl: widget.biodataPencaker['akta_file'],
                        title: 'Akta Kelahiran Saya',
                      ),
                    ));
                  }
                : null,
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Scan/Foto SKCK',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.biodataPencaker['skck_file'] != null
                  ? 'Klik untuk melihat SKCK'
                  : 'Belum upload SKCK',
              style: TextStyle(
                  color: widget.biodataPencaker['skck_file'] != null
                      ? Colors.blue
                      : Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: widget.biodataPencaker['skck_file'] != null
                ? const Icon(Icons.navigate_next)
                : null,
            onTap: widget.biodataPencaker['skck_file'] != null
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        imageUrl: widget.biodataPencaker['skck_file'],
                        title: 'SKCK',
                      ),
                    ));
                  }
                : null,
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Domisili (Jika KTP diluar Kab. Bogor)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              widget.biodataPencaker['domisili_file'] != null
                  ? 'Klik untuk melihat Domisili'
                  : 'Belum upload Domisili',
              style: TextStyle(
                  color: widget.biodataPencaker['domisili_file'] != null
                      ? Colors.blue
                      : Colors.red),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: widget.biodataPencaker['domisili_file'] != null
                ? const Icon(Icons.navigate_next)
                : null,
            onTap: widget.biodataPencaker['domisili_file'] != null
                ? () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        imageUrl: widget.biodataPencaker['domisili_file'],
                        title: 'Domisili',
                      ),
                    ));
                  }
                : null,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: BccSubheaderLabel(label: 'MEDIA SOSIAL'),
          ),
          const BccLineSparator(
            margin: EdgeInsets.symmetric(horizontal: 15),
          ),
          ListTile(
            leading: const Icon(Icons.facebook_outlined),
            title: const Text(
              'Facebook',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${widget.biodataPencaker['facebook'] ?? '-'}'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.alternate_email_sharp),
            title: const Text(
              'X (Twitter)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${widget.biodataPencaker['twitter'] ?? '-'}'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
          ListTile(
            leading: const Icon(Icons.alternate_email_sharp),
            title: const Text(
              'Instagram',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${widget.biodataPencaker['instagram'] ?? '-'}'),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
          ),
        ],
      ),
    );
  }

  Future<File> createFileOfPdfUrl(String url, String fileName) async {
    Completer<File> completer = Completer();
    log("Start download file from internet!");
    try {
      // "https://berlin2017.droidcon.cod.newthinking.net/sites/global.droidcon.cod.newthinking.net/files/media/documents/Flutter%20-%2060FPS%20UI%20of%20the%20future%20%20-%20DroidconDE%2017.pdf";
      // final url = "https://pdfkit.org/docs/guide.pdf";
      // final url = url;
      final filename = fileName;
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      log("Download files");
      log("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  String getFileNameFromUrl(String url) {
    Uri uri = Uri.parse(url);
    String fileName = uri.pathSegments.last.split("/").last;
    return fileName;
  }
}
