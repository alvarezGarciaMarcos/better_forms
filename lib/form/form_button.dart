import 'package:flutter/material.dart';
import 'package:form_framework/utils/fonts.dart';

typedef BFButtonOnPressed = void Function(BuildContext);

class BFButton extends StatelessWidget {
  final BFButtonOnPressed onPressed;
  final String text;

  BFButton({
    this.onPressed,
    this.text,
  });

  void _onTap(BuildContext context) {
    print("Tapped!");
    this.onPressed(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: Colors.red,
        textColor: Colors.white,
        disabledColor: Colors.grey,
        disabledTextColor: Colors.white,
        onPressed: () => this._onTap(context),
        child: Text(
          (this.text != null) ? this.text : "Submit",
          style: TextStyle(
            fontSize: Fonts.bigFont,
          ),
        ),
      ),
    );
  }
}
