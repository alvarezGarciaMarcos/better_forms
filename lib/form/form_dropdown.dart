import 'package:flutter/material.dart';
import 'package:form_framework/form/types/types.dart';

class BFDropdown<T> extends StatefulWidget implements IBFFormField {
  final List<T> items;
  final T initialValue;

  BFDropdown({
    @required this.items,
    @required this.initialValue,
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
              )),
          width: MediaQuery.of(context).size.width,
          child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
            isExpanded: true,
            value: value,
            style: TextStyle(
              color: Colors.black,
            ),
            onChanged: (T newValue) {
              setState(() {
                value = newValue;
              });
            },
            items: widget.items.map((value) {
              return DropdownMenuItem<T>(
                value: value,
                child: Text(
                  value.toString(),
                  overflow: TextOverflow.fade,
                ),
              );
            }).toList(),
          )),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          "This is an error",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
