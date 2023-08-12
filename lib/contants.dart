import 'package:flutter/material.dart';

class Constants {
  static String host = 'https://bogorcareercenter.bogorkab.go.id/api/';
  static String pathLoginPencaker = 'jobseeker/auth';
  static String pathLoginPerusahaan = 'company/auth';
  static String pathProvinsi = 'admin/master_province';
  static String pathKota = 'admin/master_city';
  static String pathKecamatan = 'admin/master_district';
  static String pathDesa = 'admin//master_village';
  static String pathDisable = 'admin/master_disability';
  static String pathSekolah = 'admin/master_school';
  static String pathPendidikanTerakhir = 'admin/master_degree';
  static String pathJurusanSekolah = 'admin/master_major';
  static String pathDaftarPencaker = 'jobseeker/auth/registration';
  static String pathPendidiksnPencaker = 'admin/jobseeker_education';
  static String pathPengalamanBekerja = 'admin/jobseeker_experience';
  static String pathSertifikatPencker = 'admin/jobseeker_certificate';
  static String pathTipePegawai = 'admin/master_employment_type';
  static String pathCompany = 'admin/company';
  static String pathDataPencaker = 'admin/jobseeker';
  static String pathDataMasterSkill = 'admin/master_skill';
  static String pathDataJobseekerSkill = 'admin/jobseeker_skill';

  static Color boxColorBlueTrans = const Color(0x236fb6f7);
  static Color colorBiruGelap = const Color(0xFF003673);
  static Color colorGrey = const Color.fromARGB(255, 162, 162, 162);

  static String userType = 'user-type';
  static String loginInfo = 'login-info';
  static String userPencaker = 'pencaker';
  static String userPerusahaan = 'perusahaan';
}
