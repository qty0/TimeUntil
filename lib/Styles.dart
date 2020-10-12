import 'package:flutter/material.dart';

class Styles {


  static Color backgroundColor = Color.fromRGBO(58, 66, 86, 1.0);
  static Color cardColor = Color.fromRGBO(64, 75, 96, .9);

  static TextStyle whiteTextStyle = new TextStyle(color: Colors.white);

  static InputDecoration kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
    hintStyle: whiteTextStyle,
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.indigo, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.indigo, width: 3.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
  );
}
