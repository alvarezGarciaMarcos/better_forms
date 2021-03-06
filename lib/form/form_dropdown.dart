import 'package:better_forms/cubit/form_cubit.dart';
import 'package:better_forms/cubit/types.dart';
import 'package:flutter/material.dart';
import 'package:better_forms/form/types/types.dart';
import 'package:better_forms/validators/validators.dart';
import 'package:provider/provider.dart';

class BFDropdownItem<T> {
  T value;
  String displayValue;

  BFDropdownItem({
    @required this.displayValue,
    @required this.value,
  });
}

class BFDropdown<T> extends StatefulWidget implements IBFFormField {
  final List<BFDropdownItem<T>> items;
  final T initialValue;
  final String name;
  final String hint;
  final int flex;
  final List<ValidationFunction> validators = [];

  BFDropdown({
    @required this.items,
    @required this.name,
    this.hint = "Make a selection",
    this.initialValue,
    this.flex = 1,
  });

  @override
  State<StatefulWidget> createState() {
    return _BFDropdownState<T>();
  }
}

class _BFDropdownState<T> extends State<BFDropdown> {
  T value;

  @override
  void initState() {
    super.initState();
    this.value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          padding: EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              width: 2,
              color: Colors.black,
            ),
          ),
          width: MediaQuery.of(context).size.width,
          child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
            hint: Text(widget.hint),
            isExpanded: true,
            value: value,
            style: TextStyle(
              color: Colors.black,
            ),
            onChanged: (newValue) => this._onChanged(newValue, context),
            items: widget.items.map((value) {
              return DropdownMenuItem<T>(
                value: value.value,
                child: Text(
                  value.displayValue.toString(),
                  overflow: TextOverflow.fade,
                ),
              );
            }).toList(),
          )),
        ),
        SizedBox(
          height: 5,
        ),
      ],
    );
  }

  void _onChanged(T newValue, BuildContext context) {
    context.read<BFFormCubit>().updateField(
        widget.name,
        newValue.toString(),
        Validation(
          state: ValidationState.valid,
        ));
    setState(() {
      value = newValue;
    });
  }
}
