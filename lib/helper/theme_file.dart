import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData.dark().copyWith(
    unselectedWidgetColor: Colors.orange,
    primaryColor: Colors.black,
    accentColor: Color(0xffF29239),
    backgroundColor: Colors.black,
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 14.0,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          color: Colors.white),
    ));
ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: Colors.white,
    accentColor: Color(0xffF29239),
    backgroundColor: Colors.white,
    textTheme: TextTheme(
      headline1: TextStyle(
          fontSize: 14.0,
          fontFamily: "Poppins",
          fontWeight: FontWeight.w400,
          color: Colors.black),
    ));
