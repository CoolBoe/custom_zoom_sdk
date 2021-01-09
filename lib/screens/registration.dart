import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/ProgressHUD.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'mainpage.dart';
import 'package:wooapp/helper/social_login.dart' as social_login;

class RegisterScreen extends StatefulWidget {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
   GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool cb_remember = false;
   bool isApiCallProcess = false;
   GlobalKey<FormState>_formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    bool hidePassword = true;

    void _saveUser() {
      BasePrefs.init();
      if (!isValidString(authProvider.name.text)) {
        _key.currentState
            .showSnackBar(SnackBar(content: Text(ENTER_USER_NAME)));
      } else if (!isValidString(authProvider.email.text)) {
        _key.currentState
            .showSnackBar(SnackBar(content: Text(ENTER_USER_EMAIL)));
      } else if (!isValidString(authProvider.password.text)) {
        _key.currentState
            .showSnackBar(SnackBar(content: Text(ENTER_USER_PASSWORD)));
      } else {
        authProvider
            .registerUser(authProvider.name.text, authProvider.email.text,
                authProvider.password.text)
            .then((value) {
              setState(() {
                isApiCallProcess = false;
              });
          setState(() {
            printLog("setstate", value);
            if (value) {
              toast(LOGIN_STATUS_TRUE);
              authProvider.clearController();
              changeScreenReplacement(
                  context,
                  MainPageScreen(
                    currentTab: 0,
                  ));
            } else {
              toast(LOGIN_STATUS_FALSE);
            }
          });
        });
      }
    }
    void _getUser() {
      if (!isValidString(BasePrefs.getString(USER_NAME))) {
        snackBar(USER_NOT_FOUND);
      } else {
        authProvider
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
          setState(() {
            isApiCallProcess = false;
            if (value) {
              printLog("socialResponse", value);
              changeScreenReplacement(context, MainPageScreen(currentTab: 0,));
            } else {
              toast(LOGIN_STATUS_FALSE);
            }
          });
        });
      }
    }
    return ProgressHUD(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ic_bg_login),
            fit: BoxFit.fill,
          ),
        ),
        child: Scaffold(
          key: _key,
          backgroundColor: transparent,
          resizeToAvoidBottomPadding: false,
          body: Column(
            children: <Widget>[
              MyAppBar(),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(
                        left: dp50, right: dp50, bottom: dp20),
                    child: Center(
                        child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                _tvCreate(),
                                _tvYourAccount(),
                                _sizeBox(),
                                Container(
                                  height: dp60,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: black_38,
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(dp5))),
                                    child: new Padding(
                                      padding: EdgeInsets.only(
                                          top: dp5,
                                          left: dp10,
                                          bottom: 2,
                                          right: dp10),
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: new Text("Name",
                                                style: TextStyle(
                                                    fontFamily: fontName,
                                                    fontSize: dp10,
                                                    fontWeight: regular,
                                                    color: white)),
                                          ),
                                          Expanded(
                                              child: new TextFormField(
                                                controller: authProvider.name,
                                                textInputAction: TextInputAction.next,
                                                keyboardType: TextInputType.text,
                                                style: new TextStyle(
                                                    fontFamily: fontName,
                                                    fontWeight: regular,
                                                    fontSize: 18,
                                                    color: white),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: dp10),
                                  child: Container(
                                    height: dp60,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: black_38,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(dp5))),
                                      child: new Padding(
                                        padding: EdgeInsets.only(
                                            top: dp5,
                                            left: dp10,
                                            bottom: 2,
                                            right: dp10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: new Text("Email",
                                                  style: TextStyle(
                                                      fontFamily: fontName,
                                                      fontSize: dp10,
                                                      fontWeight: regular,
                                                      color: white)),
                                            ),
                                            Expanded(
                                                child: new TextFormField(
                                                  controller: authProvider.email,
                                                  keyboardType:
                                                  TextInputType.emailAddress,
                                                  style: new TextStyle(
                                                      fontFamily: fontName,
                                                      fontWeight: regular,
                                                      fontSize: 18,
                                                      color: white),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: dp10),
                                  child: Container(
                                    height: dp60,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: black_38,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(dp5))),
                                      child: new Padding(
                                        padding: EdgeInsets.only(
                                            top: dp5,
                                            left: dp10,
                                            bottom: 2,
                                            right: dp10),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: new Text("Password",
                                                  style: TextStyle(
                                                      fontFamily: fontName,
                                                      fontSize: dp10,
                                                      fontWeight: regular,
                                                      color: white)),
                                            ),
                                            Expanded(
                                                child: new TextFormField(
                                                  controller: authProvider.password,
                                                  textInputAction: TextInputAction.done,
                                                  keyboardType: TextInputType.text,
                                                  obscureText: true,
                                                  style: new TextStyle(
                                                      fontFamily: fontName,
                                                      fontWeight: regular,
                                                      fontSize: 18,
                                                      color: white),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                _cbRememberMe(),
                                Padding(
                                    padding: const EdgeInsets.only(top: dp40),
                                    child: GestureDetector(
                                      onTap: () async {
                                        if (cb_remember) {
                                          setState(() {
                                            isApiCallProcess = true;
                                          });
                                          printLog("setstate", isApiCallProcess);
                                          _saveUser();

                                        } else {
                                          _key.currentState.showSnackBar(SnackBar(
                                              content: Text(
                                                  "Please check Remember me to keep login")));
                                        }
                                      },
                                      child: Container(
                                        height: dp50,
                                        color: transparent,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: white,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(dp5))),
                                          child: new Center(
                                            child: new Text(
                                              "SIGN UP",
                                              style: TextStyle(
                                                  color: black,
                                                  fontSize: 14,
                                                  fontWeight: medium),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                                Padding(
                                    padding: const EdgeInsets.only(top: dp10),
                                    child: GestureDetector(
                                      onTap: () {
                                        social_login.FBLogin()
                                            .signInFB()
                                            .then((value) {
                                          isApiCallProcess = true;
                                          if (value) {
                                            printLog('fblogin', value);
                                            _getUser();
                                          }
                                        });

                                      },
                                      child: Container(
                                        height: dp50,
                                        color: transparent,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: transparent,
                                              border: Border.all(
                                                  color: white, width: 2.0),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(dp5))),
                                          child: new Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {},
                                                child: SvgPicture.asset(
                                                  ic_facebook,
                                                  color: white,
                                                ),
                                              ),
                                              SizedBox(width: dp10),
                                              GestureDetector(
                                                onTap: () {},
                                                child: new Text(
                                                    "CONTINUE WITH FACEBOOK",
                                                    style: TextStyle(
                                                        fontFamily: fontName,
                                                        fontSize: 12.0,
                                                        fontWeight: medium,
                                                        color: white)),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ))
                              ],
                            )))),
              )
            ],
          ),
        ),
      ),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _sizeBox() {
    return Padding(
      padding: EdgeInsets.only(top: dp30, bottom: dp30),
      child: Container(
        height: 0.9,
        color: white_70,
      ),
    );
  }

  Widget _cbRememberMe() {
    return Padding(
      padding: const EdgeInsets.only(top: dp10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: GestureDetector(
              child: Theme(
                data: ThemeData(unselectedWidgetColor: white),
                child: Checkbox(
                  value: cb_remember,
                  checkColor: black,
                  activeColor: white,
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
          Expanded(
              child: Text(
            "By Signing up you will agree to our Privacy Policy and Terms",
            style: TextStyle(
                fontFamily: fontName,
                fontSize: dp10,
                fontWeight: medium,
                color: white),
          ))
        ],
      ),
    );
  }

  Widget _tvCreate() {
    return Padding(
        padding: EdgeInsets.only(top: dp50),
        child: Text(
          "Create",
          style: TextStyle(
              fontFamily: fontName,
              fontSize: dp20,
              fontWeight: medium,
              color: white),
        ));
  }

  Widget _tvYourAccount() {
    return Text(
      "Your Account",
      style: TextStyle(
          fontFamily: fontName,
          fontSize: dp35,
          fontWeight: medium,
          color: white),
    );
  }
}

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding:
          const EdgeInsets.only(left: dp10, top: 0, right: dp10, bottom: dp20),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: new Icon(Icons.keyboard_arrow_left, color: white),
          )
        ],
      ),
    ));
  }
}
