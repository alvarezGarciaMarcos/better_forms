import 'package:better_forms/cubit/form_cubit.dart';
import 'package:better_forms/cubit/types.dart';
import 'package:flutter/material.dart';
import 'package:better_forms/form/types/types.dart';
import 'package:better_forms/validators/validators.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BFDatePicker extends StatefulWidget implements IBFFormField {
  final DateTime initialDate;
  final DateTime startingDate;
  final DateTime endDate;
  final String helpText;
  final String placeholder;
  final String dateFormat;
  final void Function() onCancel;
  final String name;
  final int flex;
  final List<ValidationFunction> validators = [];

  BFDatePicker({
    @required this.initialDate,
    @required this.startingDate,
    @required this.endDate,
    @required this.name,
    this.helpText,
    this.placeholder = "Pick a date",
    this.dateFormat = "yyyy-MM-dd",
    this.onCancel,
    this.flex = 1,
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
    this.value = widget.placeholder;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onDatePickerTapped(context),
      child: Container(
        alignment: Alignment.centerLeft,
        child: InkWell(
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: widget.placeholder,
              enabled: true,
            ),
            child: Container(
              padding: EdgeInsets.only(
                top: 8,
              ),
              height: 30,
              child: Text(
                this.value,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onDatePickerTapped(BuildContext context) async {
    DateTime datetime = await showDatePicker(
      context: context,
      initialDate: widget.initialDate,
      firstDate: widget.startingDate,
      lastDate: widget.endDate,
      helpText: widget.helpText,
    );

    if (datetime != null) {
      var timeString = DateFormat(widget.dateFormat).format(datetime);
      context.read<BFFormCubit>().updateField(
          widget.name,
          timeString,
          Validation(
            state: ValidationState.valid,
          ));
      setState(() {
        this.value = timeString;
      });
    } else if (widget.onCancel != null) {
      widget.onCancel();
    }
  }
}
