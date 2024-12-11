import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class RowData extends StatefulWidget {
  const RowData(
      {super.key,
      required this.label,
      required this.value,
      this.padding,
      this.isHtml});

  final String label;
  final String value;
  final EdgeInsets? padding;
  final bool? isHtml;

  @override
  State<RowData> createState() => _RowDataState();
}

class _RowDataState extends State<RowData> {
  @override
  Widget build(BuildContext context) {
    bool misHtml = widget.isHtml ?? false;
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
            child: misHtml
                ? Html(data: widget.value, style: {
                    // tables will have the below background color
                    "p": Style(
                      textAlign: TextAlign.end,
                    ),
                  })
                : Text(
                    widget.value,
                    textAlign: TextAlign.right,
                  ),
          )
        ],
      ),
    );
  }
}
