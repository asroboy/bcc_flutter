import 'package:flutter/material.dart';

class RowData extends StatefulWidget {
  const RowData(
      {super.key, required this.label, required this.value, this.padding});

  final String label;
  final String value;
  final EdgeInsets? padding;
  @override
  State<RowData> createState() => _RowDataState();
}

class _RowDataState extends State<RowData> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          Flexible(
            child: Text(
              widget.value,
              textAlign: TextAlign.right,
            ),
          )
        ],
      ),
    );
  }
}
