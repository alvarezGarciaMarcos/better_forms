import 'package:flutter/material.dart';
import 'package:form_framework/utils/fonts.dart';

typedef BFButtonOnPressed = void Function();

class BFButton extends StatelessWidget {
  final BFButtonOnPressed onPressed;

  BFButton({
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Theme.of(context).primaryColor,
        ),
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Submit",
              style: TextStyle(
                color: Colors.white,
                fontSize: Fonts.bigFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
