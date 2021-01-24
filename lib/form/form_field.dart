import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_framework/cubit/form_cubit.dart';
import 'package:form_framework/cubit/types.dart';
import 'package:form_framework/form/types/types.dart';
import 'package:form_framework/validators/validators.dart';

class BFFormField extends StatefulWidget implements IBFFormField {
  final String title;
  final String name;
  final List<ValidationFunction> validators;
  final bool isPassword;

  BFFormField({
    @required this.name,
    this.title,
    this.validators = const [],
    this.isPassword = false,
  });

  @override
  State<StatefulWidget> createState() {
    return _BFFormFieldState();
  }
}

class _BFFormFieldState extends State<BFFormField> {
  @override
  void initState() {
    super.initState();
    context
        .read<BFFormCubit>()
        .registerValidators(widget.name, widget.validators);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BFFormCubit, BFFormCubitState>(
        builder: (ctx, state) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputDecorator(
                  decoration:
                      InputDecoration(labelText: widget.title, enabled: true),
                  child: Container(
                    height: 30,
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      obscureText: widget.isPassword,
                      onChanged: (newValue) => _onTextChanged(
                        context,
                        newValue,
                        widget.name,
                        widget.validators,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: (state.fields.containsKey(widget.name) &&
                            state.fields[widget.name].state.state ==
                                ValidationState.invalid)
                        ? Text(state.fields[widget.name].state.message,
                            style: TextStyle(
                              color: Colors.red,
                            ))
                        : null)
              ],
            ));
  }
}

void _onTextChanged(BuildContext context, String newValue, String name,
    List<ValidationFunction> validators) {
  Validation validation;
  if (validators.isNotEmpty) {
    for (var eval in validators) {
      validation = eval(newValue);

      if (validation.state == ValidationState.invalid) {
        break;
      }
    }
  } else {
    validation = Validation(state: ValidationState.valid);
  }
  context.read<BFFormCubit>().updateField(name, newValue, validation);
}

Validation validate() {}
