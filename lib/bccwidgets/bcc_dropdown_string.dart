import 'package:flutter/material.dart';

class BccDropDownString extends StatelessWidget {
  const BccDropDownString(
      {super.key,
      required this.data,
      required this.onChanged,
      this.hint,
      this.value});

  final List<String> data;
  final Widget? hint;
  final String? value;
  final Function(String?)? onChanged;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButton<String>(
                hint: hint,
                isExpanded: true,
                isDense: true,
                value: value,
                underline: const SizedBox(),
                alignment: Alignment.topLeft,
                items: data.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      textAlign: TextAlign.start,
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              )
            ]));
  }
}
