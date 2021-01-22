import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/screens/searchProduct.dart';
import 'package:wooapp/utils/widget_helper.dart';

Widget imageCarousel(BuildContext context){

  return SliverAppBar(
    pinned: true,
    backgroundColor: grey_200,
    floating: false,
    centerTitle: true,
    title: Text("WooApp", style: styleProvider(fontWeight: medium, size: 12, color: black),),
    iconTheme: new IconThemeData(color: black),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: GestureDetector(onTap: (){
          changeScreen(context, SearchScreen());
        },
        child: SvgPicture.asset('assets/icons/ic_search.svg'),)
      )
    ],
  );
}