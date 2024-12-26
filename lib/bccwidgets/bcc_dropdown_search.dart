import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class BccDropdownSearch extends StatelessWidget {
  const BccDropdownSearch(
      {super.key,
      this.items,
      this.asyncItems,
      required this.onChange,
      this.onSaved,
      this.itemAsString,
      this.selectedItem,
      this.keyName,
      this.hint});
  final List<dynamic>? items;
  final Future<List<dynamic>> Function(String)? asyncItems;
  final Function(dynamic) onChange;
  final Function(dynamic)? onSaved;
  final String Function(dynamic)? itemAsString;
  final String? hint;
  final dynamic selectedItem;
  final String? keyName;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<dynamic>(
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      items: (f, cs) => items ?? [],
      compareFn: (item1, item2) {
        return item1 == item2;
      },
      onSaved: onSaved,
      onChanged: onChange,
      itemAsString: (item) => item[keyName ?? 'name'],
      selectedItem: selectedItem,
      popupProps: PopupProps.menu(
        showSearchBox: true,
        fit: FlexFit.loose,
        searchFieldProps: TextFieldProps(
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.all(10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(width: 0.15)),
          ),
        ),
        itemBuilder: (context, item, isDisabled, isSelected) => ListTile(
          title: Text(item[keyName ?? 'name']),
        ),
      ),
    );

    // Container(
    //   padding: const EdgeInsets.only(left: 15, right: 5, top: 2, bottom: 2),
    //   margin: const EdgeInsets.only(top: 10, bottom: 5),
    //   decoration: BoxDecoration(
    //       color: Colors.white,
    //       border: Border.all(width: 0.75),
    //       borderRadius: BorderRadius.circular(10.0)),
    //   child: DropdownSearch<dynamic>(
    //     compareFn: (item1, item2) {
    //       return item1 == item2;
    //     },

    //     popupProps: PopupProps.menu(
    //       showSearchBox: true,
    //       searchFieldProps: TextFieldProps(
    //         decoration: InputDecoration(
    //           hintText: 'Cari',
    //           filled: true,
    //           fillColor: Colors.white,
    //           contentPadding: const EdgeInsets.all(10.0),
    //           border: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(10.0),
    //               borderSide: const BorderSide(width: 0.15)),
    //         ),
    //       ),
    //       itemBuilder: (context, item, isDisabled, isSelected) => ListTile(
    //         title: Text(itemAsString!(item)),
    //       ),
    //     ),
    //     // asyncItems: asyncItems,
    //     itemAsString: itemAsString,
    //     selectedItem: selectedItem,
    //     onChanged: onChange,
    //     // dropdownDecoratorProps: DropDownDecoratorProps(
    //     //   textAlign: TextAlign.start,
    //     //   dropdownSearchDecoration: InputDecoration(
    //     //       focusedBorder: const UnderlineInputBorder(
    //     //           borderSide: BorderSide(color: Colors.white)),
    //     //       enabledBorder: const UnderlineInputBorder(
    //     //           borderSide: BorderSide(color: Colors.white)),
    //     //       alignLabelWithHint: true,
    //     //       floatingLabelAlignment: FloatingLabelAlignment.start,
    //     //       hintText: hint),
    //     // ),
    //   ),
    // );
  }
}
