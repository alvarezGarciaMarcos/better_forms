import 'package:better_forms/form/form.dart';
import 'package:better_forms/form/form_date_picker.dart';
import 'package:better_forms/form/form_dropdown.dart';
import 'package:better_forms/form/form_field.dart';
import 'package:better_forms/form/form_group.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyForm(),
    );
  }
}

class MyForm extends StatelessWidget {
  void _onSubmit(Map<String, String> map) {
    print(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: BFForm(
            title: Text(
              "Personal info",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            onSubmit: _onSubmit,
            fields: [
              BFFormField(
                name: "name",
                title: "Name",
              ),
              BFFormGroup(
                fields: [
                  BFFormField(
                    name: "surname",
                    title: "First surname",
                  ),
                  BFFormField(
                    name: "surname",
                    title: "Second surname",
                  ),
                  BFDropdown(
                    flex: 1,
                    items: [
                      BFDropdownItem<String>(value: "+34", displayValue: "+34"),
                      BFDropdownItem<String>(value: "+90", displayValue: "+90")
                    ],
                    name: "prefix",
                  ),
                  BFFormField(
                    flex: 3,
                    name: "phone",
                    title: "Phone",
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
