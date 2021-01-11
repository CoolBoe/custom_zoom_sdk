import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/screens/forgotPassword.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/helper/social_login.dart' as social_login;
import 'package:wooapp/widgets/ProgressHUD.dart';
import 'package:wooapp/widgets/loading.dart';

class LoginScreen extends BasePage {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends BasePageState<LoginScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool cb_remember = false;
  UserProvider user;
  LoaderProvider loader;
  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false);
    loader = Provider.of<LoaderProvider>(context, listen: false);
    super.initState();
  }

  void _getUser() {
    BasePrefs.init();
    if (!isValidString(user.password.text.trim()) ||!isValidString(user.email.text.trim()) ) {
      loader.setLoadingStatus(false);
      snackBar(InCompleteDataError);
    } else {
      user
          .logIn(user.email.text, user.password.text)
          .then((value) {
            if(value!=null){
              toast(LOGIN_STATUS_TRUE);
              loader.setLoadingStatus(false);
              BasePrefs.setString(USER_MODEL, jsonEncode(value));

              var valuu = BasePrefs.getString(USER_MODEL);
                     printLog("datadta", value.toJson().toString());
              user.clearController();
              changeScreenReplacement(context,MainPageScreen(currentTab: 0,));
            }else{
              toast(LOGIN_STATUS_FALSE);
            }

      });
    }
  }

  void _getFBUser() {
    if (!isValidString(BasePrefs.getString(USER_NAME))) {
      snackBar("User Info Not Found");
    } else {
      user
          .social_login(mode: BasePrefs.getString(SOCIAL_LOGIN_MODE) !=null
          ? BasePrefs.getString(SOCIAL_LOGIN_MODE) : "",
          name: BasePrefs.getString(USER_NAME) !=null
              ? BasePrefs.getString(USER_NAME) : "",
          firstName:  BasePrefs.getString(USER_FIRST_NAME) !=null
              ? BasePrefs.getString(USER_FIRST_NAME) : "",
          lastName:  BasePrefs.getString(USER_LAST_NAME) !=null
              ? BasePrefs.getString(USER_LAST_NAME) : "",
          email:  BasePrefs.getString(USER_EMAIL) !=null
              ? BasePrefs.getString(USER_EMAIL) : "")
          .then((value) {
        if (value) {
          toast(LOGIN_STATUS_TRUE);
          changeScreen(
              context,
              MainPageScreen(
                currentTab: 0,
              ));
        } else {
          toast(LOGIN_STATUS_FALSE);
        }
      });
    }
  }

  @override
  Widget pageUi() {
    // TODO: implement pageUi
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ic_bg_login),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: <Widget>[
            AppBar(),
            Expanded(
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 50.0, top: 0, right: 50.0, bottom: 20.0),
                  child: Center(
                      child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              _tvlogin(),
                              _tvYourAccount(),
                              _topPaddingLine(),
                              Container(
                                height: 60.0,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black38,
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5.0))),
                                  child: new Padding(
                                    padding: EdgeInsets.only(
                                        top: 10, left: 10, bottom: 2, right: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: new Text("Email",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.white)),
                                        ),
                                        Expanded(
                                            child: new TextFormField(
                                              controller: user.email,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                              ),
                                              keyboardType: TextInputType.emailAddress,
                                              style: new TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                              color: white),
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 10),
                                child: Container(
                                  height: 60.0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black38,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(5.0))),
                                    child: new Padding(
                                      padding: EdgeInsets.only(
                                          top: 5, left: 10, bottom: 2, right: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: new Text("Password",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.white)),
                                          ),
                                          Expanded(
                                              child: new TextFormField(
                                                controller: user.password,
                                                decoration: InputDecoration(
                                                    border: InputBorder.none),
                                                keyboardType: TextInputType.visiblePassword,
                                                obscureText: true,
                                                style: new TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 18,
                                                color: white),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              _sizebox(),
                              _cbRememberMe(),
                              Padding(
                                padding: const EdgeInsets.only(top: 40.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    if (cb_remember) {
                                      setState(() {
                                        loader.setLoadingStatus(true);
                                      });
                                      _getUser();
                                    } else {
                                      _key.currentState.showSnackBar(SnackBar(
                                          content: Text(
                                              "Please check Remember me to keep login")));
                                    }
                                    // Navigator.pushNamed(context, routes.MainPage_Route);
                                  },
                                  child: Container(
                                    height: 50.0,
                                    color: Colors.transparent,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                          BorderRadius.all(Radius.circular(5.0))),
                                      child: new Center(
                                        child: new Text(
                                          "SIGN",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      social_login.FBLogin().signInFB().then((value) {
                                        if (value) {
                                          printLog('fblogin', value);
                                          _getFBUser();
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 50.0,
                                      color: Colors.transparent,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.transparent,
                                            border: Border.all(
                                                color: Colors.white, width: 2.0),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(5.0))),
                                        child: new Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            SvgPicture.asset(
                                              ic_facebook,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: () {},
                                              child: new Text("CONTINUE WITH FACEBOOK",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 12.0,
                                                      fontWeight: FontWeight.w500,
                                                      color: Colors.white)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                            ],
                          )))),
            )
          ],
        ),
      ),
    );
  }

  Widget _cbRememberMe() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 24.0,
                width: 24.0,
                child: GestureDetector(
                  child: Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white),
                    child: Checkbox(
                      value: cb_remember,
                      checkColor: Colors.black,
                      activeColor: Colors.white,
                      onChanged: (bool value) {
                        setState(() {
                          cb_remember = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(width: 3.0),
              GestureDetector(child: Text("Remember Me", style: styleProvider(color: white, size: 12),)),
            ],
          ),
          GestureDetector(
              onTap: () {
                changeScreenReplacement(context, ForgotPassScreen());
                // Navigator.of(context).pushNamed(routes.ForgotPass_Route);
              },
              child: Text("Forgot Password?"))
        ]);
  }

  Widget _sizebox() {
    return Padding(padding: EdgeInsets.only(top: 10.0));
  }

  Widget _topPaddingLine() {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
      child: Container(
        height: 0.9,
        color: Colors.white70,
      ),
    );
  }

  Widget _tvYourAccount() {
    return Text(
      "Your Account",
      style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 35.0,
          fontWeight: FontWeight.w500,
          color: Colors.white),
    );
  }

  Widget _tvlogin() {
    return Padding(
        padding: EdgeInsets.only(top: 120),
        child: Text(
          "Login Into",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        ));
  }
}

class AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding:
          const EdgeInsets.only(left: 10.0, top: 0, right: 10.0, bottom: 20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: new Icon(Icons.keyboard_arrow_left, color: Colors.white),
          )
        ],
      ),
    ));
  }
}
