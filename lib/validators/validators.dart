import 'package:better_forms/cubit/types.dart';

typedef ValidationFunction = Validation Function(String);

class Validators {
  static Validation isANumber(String value) {
    try {
      int.parse(value);
      return Validation(state: ValidationState.valid);
    } catch (_) {
      return Validation(
          state: ValidationState.invalid,
          message: "The field has to be a number");
    }
  }

  static Validation isTrue(String value) {
    return value == "true"
        ? Validation(state: ValidationState.valid)
        : Validation(
            state: ValidationState.invalid,
            message: "You have to accept the terms an conditions");
  }
}
