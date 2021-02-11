import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/screens/splesh.dart';
import 'package:wooapp/widgets/item_DrawerBuilder.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/widgetHomeLayoutMoke.dart';
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
    AppProvider.initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: homeAppBar(context),
      drawer: _buildDrawer(),
      body: Container(
          decoration: BoxDecoration(color: white), child: _CustomScrollView()),
    );
  }
  Widget _CustomScrollView() {
    return new Consumer<AppProvider>(builder: (context, app, child){
      if(app.getHomeLayout!=null && app.getHomeLayout.categories !=null){
        return SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  child: app.getHomeLayout.banners!=null && app.getHomeLayout.banners.length>0 ?
                  BannerSlider(homeLayout: app.getHomeLayout,) : Container(
                    child: MokeHomeLayout(),
                  ),
                ),
                app.getHomeLayout.categories!=null && app.getHomeLayout.categories.length>0?
                WidgetCategories(homeLayout: app.getHomeLayout): Container()
              ],
            ),
          ),
        );
      }else{
        printLog("bhjghjghg", "");
        return ShimmerList(listType: "Home",);
      }
    });
  }
  Widget _buildDrawer() {
    BasePrefs.init();
    Details model;
    if( BasePrefs.getString(USER_MODEL)!=null){
      var value= BasePrefs.getString(USER_MODEL);
       model = Details.fromJson(jsonDecode(value));
    }
    var user= Provider.of<UserProvider>(context, listen: false);
    return Container(
        width: 250,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
          child: Drawer(
            child: Column(
              children: <Widget>[
                Container(
                  height: 230,
                  child: DrawerHeader(
                      decoration: BoxDecoration(color: black),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: NetworkImage(user.getProfileImage()),
                                backgroundColor: transparent,
                              ),
                              Expanded(child: Text(
                                model==null ? "Hi User":
                                model.firstName!=null && model.firstName!=""?
                                model.billing.firstName!=null && model.billing.firstName!="" ?
                                "Dear ${model.billing.firstName..toUpperCase()}" : "Dear ${model.firstName.toUpperCase()}" :
                                "Hi User",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: white),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(right:8.0, left:8, bottom: 8),
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
                                          color: _toggel ? white : accent_color),
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
                                                            color: accent_color,
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
                  height: MediaQuery.of(context).size.height-350,
                  child: SingleChildScrollView(
                    child: Container(
                       child: Column(
                         children: [
                           ItemDrawerBuilder(),
                         ],
                       )
                    ),
                  ),
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
