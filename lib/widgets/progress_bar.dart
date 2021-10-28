import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget progressBar(BuildContext context, Color color) {
  return Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: new AlwaysStoppedAnimation<Color>(color),
        )
      ],
  ));
}

