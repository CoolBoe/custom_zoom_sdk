import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/constants.dart';

TextStyle styleProvider({FontWeight fontWeight, double size, Color color }){
  return TextStyle(
      fontFamily: fontName,
      fontWeight: fontWeight,
      fontSize: size,
      color: color,
  );
}