import 'package:bcc/bccwidgets/bcc_text_form_field_input.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UbahJadwalDialog extends StatefulWidget {
  const UbahJadwalDialog(
      {super.key, required this.jadwal, required this.onSave});

  final dynamic jadwal;
  final Function(dynamic) onSave;

  @override
  State<UbahJadwalDialog> createState() => _UbahJadwalDialogState();
}

class _UbahJadwalDialogState extends State<UbahJadwalDialog> {
  String? ubahTanggalJadwal, ubahTanggalFormat;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    String tanggalJadwal = DateFormat('dd MMMM yyyy')
        .format(DateFormat('yyyy-MM-dd').parse(widget.jadwal['schedule_date']));
    ubahTanggalJadwal = tanggalJadwal;
    ubahTanggalFormat = widget.jadwal['schedule_date'];
    _controller.text = widget.jadwal['description'];
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ubah Jadwal Interview'),
      content: SizedBox(
        height: 220,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(ubahTanggalJadwal ?? ''),
                    ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                                  context: context,
                                  initialDate: ubahTanggalFormat != null
                                      ? DateFormat('yyyy-MM-dd')
                                          .parse(ubahTanggalFormat ?? '')
                                      : DateTime.now(),
                                  firstDate: DateTime(DateTime.now().year - 5),
                                  lastDate: DateTime(DateTime.now().year + 5))
                              .then((value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
                              ubahTanggalFormat =
                                  DateFormat('yyyy-MM-dd').format(value);
                              ubahTanggalJadwal =
                                  DateFormat('dd MMMM yyyy').format(value);
                            });
                          });
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_month),
                          ],
                        )),
                  ],
                )),
            BccTextFormFieldInput(
              textInputType: TextInputType.multiline,
              hint: 'Catatan Detail',
              readOnly: false,
              controller: _controller,
              padding: const EdgeInsets.only(top: 5, bottom: 10),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            widget.onSave({
              'schedule_date': ubahTanggalFormat,
              'description': _controller.text
            });
          },
          style: ElevatedButton.styleFrom(),
          child: const Text('Simpan'),
        ),
      ],
    );
  }
}
