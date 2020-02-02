import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
//  final VoidCallback onPressed;
//  final IconData icon;
  final String label;

//  RoundButton(/*@required*/ this.onPressed, this.icon, this.label);
  RoundButton(this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 255, 255, 0),
          ),
        ),
        Text(label),
      ],
    );
  }
}
