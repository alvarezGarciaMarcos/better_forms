import 'package:flutter/material.dart';
import 'package:form_framework/form/types/types.dart';

class BFFormField extends StatefulWidget implements IBFFormField {
  final String hintText;

  BFFormField({
    this.hintText,
  });

  @override
  State<StatefulWidget> createState() {
    return _BFFormFieldState();
  }
}

class _BFFormFieldState extends State<BFFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: widget.hintText,
          ),
        ),
        SizedBox(
          height: 15,
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
