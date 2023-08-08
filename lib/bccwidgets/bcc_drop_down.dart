import 'package:flutter/material.dart';

class BccDropDown extends StatelessWidget {
  const BccDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.only(left: 15, right: 15),
        margin: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black54, width: 1),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton(
              isExpanded: true,
              isDense: true,
              underline: const SizedBox(),
              alignment: Alignment.center,
              value: '-',
              items: const [
                DropdownMenuItem(
                  value: '-',
                  child: Center(
                      child: Text(
                    '-',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                DropdownMenuItem(
                  value: 'Pencari Kerja',
                  child: Center(
                      child: Text(
                    'Pencari Kerja',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
                DropdownMenuItem(
                  value: 'Perusahaan',
                  child: Center(
                      child: Text(
                    'Perusahaan',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                )
              ],
              onChanged: (Object? value) {},
            )
          ],
        ));
  }
}
