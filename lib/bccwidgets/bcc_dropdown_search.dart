import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class BccDropdownSearch extends StatelessWidget {
  const BccDropdownSearch(
      {super.key,
      this.asyncItems,
      this.onChange,
      this.itemAsString,
      this.hint});

  final Future<List<dynamic>> Function(String)? asyncItems;
  final Function(dynamic)? onChange;
  final String Function(dynamic)? itemAsString;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 2, bottom: 2),
      margin: const EdgeInsets.only(top: 10, bottom: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.75),
          borderRadius: BorderRadius.circular(10.0)),
      child: DropdownSearch<dynamic>(
        popupProps: PopupProps.menu(
            showSearchBox: true,
            searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
              hintText: 'Cari',
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.all(10.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: const BorderSide(width: 0.05)),
            ))),
        asyncItems: asyncItems,
        itemAsString: itemAsString,
        onChanged: onChange,
        dropdownDecoratorProps: DropDownDecoratorProps(
          textAlign: TextAlign.center,
          dropdownSearchDecoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
              alignLabelWithHint: true,
              floatingLabelAlignment: FloatingLabelAlignment.start,
              hintText: hint),
        ),
      ),
    );
  }
}
