import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/color.dart';

Widget imageCarousel(BuildContext context){

  return SliverAppBar(
    pinned: true,
    backgroundColor: grey_50,
    expandedHeight: 250,
    floating: false,
    centerTitle: true,
    iconTheme: new IconThemeData(color: black),
    flexibleSpace: FlexibleSpaceBar(
      background: LimitedBox(
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Carousel(
            boxFit: BoxFit.fill,
            autoplay: true,
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 1000),
            dotSize: 2.0,
            dotIncreaseSize: 6.0,
            dotBgColor: transparent,
            dotColor: grey,
            dotPosition: DotPosition.bottomCenter,
            showIndicator: true,
            indicatorBgPadding: 6.0,
            images: [
              NetworkImage(
                  "https://app.tutiixx.com/wp-content/uploads/2019/01/hoodie_7_front-600x600.jpg"),
              NetworkImage(
                  "https://app.tutiixx.com/wp-content/uploads/2019/01/hoodie_6_front-600x600.jpg"),
              NetworkImage(
                  "https://app.tutiixx.com/wp-content/uploads/2019/01/hoodie_2_front-600x600.jpg"),
              NetworkImage(
                  "https://app.tutiixx.com/wp-content/uploads/2019/01/T_1_front-600x600.jpg")
            ],
          ),
        ),
      ),
    ),
    title: Text(
      'Woo App',
      style: TextStyle(
        color: black,
        fontFamily: 'Poppins',
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
      ),
    ),
    actions: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 15),
        child: SvgPicture.asset('assets/icons/ic_search.svg'),
      )
    ],
  );
}