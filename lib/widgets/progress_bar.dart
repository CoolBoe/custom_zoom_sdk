import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget progressBar(BuildContext context, Color color) {
  return Center(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(color),
      )
    ],
  ));
}

Widget pageLoader(BuildContext context) {
  return Center(
      child: Column(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Shimmer.fromColors(
            baseColor: Colors.orange,
            highlightColor: Colors.grey,
            child: Image.asset("assets/images/bg_login.png"),
          ),
        ),
      )
    ],
  ));
}
