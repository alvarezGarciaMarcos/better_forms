import 'package:flutter/material.dart';
import 'package:form_framework/form/types/types.dart';

class BFCheckbox extends StatefulWidget implements IBFFormField {
  final Text checkboxText;

  BFCheckbox({
    this.checkboxText = const Text(
      "This is some complex text. Lorem impsum et emet oh baby oh baby why keep it spinning",
    ),
  });

  @override
  State<StatefulWidget> createState() {
    return _BFCheckboxState();
  }
}

class _BFCheckboxState extends State<BFCheckbox> {
  bool value;

  @override
  void initState() {
    super.initState();
    this.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          activeColor: Theme.of(context).primaryColor,
          value: this.value,
          onChanged: _onChanged,
        ),
        Flexible(
          child: GestureDetector(
            onTap: () => _onChanged(!this.value),
            child: widget.checkboxText,
          ),
        ),
      ],
    );
  }

  void _onChanged(bool newValue) {
    setState(() {
      this.value = newValue;
    });
  }
}
