import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/LoadProvider.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/screens/basePage.dart';
import 'package:wooapp/screens/login.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/ProgressHUD.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';
import 'mainpage.dart';
import 'package:wooapp/helper/social_login.dart' as social_login;

class RegisterScreen extends BasePage {
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends BasePageState<RegisterScreen> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  bool cb_remember = false;
  bool isApiCallProcess = false;
  UserProvider user;

  @override
  void initState() {
    user = Provider.of<UserProvider>(context, listen: false);

    super.initState();
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

  @override
  Widget pageUi() {
    var loader = Provider.of<LoaderProvider>(context, listen: false);
    // TODO: implement pageUi
    return new Scaffold(
        key: _key,
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ic_bg_login),
                fit: BoxFit.cover,
                alignment:Alignment.topCenter,
              ),
            ),
            child:Stack(
              children: <Widget>[
                Container(
                    child: Column(
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
                                                          controller: user.name,
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
                                                            controller: user.email,
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
                                                            controller: user.password,
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
                                                    loader.setLoadingStatus(true);
                                                    BasePrefs.init();
                                                    if (!isValidpassword(
                                                        user.password.text.trim())) {
                                                      setState(() {
                                                        loader.setLoadingStatus(false);
                                                      });
                                                      _key.currentState.showSnackBar(SnackBar(
                                                          content: Text(InCompletePasswordError)));
                                                    } else if (!isValidString(
                                                        user.email.text.trim()) ||
                                                        !RegExp(Validate.EMAIL_REGEX).hasMatch(
                                                            user.email.text.toString())) {
                                                      setState(() {
                                                        loader.setLoadingStatus(false);
                                                      });
                                                      _key.currentState.showSnackBar(SnackBar(
                                                          content: Text(InCompleteEmailError)));
                                                    } else if(!isValidString(user.name.text.trim())){
                                                      setState(() {
                                                        loader.setLoadingStatus(false);
                                                      });
                                                      _key.currentState.showSnackBar(SnackBar(
                                                          content: Text(InCompleteEmailError)));
                                                    }
                                                    else {
                                                      user.registerUser(user.name.text, user.email.text, user.password.text).then((value) {
                                                        user.logIn(user.email.text,user.password.text).then((value) {
                                                          loader.setLoadingStatus(false);
                                                          if(value!=null){
                                                            toast(LOGIN_STATUS_TRUE);
                                                            BasePrefs.setString(USER_MODEL, jsonEncode(value));
                                                            user.clearController();
                                                            changeScreenReplacement(context,MainPageScreen(currentTab: 0,));
                                                          }else{
                                                            toast(LOGIN_STATUS_FALSE);
                                                          }
                                                        });
                                                      });
                                                    }
                                                  } else {
                                                    _key.currentState.showSnackBar(SnackBar(
                                                        content: Text(
                                                            "Please check Remember me to keep login")));
                                                  }
                                                },
                                                child: Container(
                                                  height: 40,
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
                                          // Padding(
                                          //     padding: const EdgeInsets.only(top: dp10),
                                          //     child: GestureDetector(
                                          //       onTap: () {
                                          //         user.social_login().then((value) {
                                          //           loader.setLoadingStatus(false);
                                          //           if(value!=null){
                                          //             toast(LOGIN_STATUS_TRUE);
                                          //             BasePrefs.setString(USER_MODEL, jsonEncode(value));
                                          //             printLog("responsesara", value.toJson().toString());
                                          //             user.clearController();
                                          //             changeScreenReplacement(context,MainPageScreen(currentTab: 0,));
                                          //           }else{
                                          //             toast(LOGIN_STATUS_FALSE);
                                          //           }
                                          //         });
                                          //       },
                                          //       child: Container(
                                          //         height: dp50,
                                          //         color: transparent,
                                          //         child: Container(
                                          //           decoration: BoxDecoration(
                                          //               color: transparent,
                                          //               border: Border.all(
                                          //                   color: white, width: 2.0),
                                          //               borderRadius: BorderRadius.all(
                                          //                   Radius.circular(dp5))),
                                          //           child: new Row(
                                          //             mainAxisAlignment:
                                          //             MainAxisAlignment.center,
                                          //             children: <Widget>[
                                          //               GestureDetector(
                                          //                 onTap: () {
                                          //                   setState(() {
                                          //                     isApiCallProcess = true;
                                          //                   });
                                          //                   user.social_login().then((value) {
                                          //                     setState(() {
                                          //                       isApiCallProcess = false;
                                          //                     });
                                          //                     if(value!=null){
                                          //                       toast(LOGIN_STATUS_TRUE);
                                          //                       loader.setLoadingStatus(false);
                                          //                       BasePrefs.setString(USER_MODEL, jsonEncode(value));
                                          //                       user.clearController();
                                          //                       changeScreenReplacement(context,MainPageScreen(currentTab: 0,));
                                          //                     }else{
                                          //                       loader.setLoadingStatus(false);
                                          //                       toast(LOGIN_STATUS_FALSE);
                                          //                     }
                                          //                   });
                                          //
                                          //                 },
                                          //                 child: SvgPicture.asset(
                                          //                   ic_facebook,
                                          //                   color: white,
                                          //                 ),
                                          //               ),
                                          //               SizedBox(width: dp10),
                                          //               GestureDetector(
                                          //                 onTap: () {},
                                          //                 child: new Text(
                                          //                     "CONTINUE WITH FACEBOOK",
                                          //                     style: TextStyle(
                                          //                         fontFamily: fontName,
                                          //                         fontSize: 12.0,
                                          //                         fontWeight: medium,
                                          //                         color: white)),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         ),
                                          //       ),
                                          //     )),
                                          Padding(
                                            padding: const EdgeInsets.only(top: dp10),
                                            child: Container(
                                              height: 40,
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
                                          ),
                                        ],
                                      )))),
                        )
                      ],
                    ))
              ],
            )
        ));
  }
}

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding:
          const EdgeInsets.only(left: dp10, top: 0, right: 20, bottom: dp20),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: new Icon(Icons.keyboard_arrow_left, color: white),
          ),
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
