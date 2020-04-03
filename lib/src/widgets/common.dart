import 'package:flutter/material.dart';

class UI {
  static const double m = 8;
}

class Dividers {
  static Widget divider() => Divider(
        indent: 2 * UI.m,
        endIndent: 2 * UI.m,
      );
}

class Buttons {
  static Widget primaryButton(
          BuildContext context, {String text, VoidCallback onPressed}) =>
      Container(
        padding: const EdgeInsets.all(2 * UI.m),
        child: RaisedButton(
          onPressed: onPressed,
          child: Container(
            padding: EdgeInsets.all(2 * UI.m),
            child: Text(text),
          ),
        ),
      );

  static Widget secondaryButton(
      BuildContext context, String text, VoidCallback onPressed) =>
      Container(
        padding: const EdgeInsets.all(2 * UI.m),
        child: RaisedButton(
          onPressed: onPressed,
          child: Container(
            padding: EdgeInsets.all(2 * UI.m),
            child: Text(text),
          ),
        ),
      );

  static Widget helpButton(
      BuildContext context, String text, VoidCallback onPressed) =>
      Container(
        padding: const EdgeInsets.all(2 * UI.m),
        child: RaisedButton(
          onPressed: onPressed,
          child: Container(
            padding: EdgeInsets.all(2 * UI.m),
            child: Text(text),
          ),
        ),
      );
}
