import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';

  Widget BaseAppBar (BuildContext context, String pageName,{Widget prefixIcon, Widget suffixIcon}) {
    return AppBar(
      backgroundColor: transparent,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(pageName,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        centerTitle: true,
      ),
      leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: prefixIcon!=null ? prefixIcon : Icon(
            Icons.arrow_back,
            color: Colors.black,
          )),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: suffixIcon!=null ? suffixIcon : SvgPicture.asset(ic_search),
        )
      ],
    );
  }

