import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:flutter/material.dart';

class UbahPassword extends StatefulWidget {
  const UbahPassword({super.key});

  @override
  State<UbahPassword> createState() => _UbahPasswordState();
}

class _UbahPasswordState extends State<UbahPassword> {
  TextEditingController passwordLama = TextEditingController();
  TextEditingController passwordBaru = TextEditingController();
  TextEditingController ulangiPasswordBaru = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Ubah Kata Sandi'),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: Text(
              'Untuk mengubah passwod, silahkan masukkan password lama kamu.',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.normal,
                  fontSize: 14),
            ),
          ),
          BccTextFormFieldInput(
            hint: 'Password lama',
            readOnly: false,
            controller: passwordLama,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 10),
          ),
          BccTextFormFieldInput(
            hint: 'Password baru',
            readOnly: false,
            controller: passwordBaru,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          ),
          BccTextFormFieldInput(
            hint: 'Ulangi password baru',
            readOnly: false,
            controller: ulangiPasswordBaru,
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: const Row(
                      children: [Icon(Icons.save), Text('Simpan')],
                    ))
              ],
            ),
          )
        ]));
  }
}
