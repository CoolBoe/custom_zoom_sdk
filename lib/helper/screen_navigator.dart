import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}
void changeToNewScreen(BuildContext context, Widget widget){
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (context) => widget
      ),
      ModalRoute.withName("/Home")
  );
}
