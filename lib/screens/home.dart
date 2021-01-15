import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/main.dart';
import 'package:wooapp/models/mockdata/item_model.dart';
import 'package:wooapp/models/product.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/cart.dart';
import 'package:wooapp/providers/category.dart';
import 'package:wooapp/providers/product.dart';
import 'package:wooapp/rest/WebRequestConstants.dart';
import 'package:wooapp/screens/category.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/productScreen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/screens/splesh.dart';
import 'package:wooapp/widgets/item_DrawerBuilder.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/product.dart';
import 'package:wooapp/widgets/Item_builder.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'package:wooapp/widgets/widget_home_categories.dart';
import 'package:wooapp/widgets/widget_home_slider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key key}) : super(key: key);
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeView> {
  bool _toggel = true;
  @override
  void initState() {
    BasePrefs.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      body: Container(
          decoration: BoxDecoration(color: white), child: _CustomScrollView()),
    );
  }

  Widget _CustomScrollView() {
    return CustomScrollView(
      slivers: <Widget>[
        imageCarousel(context),
        WidgetCategories(),
      ],
    );
    ;
  }
  Widget _buildDrawer() {
    BasePrefs.init();
    var value= BasePrefs.getString(USER_MODEL);
    printLog("datdatd",value.toString());
    Details model = Details.fromJson(jsonDecode(value));
    return Container(
        width: 250,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
          child: Drawer(
            child: Column(
              children: <Widget>[
                Container(
                  height: 250,
                  child: DrawerHeader(
                      decoration: BoxDecoration(color: black),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(model!=null ? model.avatarUrl : ""),
                                backgroundColor: transparent,
                              ),
                              Expanded(child: Text(model.firstName!=null && model.billing.firstName!="" ?
                              model.firstName!=null && model.firstName!=""?
                              "Dear ${model.firstName.toUpperCase()}" : "Dear ${model.billing.firstName.toUpperCase()}" :
                              "Hi User",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: white),
                              )),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 5.0),
                                      child: Text(
                                        'Day Mode',
                                        style: TextStyle(
                                            color: white,
                                            fontSize: 10,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    AnimatedContainer(
                                      duration: Duration(milliseconds: 1000),
                                      height: 15,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: _toggel ? white : orange),
                                      child: Stack(
                                        children: <Widget>[
                                          AnimatedPositioned(
                                              duration:
                                                  Duration(milliseconds: 1000),
                                              curve: Curves.easeIn,
                                              right: _toggel ? 0.0 : 20.0,
                                              left: _toggel ? 20.0 : 0.0,
                                              child: InkWell(
                                                onTap: toggleButton,
                                                child: AnimatedSwitcher(
                                                    duration: Duration(
                                                        milliseconds: 1000),
                                                    transitionBuilder:
                                                        (Widget child,
                                                            Animation<double>
                                                                animation) {
                                                      return ScaleTransition(
                                                          child: child,
                                                          scale: animation);
                                                    },
                                                    child: _toggel
                                                        ? Icon(
                                                            Icons.circle,
                                                            color: orange,
                                                            size: 15,
                                                          )
                                                        : Icon(
                                                            Icons.circle,
                                                            color: white,
                                                            size: 15,
                                                          )),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 400,
                  child: ItemDrawerBuilder(),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: black,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 30, bottom: 10),
                        child: GestureDetector(
                          onTap: () {
                            BasePrefs.init();
                            BasePrefs.clearPrefs().then((value) => {
                                  setState(() {
                                    if (value) {
                                      toast(USER_LOGOUT);
                                     changeToNewScreen(context,SpleshScreen(), "/SplashScreen");
                                    }
                                  })
                                });
                          },
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: SvgPicture.asset(
                                 ic_logout,
                                  width: 20,
                                  height: 20,
                                  color: white,
                                ),
                              ),
                              Text('Logout',
                                  style: TextStyle(
                                      color: white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void toggleButton() {
    setState(() {
      _toggel = !_toggel;
    });
  }
  @override
  void dispose() {
    // Add code before the super
    super.dispose();
  }
}
