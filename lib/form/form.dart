import 'package:flutter/widgets.dart';
import 'package:form_framework/form/form_button.dart';
import 'package:form_framework/form/types/types.dart';
import 'package:form_framework/utils/fonts.dart';

class BFForm extends StatelessWidget {
  final List<IBFFormField> fields;
  final String title;

  BFForm({
    this.fields,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    var elements = fields
        .map((e) => Container(
              padding: EdgeInsets.all(8.0),
              child: e,
            ))
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          if (this.title != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  this.title,
                  style: TextStyle(
                    fontSize: Fonts.xlFont,
                  ),
                ),
              ],
            ),
          ...elements,
          SizedBox(
            height: 20,
          ),
          BFButton(),
        ],
      ),
    );
  }
}
