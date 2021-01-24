import 'package:better_forms/validators/validators.dart';

enum ValidationState {
  valid,
  invalid,
  not_evaluated,
}

class Validation {
  List<ValidationFunction> validators;
  ValidationState state;
  String message;

  Validation({
    this.state,
    this.message,
    this.validators,
  });

  void setValidators(List<ValidationFunction> validators) {
    this.validators = validators;
  }
}
