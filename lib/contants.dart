import 'package:flutter/material.dart';

class Constants {
  static String serverDev = 'http://bogorcareercenter.indoaksesmedia.my.id';
  static String serverProd = 'https://bogorcareercenter.bogorkab.go.id/';

  static String host = '$serverDev/api/';
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

  static String pathLandingCompany = 'Comp';
  static String pathComp = 'jobseeker/Comp';
  static String pathJobboard = 'jobseeker/jobboard';
  static String pathWishList = 'jobseeker/wishlist';
  static String pathRiwayatLamaran = 'jobseeker/application';
  static String pathAjukanLamaran = 'admin/company_job_application';
  static String pathPersonalia = 'company/candidate/employee';
  static String pathJobInterview = 'admin/company_job_interview';
  static String pathSimpanInterview = 'company/application/interview';

//PERUSAHAAN
  static String pathProfilPerusahaan = 'admin/company/';
  static String pathUbahPasswordPerusahaan = 'admin/company/change_password/';
  static String pathAlamatPerusahaan = 'admin/company_address';
  static String pathAlamatPrimary = 'admin/company_address/is_primary';
  // /api/admin/company_address/880
  static String pathCompanyJob =
      'admin/company_job'; //??orderBy=id&sort=desc&limit=50&page=1&company_id=id_co

//master data pendukung
  static String pathMasterCompanySize = 'admin/master_company_size';
  static String pathMasterIndustry = 'admin/master_industry';
  static String pathCompanyLegality = 'admin/company_legality';
  static String pathLowongan = 'admin/company_job';
  static String pathMasterEmplymentType =
      'admin/master_employment_type?type=BCC';
  static String pathMasterLevelPerkerjaan = 'admin/master_job_level?type=BCC';

  static Color boxColorBlueTrans = const Color(0x236fb6f7);
  static Color colorBiruGelap = const Color(0xFF003673);
  static Color colorBiruMuda = const Color.fromARGB(255, 24, 77, 138);
  static Color colorGrey = const Color.fromARGB(255, 162, 162, 162);

  static String userType = 'user-type';
  static String loginInfo = 'login-info';
  static String userPencaker = 'pencaker';
  static String userPerusahaan = 'perusahaan';
  static String infoEmailNotVerified =
      'Email Kamu belum diverifikasi, silahkan verifikasi email Kamu untuk menggunakan semua fitur';
  static String infoEmailNotVerified2 =
      'silahkan verifikasi email Kamu untuk menggunakan semua fitur';
}
