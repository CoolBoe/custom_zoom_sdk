import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/screen_navigator.dart';

class MyAppBar extends StatelessWidget {
  String tag;
  StatefulWidget widget;
  MyAppBar({Key key, this.tag, this.widget}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding:
          const EdgeInsets.only(left: 0.0, top: 0, right: 10.0, bottom: 20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              changeScreen(context, widget);
            },
            child: new Text("SIGN IN",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                    color: white)),
          ),
          GestureDetector(
            onTap: () {},
            child: new Icon(Icons.keyboard_arrow_right, color: white),
          )
        ],
      ),
    ));
  }
}
