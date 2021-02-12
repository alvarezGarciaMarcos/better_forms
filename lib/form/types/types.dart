import 'package:flutter/widgets.dart';
import 'package:better_forms/validators/validators.dart';

import '../form.dart';

abstract class IBFFormField extends Widget {
  String get name;
  int get flex;
  List<ValidationFunction> get validators;
}

typedef BFButtonOnPressed = void Function(BuildContext);

abstract class IBFButton extends Widget {
  BFButtonOnPressed onFormSubmit;
}
