import 'package:flutter/material.dart';
import 'package:form_framework/form/types/types.dart';
import 'package:intl/intl.dart';

class BFDatePicker extends StatefulWidget implements IBFFormField {
  final DateTime initialDate;
  final DateTime startingDate;
  final DateTime endDate;
  final String helpText;
  final String placeholder;
  final String dateFormat;
  final void Function() onCancel;

  BFDatePicker({
    @required this.initialDate,
    @required this.startingDate,
    @required this.endDate,
    this.helpText,
    this.placeholder = "Pick a date",
    this.dateFormat = "yyyy-MM-dd",
    this.onCancel,
  });

  @override
  State<StatefulWidget> createState() {
    return _BFDatePickerState();
  }
}

class _BFDatePickerState extends State<BFDatePicker> {
  String value;

  @override
  void initState() {
    super.initState();
    this.value = "Pick a date";
  }

  @override
  Widget build(BuildContext context) {
    var fullWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: _onDatePickerTapped,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 2,
            color: Colors.grey,
          ),
        ),
        width: fullWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(this.value),
          ],
        ),
      ),
    );
  }

  void _onDatePickerTapped() async {
    DateTime datetime = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: widget.startingDate,
      lastDate: widget.endDate,
      helpText: widget.helpText,
    );

    if (datetime != null) {
      setState(() {
        this.value = DateFormat('yyyy-MM-dd').format(datetime);
      });
    } else if (widget.onCancel != null) {
      widget.onCancel();
    }
  }
}
