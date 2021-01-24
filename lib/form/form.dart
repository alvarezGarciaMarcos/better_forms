import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_framework/cubit/form_cubit.dart';
import 'package:form_framework/form/form_button.dart';
import 'package:form_framework/form/types/types.dart';
import 'package:form_framework/utils/fonts.dart';

typedef OnBFFormSubmitted = void Function(Map<String, String>);

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

class BFForm extends StatelessWidget {
  final List<IBFFormField> fields;
  final Widget title;
  final OnBFFormSubmitted onSubmit;

  BFForm({
    this.fields,
    this.onSubmit,
    this.title,
  });

  void _onFormSubmition(BuildContext context) {
    print("Hello");
    var map = context.read<BFFormCubit>().validate();
    this.onSubmit(map);
  }

  @override
  Widget build(BuildContext context) {
    var elements = fields
        .map((e) => Container(
              padding: EdgeInsets.all(2.0),
              child: e,
            ))
        .toList();

    return _BFFormCubitProvider(
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            if (this.title != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  this.title,
                ],
              ),
            ...elements,
            SizedBox(
              height: 20,
            ),
            BFButton(
              onPressed: (ctx) => _onFormSubmition(ctx),
            ),
          ],
        ),
      ),
    );
  }
}
