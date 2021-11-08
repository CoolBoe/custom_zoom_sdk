import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/helper/social_login.dart' as social_login;
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/providers/loader_provider.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/screens/login.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/registration.dart';
import 'package:wooapp/widgets/loading.dart';

class SpleshScreen extends BasePage {

  @override
  SpleshScreenState createState() => SpleshScreenState();
}

class SpleshScreenState extends BasePageState<SpleshScreen> {
  bool isLoggedIn = false;

  bool hidePassword = true;
  bool isApiCallProcess = false;
  var fbProfile;
  UserProvider user;
  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ic_bg_login),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: <Widget>[
              AppBar(),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: 50.0, top: 0, right: 50.0, bottom: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "Welcome to",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w200,
                              color: white),
                        ),
                        Text(
                          appName,
                          style: TextStyle(
                              fontFamily: fontName,
                              fontSize: dp40,
                              fontWeight: regular,
                              color: white),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: 16.0,
                          ),
                          height: 0.3,
                          color: white_70,
                        ),
                        GestureDetector(
                          onTap: () async {
                            changeScreen(context, RegisterScreen());
                          },
                          child: Container(
                            height: 50.0,
                            color: transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(5.0))),
                              child: new Center(
                                child: new Text(
                                  "SIGN UP WITH EMAIL",
                                  style: TextStyle(
                                      color: black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: dp10),
                          height: dp50,
                          color: transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: transparent,
                                  border: Border.all(color: white, width: 2.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(dp5))),
                              child: GestureDetector(
                                onTap: () {
                                  var loader = Provider.of<LoaderProvider>(context, listen: false);
                                  user.social_login(context: context).then((value) {
                                    loader.setLoadingStatus(false);
                                    if(value!=null){
                                      toast(LOGIN_STATUS_TRUE);
                                      BasePrefs.setString(USER_MODEL, jsonEncode(value));
                                      printLog("responsesara", value.toJson().toString());
                                      user.clearController();
                                      changeScreenReplacement(context,MainPageScreen(currentTab: 0,));
                                    }else{
                                      toast(LOGIN_STATUS_FALSE);
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset(
                                      ic_facebook,
                                      color: white,
                                    ),
                                    SizedBox(width: 10),
                                    new Text("CONTINUE WITH FACEBOOK",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            fontWeight: medium,
                                            color: white))
                                  ],
                                ),
                              )),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: dp10),
                          height: dp50,
                          color: transparent,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: transparent,
                                  border: Border.all(color: white, width: 2.0),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(dp5))),
                              child: GestureDetector(
                                onTap: () {
                                  var loader = Provider.of<LoaderProvider>(context, listen: false);
                                  loader.setLoadingStatus(true);
                                  user.google_login(context: context).then((value) {
                                    if(value!=null){
                                      toast(LOGIN_STATUS_TRUE);
                                      BasePrefs.setString(USER_MODEL, jsonEncode(value));
                                      printLog("responsesara", value.toJson().toString());
                                      user.clearController();
                                      changeScreenReplacement(context,MainPageScreen(currentTab: 0,));
                                    }else{
                                      toast(LOGIN_STATUS_FALSE);
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 20,
                                      width: 20,child:  Image.asset(ic_google_png),),
                                    SizedBox(width: 10),
                                    new Text("CONTINUE WITH GOOGLE",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 12.0,
                                            fontWeight: medium,
                                            color: white))
                                  ],
                                ),
                              )),
                        ),
                      ],
                    )),
              )
            ],
          )
        ));
  }
}
class AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding:
          const EdgeInsets.only(left: 0.0, top: 10, right: dp10, bottom: dp20),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
              onTap: () async {
                changeScreenReplacement(context, LoginScreen());
              },
              child: new Row(
                children: [
                  Text("SIGN IN",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 12.0,
                          fontWeight: medium,
                          color: white)),
                  Icon(Icons.keyboard_arrow_right, color: white),
                ],
              )),
        ],
      ),
    ));
  }
}
