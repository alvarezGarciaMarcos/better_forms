import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_forms/cubit/form_cubit.dart';
import 'package:better_forms/form/form_button.dart';
import 'package:better_forms/form/types/types.dart';

typedef OnBFFormSubmitted = void Function(Map<String, String>);

/// Class in charge of registering all the fields of the [BFForm]
/// to be registered on the [BFFormCubit]
///
class _BFFieldRegister extends StatefulWidget {
  final Widget child;
  final List<IBFFormField> fields;

  _BFFieldRegister({
    @required this.child,
    @required this.fields,
  });
  @override
  State<StatefulWidget> createState() {
    return _BFFieldRegisterState();
  }
}

class _BFFieldRegisterState extends State<_BFFieldRegister> {
  @override
  void initState() {
    super.initState();
    for (IBFFormField field in widget.fields) {
      context.read<BFFormCubit>().registerField(
            field.name,
            field.validators,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Class in charge of providing the [BFFormCubit] to the [BFForm] and all its children
class _BFFormCubitProvider extends StatelessWidget {
  final Widget child;

  _BFFormCubitProvider({
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => BFFormCubit(),
      child: this.child,
    );
  }
}

class BFForm extends StatefulWidget {
  final List<IBFFormField> fields;
  final Widget title;
  final OnBFFormSubmitted onSubmit;
  final String buttonText;
  final Color buttonColor;
  final Color fontColor;
  final IBFButton button;

  BFForm({
    this.fields,
    this.title,
    this.onSubmit,
    this.buttonText = "Submit",
    this.buttonColor = Colors.red,
    this.fontColor = Colors.white,
    this.button,
  });
  @override
  State<StatefulWidget> createState() {
    return _BFFormState();
  }
}

class _BFFormState extends State<BFForm> {
  /// Function passed to the button implementing [IBFButton] to be executed on form submission
  void _onFormSubmission(BuildContext context) {
    var map = context.read<BFFormCubit>().validate();
    widget.onSubmit(map);
  }

  @override
  Widget build(BuildContext context) {
    var elements = widget.fields
        .map((e) => Container(
              padding: EdgeInsets.all(2.0),
              child: e,
            ))
        .toList();

    return _BFFormCubitProvider(
      child: _BFFieldRegister(
        fields: widget.fields,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              if (widget.title != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    widget.title,
                  ],
                ),
              ...elements,
              SizedBox(
                height: 20,
              ),
              (widget.button != null)
                  ? _buildUserButton()
                  : _buildDefaultButton()
            ],
          ),
        ),
      ),
    );
  }

  /// Creates the [IBFButton] provided by the user and
  /// assigns its [BFButtonOnPressed] callback
  Widget _buildUserButton() {
    widget.button.onFormSubmit = _onFormSubmission;
    return widget.button;
  }

  /// Creates the default [IBFButton] if no one has been provided by the user
  Widget _buildDefaultButton() {
    return BFButton(
      color: widget.buttonColor,
      fontText: widget.fontColor,
      text: widget.buttonText,
      onPressed: (ctx) => _onFormSubmission(ctx),
    );
  }
}
