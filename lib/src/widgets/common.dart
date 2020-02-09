import 'package:flutter/material.dart';

class UI {
  static const double m = 8;
}

class TextStyles {
  static TextStyle textStyleSectionHeader() => TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
      );

  static TextStyle textStyleRegular() => TextStyle(fontSize: 15);
}

class Dividers {
  static Widget divider() => Divider(
        indent: 2 * UI.m,
        endIndent: 2 * UI.m,
      );
}

//class RoundButton extends StatelessWidget {
//  final VoidCallback onPressed;
//  final IconData icon;
//  final String label;
//
//  RoundButton(@required this.onPressed, this.icon, this.label);
//
//  @override
//  Widget build(BuildContext context) {
////    RaisedButton MaterialButton
////    FlatButton
//    return Column(
//      children: <Widget>[
//        Container(
//          width: 60,
//          height: 60,
//          decoration: BoxDecoration(
//            shape: BoxShape.circle,
//            color: Colors.grey[300],
//          ),
//          child: Icon(icon),
//        ),
//        Container(
//          padding: EdgeInsets.only(top: UI.m),
//          child: Text(
//            label,
//            style: TextStyle(fontSize: 13),
//          ),
//        ),
//      ],
//    );
//  }
//}
