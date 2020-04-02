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