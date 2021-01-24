import 'package:flutter/widgets.dart';
import 'package:form_framework/validators/validators.dart';

abstract class IBFFormField extends Widget {
  String get name;
  List<ValidationFunction> get validators;
}
