import 'package:bcc/screen/perusahaan/profile_perusahaan/alamat_perusahaan.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/badan_hukum_usaha.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/dokumen_perusahaan.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/informasi_akun.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/pic.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/profle_menu_widget.dart';
import 'package:bcc/screen/perusahaan/profile_perusahaan/ubah_password.dart';
import 'package:flutter/material.dart';

class ProfilePerusahaan extends StatefulWidget {
  const ProfilePerusahaan({super.key});

  @override
  State<ProfilePerusahaan> createState() => _ProfilePerusahaanState();
}

class _ProfilePerusahaanState extends State<ProfilePerusahaan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      // leading: IconButton(
      //     onPressed: () => Get.back(),
      //     icon: const Icon(LineAwesomeIcons.angle_left)),
      // title: Text('Profil Perusahaan',
      //     style: Theme.of(context).textTheme.headlineMedium),
      // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.abc))],
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromARGB(255, 209, 208, 208)),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Icon(
                          Icons.assured_workload,
                          size: 45,
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
              const SizedBox(height: 10),
              Text('PT. Perusahaan Saya',
                  style: Theme.of(context).textTheme.headlineSmall),
              Text('Bogor, Jawa Barat',
                  style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),

              SizedBox(
                width: 200,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      side: BorderSide.none,
                      shape: const StadiumBorder()),
                  child: const Text('Edit Profil',
                      style: TextStyle(color: Colors.white)),
                ),
              ),
              const SizedBox(height: 15),
              const Divider(
                endIndent: 10,
                indent: 10,
                thickness: 0.65,
              ),
              const SizedBox(height: 10),

              /// -- MENU
              ProfileMenuWidget(
                  title: "Informasi Akun",
                  icon: Icons.info,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const InformasiAkunPerusahaan(),
                    ));
                  }),
              ProfileMenuWidget(
                  title: "Alamat Perusahaan",
                  icon: Icons.location_on,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AlamatPerusahaan(),
                    ));
                  }),
              ProfileMenuWidget(
                  title: "Identitas PIC",
                  icon: Icons.person,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Pic(),
                    ));
                  }),
              ProfileMenuWidget(
                  title: "Dokumen Perusahaan",
                  icon: Icons.description,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DokumenPerusahaan(),
                    ));
                  }),
              ProfileMenuWidget(
                  title: "Badan Hukum/Usaha",
                  icon: Icons.policy,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const BadanHukumUsaha(),
                    ));
                  }),
              const Divider(
                endIndent: 10,
                indent: 10,
                thickness: 0.65,
              ),
              const SizedBox(height: 10),
              ProfileMenuWidget(
                  title: "Kata Sandi",
                  icon: Icons.password,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UbahPassword(),
                    ));
                  }),
              ProfileMenuWidget(
                  title: "Keluar",
                  icon: Icons.logout,
                  textColor: Colors.red,
                  endIcon: false,
                  onPress: () {
                    // Get.defaultDialog(
                    //   title: "LOGOUT",
                    //   titleStyle: const TextStyle(fontSize: 20),
                    //   content: const Padding(
                    //     padding: EdgeInsets.symmetric(vertical: 15.0),
                    //     child: Text("Are you sure, you want to Logout?"),
                    //   ),
                    //   confirm: Expanded(
                    //     child: ElevatedButton(
                    //       onPressed: () =>
                    //           AuthenticationRepository.instance.logout(),
                    //       style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.redAccent,
                    //           side: BorderSide.none),
                    //       child: const Text("Yes"),
                    //     ),
                    //   ),
                    //   cancel: OutlinedButton(
                    //       onPressed: () => Get.back(), child: const Text("No")),
                    // );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
