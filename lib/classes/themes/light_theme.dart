import 'package:flutter/material.dart';

class LightTheme {
  static Color mainTheme = const Color(0xFFA859FF);
  // static Color mainTheme = Color.fromARGB(255, 197, 4, 78);
  // static Color mainTheme = Color.fromARGB(255, 20, 224, 166);
  static Color accept = const Color(0xFF58D935);
  static Color decline = const Color(0xFFFF2221);
  static Color pending = const Color(0xFFFF802C);
  static Color secondaryTheme = Colors.red;
  static Color backgroundTheme = const Color(0xFFF7F7F7);
  static Color secondarybackgroundTheme = const Color(0xFFd7d7d7);
  static Color thirdbackgroundTheme = const Color(0xFFE6E6E6);
  static Color fourthbackgroundTheme = const Color(0xFFF5F5F5);
  static Color navbarTheme = const Color(0xFFb7b7b7);
  static Color greyTheme = Colors.grey;
  static Color midgreyTheme = Colors.white30;
  static Color lightGreyTheme = Colors.grey.shade300;
  static Color darkgreyTheme = const Color(0xFF171717);
  static Color fontTheme = Colors.black;
  static Color secondaryfontTheme = const Color(0xFF4D4D4D);
  static Color firstChoiceColor = const Color.fromARGB(255, 19, 79, 128);
  static Color secondChoiceColor = const Color.fromARGB(255, 128, 43, 19);
  static Color thirdChoiceColor = const Color.fromARGB(255, 71, 62, 59);
  static Color fourthChoiceColor = const Color.fromARGB(255, 90, 112, 28);
  static Color fifthChoiceColor = const Color.fromARGB(255, 160, 28, 134);

  static void toDarkMode(bool mode) {
    backgroundTheme = (mode) ? const Color(0xFF070707) : const Color(0xFFF7F7F7);
    secondarybackgroundTheme = (mode) ? const Color(0xFF272727) : const Color(0xFFd7d7d7);
    navbarTheme = (mode) ? const Color(0xFF575757) : const Color(0xFFb7b7b7);
    fontTheme = (mode) ? Colors.white : Colors.black;
    secondaryfontTheme = (mode) ? const Color(0xFF969696) : const Color(0xFF4D4D4D);
    thirdbackgroundTheme = (mode) ? darkgreyTheme : const Color(0xFFE6E6E6);
    fourthbackgroundTheme = (mode) ? const Color(0xFF141414) : fourthbackgroundTheme;
  }
}
