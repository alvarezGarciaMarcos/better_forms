import 'package:better_forms/form/types/types.dart';
import 'package:flutter/material.dart';
import 'package:better_forms/utils/fonts.dart';

class BFButton extends StatelessWidget {
  final BFButtonOnPressed onPressed;
  final String text;
  final Color color;
  final Color fontText;

  BFButton({
    this.onPressed,
    this.text,
    this.color,
    this.fontText,
  });

  void _onTap(BuildContext context) {
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
