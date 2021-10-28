import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/providers/ThemeProvider.dart';
import 'package:wooapp/screens/searchProduct.dart';

  Widget BaseAppBar (BuildContext context, String pageName,{Widget prefixIcon, Widget suffixIcon, Color backgroundColor}) {
    return AppBar(
      backgroundColor: Theme.of(context).backgroundColor,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(pageName,
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).accentColor)),
        centerTitle: true,
      ),
      leading:MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: (){
          Navigator.pop(context);
        },
        child:  prefixIcon!=null ? prefixIcon : Icon(
          Icons.arrow_back,
          color: Theme.of(context).accentColor,
        ),
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: suffixIcon!=null ? suffixIcon : GestureDetector(onTap: (){
          changeScreen(context, SearchScreen());
          },
          child: SvgPicture.asset(ic_search, color: Theme.of(context).accentColor ,),
          )
        )
      ],
    );
  }
