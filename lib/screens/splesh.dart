import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/helper/social_login.dart' as social_login;
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/providers/app.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/screens/login.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/registration.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/ProgressHUD.dart';
import 'package:wooapp/widgets/loading.dart';
import 'package:wooapp/widgets/progress_bar.dart';

class SpleshScreen extends StatefulWidget {
  const SpleshScreen({Key key}) : super(key: key);

  @override
  SpleshScreenState createState() => SpleshScreenState();
}

class SpleshScreenState extends State<SpleshScreen> {
  bool isLoggedIn = false;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;
  var fbProfile;
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    final app = Provider.of<AppProvider>(context);
    void _getUser(){
      if (!isValidString(BasePrefs.getString(USER_NAME))) {
        snackBar("User Info Not Found");
      } else
        {
        authProvider
            .social_login(
                BasePrefs.getString(SOCIAL_LOGIN_MODE) != null
                    ? BasePrefs.getString(SOCIAL_LOGIN_MODE)
                    : "",
                BasePrefs.getString(USER_NAME) != null
                    ? BasePrefs.getString(USER_NAME)
                    : "",
                BasePrefs.getString(USER_FIRST_NAME) != null
                    ? BasePrefs.getString(USER_FIRST_NAME)
                    : "",
                BasePrefs.getString(USER_LAST_NAME) != null
                    ? BasePrefs.getString(USER_LAST_NAME)
                    : "",
                BasePrefs.getString(USER_EMAIL) != null
                    ? BasePrefs.getString(USER_EMAIL)
                    : "")
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
    return Scaffold(
        body: Container(
        decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ic_bg_login),
          fit: BoxFit.fill,
        ),
      ),
         child: ProgressHUD(child: new Form(key: globalKey,child: Column(
          children: <Widget>[
          MyAppBar(),
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
                    Padding(
                      padding: EdgeInsets.only(
                        top: 16.0,
                      ),
                      child: Container(
                        height: 0.3,
                        color: white_70,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: dp40),
                      child: GestureDetector(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: dp10),
                      child: Container(
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
                                social_login.FBLogin().signInFB().then((value) {
                                  if (value) {
                                    _getUser();
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
                    ),
                  ],
                )),
          )
        ],
      )), inAsyncCall: isApiCallProcess, opacity: 0.3,),
    ));
  }
}
class MyAppBar extends StatelessWidget {
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
