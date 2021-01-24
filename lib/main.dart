import 'package:flutter/material.dart';
import 'package:form_framework/form/form.dart';
import 'package:form_framework/form/form_checkbox.dart';
import 'package:form_framework/form/form_date_picker.dart';
import 'package:form_framework/form/form_dropdown.dart';
import 'package:form_framework/form/form_field.dart';
import 'package:form_framework/form/form_group.dart';
import 'package:form_framework/utils/fonts.dart';
import 'package:form_framework/validators/validators.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BFForm(
                onSubmit: (map) =>
                    {if (map == null) print("Cannot post") else print(map)},
                title: Text(
                  "Contact",
                  style: TextStyle(
                    fontSize: Fonts.xlFont,
                  ),
                ),
                fields: [
                  BFFormField(
                    validators: [
                      Validators.isANumber,
                    ],
                    title: "Nombre",
                    name: "name",
                  ),
                  BFFormGroup(
                    fields: [
                      BFFormField(
                        validators: [
                          Validators.isANumber,
                        ],
                        name: "surname",
                        title: "Primer apellido",
                      ),
                      BFFormField(
                        validators: [
                          Validators.isANumber,
                        ],
                        title: "Segundo apellido",
                        name: "second_surname",
                      ),
                      BFDropdown<int>(
                        hint: "Tipo de documento",
                        name: "birth_date",
                        items: [
                          BFDropdownItem(value: 1, displayValue: "DNI"),
                          BFDropdownItem(value: 2, displayValue: "Pasaporte"),
                          BFDropdownItem(
                              value: 3, displayValue: "Tarjeta de refugiado"),
                        ],
                      ),
                      BFFormField(
                        title: "Documento",
                        name: "document",
                      ),
                      BFFormField(
                        validators: [
                          Validators.isANumber,
                        ],
                        title: "Teléfono",
                        name: "phone",
                      ),
                      BFDatePicker(
                        placeholder: "Fecha de nacimiento",
                        name: "birthdate",
                        dateFormat: "dd-MM-yyyy",
                        initialDate: DateTime.now(),
                        startingDate: DateTime.now().subtract(
                          Duration(days: 365),
                        ),
                        endDate: DateTime.now().add(Duration(days: 3600)),
                      ),
                      BFFormField(
                        name: "direccion",
                        title: "Dirección",
                      ),
                    ],
                  ),
                  BFFormGroup(
                    fields: [
                      BFFormField(name: "city", title: "Ciudad"),
                      BFDropdown<int>(
                        hint: "Género",
                        items: [
                          BFDropdownItem(value: 1, displayValue: "Femenino"),
                          BFDropdownItem(value: 2, displayValue: "Masculino"),
                        ],
                        name: "gender",
                      ),
                    ],
                  ),
                  BFDropdown<int>(
                      hint: "Selecciona un país",
                      items: [
                        BFDropdownItem(value: 1, displayValue: "España"),
                        BFDropdownItem(value: 2, displayValue: "Fracia"),
                        BFDropdownItem(value: 3, displayValue: "Alemania"),
                      ],
                      name: "country"),
                  BFFormGroup(
                    columns: 1,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                      ),
                      child: Text(
                        "Cuenta de usuario",
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 136),
                          fontSize: Fonts.bigFont,
                        ),
                      ),
                    ),
                    fields: [
                      BFFormField(
                        name: "email",
                        title: "Email",
                      ),
                      BFFormField(
                        isPassword: true,
                        name: "password",
                        title: "Contraseña",
                      ),
                    ],
                  ),
                  BFCheckbox(
                    validators: [Validators.isTrue],
                    name: "term_and_conditions",
                    checkboxText: Text(
                        "By checking this box you agree with our terms and conditions."),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _buildContainer(Color color) {
  return Container(
    width: 50,
    height: 50,
    color: color,
  );
}
