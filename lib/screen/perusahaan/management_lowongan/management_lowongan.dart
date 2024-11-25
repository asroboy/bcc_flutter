import 'package:bcc/screen/perusahaan/management_lowongan/tambah_lowongan.dart';
import 'package:flutter/material.dart';

class ManagementLowongan extends StatefulWidget {
  const ManagementLowongan({super.key});

  @override
  State<ManagementLowongan> createState() => _ManagementLowonganState();
}

class _ManagementLowonganState extends State<ManagementLowongan> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Management Lowongan',
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const TambahLowongan(),
          ));
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(children: const [Text('OK')]),
      ),
    );
  }
}
