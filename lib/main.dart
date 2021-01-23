import 'package:flutter/material.dart';
import 'package:form_framework/form/form.dart';
import 'package:form_framework/form/form_checkbox.dart';
import 'package:form_framework/form/form_date_picker.dart';
import 'package:form_framework/form/form_dropdown.dart';
import 'package:form_framework/form/form_field.dart';
import 'package:form_framework/form/form_group.dart';

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
                title: "Contact",
                fields: [
                  BFFormField(hintText: "Email"),
                  BFFormGroup(
                    fields: [
                      BFFormField(hintText: "Surname"),
                      BFFormField(hintText: "Second Surname"),
                      BFFormField(hintText: "Another Surname"),
                      BFDropdown<String>(
                        items: ["One", "Two"],
                        initialValue: "One",
                      ),
                      BFDatePicker(
                        dateFormat: "dd-MM-yyyy",
                        initialDate: DateTime.now(),
                        startingDate: DateTime.now().subtract(
                          Duration(days: 365),
                        ),
                        endDate: DateTime.now().add(Duration(days: 3600)),
                      ),
                      BFDropdown<String>(
                        items: ["One", "Two"],
                        initialValue: "One",
                      ),
                      BFFormField(hintText: "Surname"),
                      BFFormField(hintText: "Second Surname"),
                      BFFormField(hintText: "Another Surname"),
                    ],
                  ),
                  BFCheckbox(),
                  BFDatePicker(
                    initialDate: DateTime.now(),
                    startingDate: DateTime.now().subtract(
                      Duration(days: 365),
                    ),
                    endDate: DateTime.now().add(Duration(days: 3650)),
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
