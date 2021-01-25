import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_forms/cubit/form_cubit.dart';
import 'package:provider/provider.dart';
import 'package:better_forms/cubit/types.dart';
import 'package:better_forms/form/types/types.dart';
import 'package:better_forms/validators/validators.dart';

class BFCheckbox extends StatefulWidget implements IBFFormField {
  final Widget checkboxText;
  final String name;
  final List<ValidationFunction> validators;
  final bool isTextTappable;

  BFCheckbox({
    @required this.name,
    this.validators = const [],
    this.isTextTappable = true,
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
    return BlocBuilder<BFFormCubit, BFFormCubitState>(
      builder: (ctx, state) => Column(
        children: [
          Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                value: this.value,
                onChanged: (value) => _onChanged(value, ctx),
              ),
              Flexible(
                child: widget.isTextTappable
                    ? _buildTextWithGestureDetector(ctx)
                    : _buildTextWithoutGestureDetector(),
              ),
            ],
          ),
          if (state.fields[widget.name].state.state == ValidationState.invalid)
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  state.fields[widget.name].state.message,
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ))
        ],
      ),
    );
  }

  Widget _buildTextWithGestureDetector(BuildContext ctx) {
    return GestureDetector(
      onTap: () => _onChanged(!this.value, ctx),
      child: widget.checkboxText,
    );
  }

  Widget _buildTextWithoutGestureDetector() {
    return widget.checkboxText;
  }

  void _onChanged(bool newValue, BuildContext context) {
    Validation validation;
    if (widget.validators == null || widget.validators.length == 0) {
      validation = Validation(
        state: ValidationState.valid,
      );
    } else {
      for (var validator in widget.validators) {
        var v = validator(newValue.toString());
        if (v.state == ValidationState.invalid) {
          validation = v;
          break;
        } else {
          validation = Validation(state: ValidationState.valid);
        }
      }
    }
    context
        .read<BFFormCubit>()
        .updateField(widget.name, newValue.toString(), validation);
    setState(() {
      this.value = newValue;
    });
  }
}
