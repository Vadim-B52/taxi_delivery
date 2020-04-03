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
  static Widget primaryButton(BuildContext context,
          {String title, VoidCallback onPressed}) =>
      Container(
        padding: const EdgeInsets.all(2 * UI.m),
        child: FlatButton(
          onPressed: onPressed,
          color: Colors.amberAccent,
          disabledColor: Colors.amberAccent.withAlpha(100),
          child: Container(
            padding: EdgeInsets.all(2 * UI.m),
            child: Text(title),
          ),
        ),
      );

  static Widget secondaryButton(BuildContext context,
          {String title, VoidCallback onPressed}) =>
      Container(
        padding: const EdgeInsets.all(2 * UI.m),
        child: FlatButton(
          onPressed: onPressed,
          color: Colors.grey[300],
          child: Container(
            padding: EdgeInsets.all(2 * UI.m),
            child: Text(title),
          ),
        ),
      );

  static Widget helpButton(BuildContext context,
          {String title, VoidCallback onPressed}) =>
      Container(
        padding: const EdgeInsets.all(2 * UI.m),
        child: FlatButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.blueAccent),
          ),
          child: Container(
            padding: EdgeInsets.all(2 * UI.m),
            child: Text(title),
          ),
        ),
      );

  static Widget roundButton(BuildContext context,
          {IconData icon, String title, VoidCallback onPressed}) =>
      Column(
        children: <Widget>[
          FlatButton(
            onPressed: onPressed,
            color: Colors.grey[300],
            shape: CircleBorder(),
            child: SizedBox(
              width: 60,
              height: 60,
              child: Icon(icon),
            ),
          ),
          Container(
            padding: EdgeInsets.all(UI.m),
            child: Text(title),
          ),
        ],
      );
}
