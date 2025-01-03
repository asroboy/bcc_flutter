import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'dart:math' as math;
import 'package:bcc/api/api.dart';
import 'package:bcc/api/helper.dart';
import 'package:bcc/bccwidgets/loading_indicator.dart';
import 'package:bcc/contants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as p;

class UbahDokumenSaya extends StatefulWidget {
  const UbahDokumenSaya({super.key, this.biodataPencaker});

  final dynamic biodataPencaker;

  @override
  State<UbahDokumenSaya> createState() => _UbahDokumenSayaState();
}

class _UbahDokumenSayaState extends State<UbahDokumenSaya> {
  late ApiHelper _apiHelper;
  dynamic loginInfo = GetStorage().read(Constants.loginInfo);

  @override
  void initState() {
    super.initState();

    _apiHelper = ApiHelper(buildContext: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dokumen Saya'),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'CV (Riwayat Hidup)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                _pathFileCV != null
                    ? _getFileName(_pathFileCV!)
                    : widget.biodataPencaker['cv_file'] != null
                        ? 'Sudah upload CV, Klik untuk mengubah/upload ulang'
                        : 'Belum upload CV, klik untuk upload',
                style: TextStyle(
                    color: widget.biodataPencaker['cv_file'] != null
                        ? Colors.blue
                        : Colors.red)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: const Icon(Icons.folder_open_outlined),
            onTap: () => _ambilFile(codeFileCV),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Scan/Foto KTP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                _pathFileKTP != null
                    ? _getFileName(_pathFileKTP!)
                    : widget.biodataPencaker['ktp_file'] != null
                        ? 'Sudah upload KTP, Klik untuk mengubah/upload ulang'
                        : 'Belum upload KTP, Klik untuk upload',
                style: TextStyle(
                    color: widget.biodataPencaker['ktp_file'] != null
                        ? Colors.blue
                        : Colors.red)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: const Icon(Icons.folder_open_outlined),
            onTap: () => _ambilFile(codeFileKTP),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Scan/Foto Ijazah Terakhir',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                _pathFileIjazah != null
                    ? _getFileName(_pathFileIjazah!)
                    : widget.biodataPencaker['ijazah_file'] != null
                        ? 'Sudah upload Ijazah, klik untuk mengubah/upload ulang'
                        : 'Belum upload IJazah, klik untuk upload',
                style: TextStyle(
                    color: widget.biodataPencaker['ijazah_file'] != null
                        ? Colors.blue
                        : Colors.red)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: const Icon(Icons.folder_open_outlined),
            onTap: () => _ambilFile(codeFileIjazah),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Scan/Foto N P W P',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                _pathFileNPWP != null
                    ? _getFileName(_pathFileNPWP!)
                    : widget.biodataPencaker['npwp_file'] != null
                        ? 'Sudah upload NPWP, klik untuk mengubah/upload ulang'
                        : 'Belum upload NPWP, klik untuk upload',
                style: TextStyle(
                    color: widget.biodataPencaker['npwp_file'] != null
                        ? Colors.blue
                        : Colors.red)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: const Icon(Icons.folder_open_outlined),
            onTap: () => _ambilFile(codeFileNPWP),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Sertifikat Vaksin 1 - 3',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                _pathFileVaksin != null
                    ? _getFileName(_pathFileVaksin!)
                    : widget.biodataPencaker['vaksin_file'] != null
                        ? 'Sudah upload Vaksin, klik untuk mengubah/upload ulang'
                        : 'Belum upload Vaksin, klik untuk upload',
                style: TextStyle(
                    color: widget.biodataPencaker['vaksin_file'] != null
                        ? Colors.blue
                        : Colors.red)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: const Icon(Icons.folder_open_outlined),
            onTap: () => _ambilFile(codeFileVaksin),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Scan/Foto Akta Kelahiran',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                _pathFileAkta != null
                    ? _getFileName(_pathFileAkta!)
                    : widget.biodataPencaker['akta_file'] != null
                        ? 'Sudah upload Akta Kelahiran, klik untuk mengubah/upload ulang'
                        : 'Belum upload Akta Kelahiran, klik untuk upload',
                style: TextStyle(
                    color: widget.biodataPencaker['akta_file'] != null
                        ? Colors.blue
                        : Colors.red)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: const Icon(Icons.folder_open_outlined),
            onTap: () => _ambilFile(codeFileAkta),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Scan/Foto SKCK',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                _pathFileSKCK != null
                    ? _getFileName(_pathFileSKCK!)
                    : widget.biodataPencaker['skck_file'] != null
                        ? 'Sudah upload SKCK, klik untuk mengubah/upload ulang'
                        : 'Belum upload SKCK, klik untuk upload',
                style: TextStyle(
                    color: widget.biodataPencaker['skck_file'] != null
                        ? Colors.blue
                        : Colors.red)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: const Icon(Icons.folder_open_outlined),
            onTap: () => _ambilFile(codeFileSKCK),
          ),
          ListTile(
            leading: const Icon(Icons.description_outlined),
            title: const Text(
              'Domisili (Jika KTP diluar Kab. Bogor)',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                _pathFileDomisili != null
                    ? _getFileName(_pathFileDomisili!)
                    : widget.biodataPencaker['domisili_file'] != null
                        ? 'Sudah upload Domisili, klik untuk mengubah/upload ulang'
                        : 'Belum upload Domisili, klik untuk upload',
                style: TextStyle(
                    color: widget.biodataPencaker['domisili_file'] != null
                        ? Colors.blue
                        : Colors.red)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            dense: true,
            trailing: const Icon(Icons.folder_open_outlined),
            onTap: () => _ambilFile(codeFileDomisili),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: ElevatedButton(
                    onPressed: () {
                      _startUploadFiles();
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.upload),
                        Padding(padding: EdgeInsets.only(right: 5)),
                        Text('Upload')
                      ],
                    )),
              )
            ],
          )
        ],
      ),
    );
  }

  String? _pathFileCV;
  String? _pathFileKTP;
  String? _pathFileIjazah;
  String? _pathFileNPWP;
  String? _pathFileVaksin;
  String? _pathFileAkta;
  String? _pathFileSKCK;
  String? _pathFileDomisili;

  int codeFileCV = 1;
  int codeFileKTP = 2;
  int codeFileNPWP = 3;
  int codeFileVaksin = 4;
  int codeFileAkta = 5;
  int codeFileSKCK = 6;
  int codeFileDomisili = 7;
  int codeFileIjazah = 8;

  _ambilFile(int codeFile) async {
    List<String> filesAllowed = ['jpg'];
    if (codeFile == codeFileCV) {
      filesAllowed = ['pdf'];
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: filesAllowed,
    );

    if (result != null) {
      String? path = result.files.single.path;
      // String? name = result.files.single.name;

      if (path != null) {
        // File file = File(path);
        // String baseFileName = p.basename(file.path);
        setState(() {
          if (codeFile == codeFileCV) {
            _pathFileCV = path;
          } else if (codeFile == codeFileKTP) {
            _pathFileKTP = path;
          } else if (codeFile == codeFileNPWP) {
            _pathFileNPWP = path;
          } else if (codeFile == codeFileVaksin) {
            _pathFileVaksin = path;
          } else if (codeFile == codeFileAkta) {
            _pathFileAkta = path;
          } else if (codeFile == codeFileSKCK) {
            _pathFileSKCK = path;
          } else if (codeFile == codeFileDomisili) {
            _pathFileDomisili = path;
          } else if (codeFile == codeFileIjazah) {
            _pathFileIjazah = path;
          }
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("File tidak ditemukan"),
          ));
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("File tidak ditemukan"),
        ));
      }
    }
  }

  _startUploadFiles() {
    LoadingIndicatorDialog dialog = LoadingIndicatorDialog();
    if (mounted) {
      dialog.show(context);
    }
    Future<StreamedResponse> f = uploadFile();

    f.then((value) {
      Future<String> streamResponse = value.stream.bytesToString();
      streamResponse.then((value) {
        var data = jsonDecode(value);
        log('result updaload $data');

        showAlertDialogWithAction('Upload dokumen berhasil', context, () {
          Navigator.of(context).pop();
          Navigator.of(context).pop('OK');
        }, 'OK');
        // setState(() {
        //   // isLoading = true;
        //   // userInfo = loginInfo['data'];
        //   // _fetchBiodataRinciPencaker();
        // });
      });

      dialog.dismiss();
    });
  }

  // 2. compress file and get file.

  Future<File> compressImageAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 80,
      rotate: 0,
    );

    String fSizeOri = await getFileSize(file.absolute.path, 2);
    log('size original file $fSizeOri');
    File resultFile = File(result!.path);
    String fSize = await getFileSize(result.path, 2);
    log('size compressed file $fSize');
    return resultFile;
  }

  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (math.log(bytes) / math.log(1024)).floor();
    return '${(bytes / math.pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }

  _getFileName(String path) {
    File file = File(path);
    String baseFileName = p.basename(file.path);
    return baseFileName;
  }

  Future<StreamedResponse> uploadFile() async {
    String token = loginInfo['data']['token'];
    String jobseekerId = loginInfo['data']['unique_id'];

// ApiHelper apiHelper =
    //     ApiHelper(apiUrl: _apiHelper.link().replaceAll('Api', 'DoUpload'));
    String apiPath =
        '${Constants.host}${Constants.pathDataPencaker}/$jobseekerId';

    log('path url $apiPath');
    MultipartRequest multipartRequest =
        _apiHelper.initMultipartReqest(url: apiPath, method: 'POST');

    if (_pathFileCV != null) {
      File fileCV = File(_pathFileCV!);
      String baseFileNameCV = p.basename(fileCV.path);
      log('file name $baseFileNameCV');
      multipartRequest.files
          .add(await MultipartFile.fromPath('cv_file', _pathFileCV!));
    }

    if (_pathFileAkta != null) {
      File fileAkta = File(_pathFileAkta!);
      String baseFileNameAkta = p.basename(fileAkta.path);
      log('file name $baseFileNameAkta');
      multipartRequest.files
          .add(await MultipartFile.fromPath('akta_file', _pathFileAkta!));
    }

    if (_pathFileDomisili != null) {
      File fileDomisili = File(_pathFileDomisili!);
      String baseFileNameDomisili = p.basename(fileDomisili.path);
      log('file name $baseFileNameDomisili');
      multipartRequest.files.add(
          await MultipartFile.fromPath('domisili_file', _pathFileDomisili!));
    }

    if (_pathFileIjazah != null) {
      File fileIjazah = File(_pathFileIjazah!);
      String baseFileNameIjazah = p.basename(fileIjazah.path);
      log('file name $baseFileNameIjazah');
      multipartRequest.files
          .add(await MultipartFile.fromPath('ijazah_file', _pathFileIjazah!));
    }

    if (_pathFileKTP != null) {
      File fileKTP = File(_pathFileKTP!);
      String baseFileNameKTP = p.basename(fileKTP.path);
      log('file name $baseFileNameKTP');
      multipartRequest.files
          .add(await MultipartFile.fromPath('ktp_file', _pathFileKTP!));
    }

    if (_pathFileNPWP != null) {
      File fileNPWP = File(_pathFileNPWP!);
      String baseFileNameNPWP = p.basename(fileNPWP.path);
      log('file name $baseFileNameNPWP');
      multipartRequest.files
          .add(await MultipartFile.fromPath('npwp_file', _pathFileNPWP!));
    }

    if (_pathFileSKCK != null) {
      File fileSKCK = File(_pathFileSKCK!);
      String baseFileNameSKCK = p.basename(fileSKCK.path);
      log('file name $baseFileNameSKCK');
      multipartRequest.files
          .add(await MultipartFile.fromPath('skck_file', _pathFileSKCK!));
    }

    if (_pathFileVaksin != null) {
      File fileVaksin = File(_pathFileVaksin!);
      String baseFileNameVaksin = p.basename(fileVaksin.path);
      log('file name $baseFileNameVaksin');
      multipartRequest.files
          .add(await MultipartFile.fromPath('vaksin_file', _pathFileVaksin!));
    }

    Map<String, String> headers = {
      "Authorization": token,
    };
    multipartRequest.headers.addAll(headers);

    return _apiHelper.sendMultipartRequest(multipartRequest);
  }
}
