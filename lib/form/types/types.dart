import 'package:flutter/widgets.dart';
import 'package:better_forms/validators/validators.dart';

abstract class IBFFormField extends Widget {
  String get name;
  List<ValidationFunction> get validators;
}
