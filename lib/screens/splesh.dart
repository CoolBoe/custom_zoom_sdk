import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/helper/social_login.dart' as social_login;
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/screens/login.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/screens/registration.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/loading.dart';
class SpleshScreen extends StatefulWidget {

  const SpleshScreen({Key key}) : super(key: key);

  @override
  SpleshScreenState createState() => SpleshScreenState();

}

class SpleshScreenState extends State<SpleshScreen>{
  final String ic_facebook = "assets/svg_assets/ic_facebook.svg";
  bool isLoggedIn = false;
  var fbProfile;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);

    void _getUser(){
      if(!Validate().isValidString(BasePrefs.getString(USER_NAME))){
        snackBar("User Info Not Found");
      }else{
        authProvider.social_login(BasePrefs.getString(SOCIAL_LOGIN_MODE), BasePrefs.getString(USER_NAME), BasePrefs.getString(USER_FIRST_NAME),
        BasePrefs.getString(USER_LAST_NAME), BasePrefs.getString(USER_EMAIL)).then((value){
          if(value){
            changeScreenReplacement(context, MainPageScreen());
          }
        });
      }
    }

    return Scaffold(
        body: new Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_login.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Column(
            children: <Widget>[
              MyAppBar(),
              Expanded(
                child:
                Padding(
                    padding: const EdgeInsets.only(left: 50.0, top: 0, right:50.0, bottom: 50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text("Welcome to",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20.0,
                              fontWeight: FontWeight.w200,
                              color: Colors.white
                          ),),
                        Text("WooApp",

                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 40.0,
                              fontWeight: FontWeight.w400,
                              color: Colors.white
                          ),),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 16.0,

                          ),
                          child: Container(
                            height: 0.3,
                            color: Colors.white70,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0
                          ),
                          child: GestureDetector(onTap: ()async{
                            await BasePrefs.init();
                            print(BasePrefs.getString(USER_NAME));
                          },
                            child:   Container(
                              height: 50.0,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                                ),
                                child: new Center(
                                  child: new Text("SIGN UP WITH EMAIL",
                                    style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.center,),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0
                          ),
                          child:  Container(
                            height: 50.0,
                            color: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.white, width: 2.0),
                                  borderRadius: BorderRadius.all(Radius.circular(5.0))
                              ),
                              child: new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: (){
                                    },
                                    child: SvgPicture.asset(
                                      ic_facebook, color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: (){
                                      social_login.FBLogin().signInFB().then((value) {
                                        if(value){
                                          printLog('fblogin', value);
                                          _getUser();
                                        }
                                      });
                                    },
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
                        ),
                      ],
                    )
                ),
              )],
          ),
        )
    );
  }
}
class MyAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0, top: 0, right:10.0, bottom: 20.0),
          child:
          new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: ()async {
                 changeScreenReplacement(context, LoginScreen());
                },
                child: new Text("SIGN IN",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.0,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              ),
              GestureDetector(
                onTap: (){},
                child: new Icon(Icons.keyboard_arrow_right, color: Colors.white),
              )
            ],
          ),
        )
    );
  }
}