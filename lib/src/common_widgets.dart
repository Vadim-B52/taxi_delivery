import 'package:flutter/material.dart';

class _UI {
  static const double m = 8;
}

class RoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  RoundButton(@required this.onPressed, this.icon, this.label);

  @override
  Widget build(BuildContext context) {
//    RaisedButton MaterialButton
//    FlatButton
    return Column(
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[300],
          ),
          child: Icon(icon),
        ),
        Container(
          padding: EdgeInsets.only(top: _UI.m),
          child: Text(
            label,
            style: TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
