import 'package:flutter/material.dart';

abstract class ThemeText {
  static const TextStyle custom_style = TextStyle(
      fontFamily: 'Montserrat',
      color: Colors.black,
      fontSize: 40,
      height: 0.5,
      fontWeight: FontWeight.w600);
}
abstract class Decor {
  static const InputDecoration decorText = InputDecoration(
        enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        ),
        hintStyle: TextStyle(color: Colors.white),
        labelStyle: TextStyle(color: Colors.white),
        // border: InputBorder.none,
        focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
           ),
        );

}
class CustomTextStyle {

  static TextStyle display5(BuildContext context) {
    return Theme.of(context).textTheme.body1
        .copyWith(
        fontSize: 30,
        fontWeight: FontWeight.w400,
        fontFamily: 'Montserrat',
        color: Colors.black);
  }
}