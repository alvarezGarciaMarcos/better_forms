import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:better_forms/cubit/types.dart';
import 'package:better_forms/validators/validators.dart';

class BFFieldState {
  String value;
  Validation state;

  BFFieldState({
    this.value,
    this.state,
  });
}

class BFFormCubitState {
  Validation formValidation;
  Map<String, BFFieldState> fields;

  BFFormCubitState({
    this.formValidation,
    this.fields,
  });
}

class BFFormCubit extends Cubit<BFFormCubitState> {
  BFFormCubit()
      : super(
          BFFormCubitState(
            fields: {},
            formValidation: Validation(
              state: ValidationState.invalid,
            ),
          ),
        );

  void updateField(String fieldName, String newValue, Validation validation) {
    BFFormCubitState newState;
    validation.setValidators(state.fields[fieldName].state.validators);
    if (state.fields.containsKey(fieldName)) {
      state.fields.update(fieldName,
          (value) => BFFieldState(state: validation, value: newValue));
    } else {
      state.fields.putIfAbsent(
          fieldName,
          () => BFFieldState(
                state: validation,
                value: newValue,
              ));
    }
    // Update the state
    var newFields = _copy(state.fields);
    Validation v = validation.state == ValidationState.invalid
        ? validation
        : state.formValidation;
    newState = BFFormCubitState(
      fields: newFields,
      formValidation: validation,
    );
    emit(newState);
  }

  void registerField(String fieldName, List<ValidationFunction> validators) {
    state.fields.putIfAbsent(
        fieldName,
        () => BFFieldState(
              state: Validation(
                  state: ValidationState.not_evaluated, validators: validators),
            ));
  }

  Map<String, String> validate() {
    Validation validation = _validate();

    if (validation.state == ValidationState.invalid) {
      return null;
    } else {
      return _getValues(state.fields);
    }
  }

  Map<String, BFFieldState> _copy(Map<String, BFFieldState> state) {
    Map<String, BFFieldState> newMap = {};
    state.entries.forEach((e) => newMap.putIfAbsent(e.key, () => e.value));
    return newMap;
  }

  Map<String, String> _getValues(Map<String, BFFieldState> state) {
    Map<String, String> newMap = {};

    state.keys.forEach((e) {
      newMap.putIfAbsent(e, () => state[e].value);
    });

    return newMap;
  }

  Validation _validate() {
    for (var entry in state.fields.entries)
      for (var validator in entry.value.state.validators) {
        Validation validation = validator(entry.value.value);
        if (validation.state == ValidationState.invalid ||
            validation.state == ValidationState.not_evaluated)
          return validation;
      }
    return Validation(state: ValidationState.valid);
  }
}
