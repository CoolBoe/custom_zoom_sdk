import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/rest/WebApiServices.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/loading.dart';
import 'mainpage.dart';
import 'package:wooapp/helper/social_login.dart' as social_login;


class RegisterScreen extends StatefulWidget {
  final String ic_facebook = "assets/svg_assets/ic_facebook.svg";

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen>{
  final _key = GlobalKey<ScaffoldState>();
  bool cb_remember= false;
  String _name,_email,_password= "";

  FocusNode _nameFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String ic_facebook = "assets/svg_assets/ic_facebook.svg";
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    void _saveUser(){
      if(!Validate().isValidString(authProvider.name.text)){
        _key.currentState.showSnackBar(SnackBar(content: Text('Please Enter your name')));
      }else if(!Validate().isValidString(authProvider.email.text)){
        _key.currentState.showSnackBar(SnackBar(content: Text('Please Enter your email')));
      }else if(!Validate().isValidString(authProvider.password.text)){
        _key.currentState.showSnackBar(SnackBar(content: Text('Please Enter your password')));
      }else{
        authProvider.registerUser(authProvider.name.text, authProvider.email.text, authProvider.password.text).then((value){
          if(!value){
            authProvider.clearController();
            changeScreenReplacement(context, MainPageScreen());
          }
        });
      }
    }
    void _getUser(){
      if(!Validate().isValidString(BasePrefs.getString(USER_NAME))){
        snackBar("User Info Not Found");
      }else{
        authProvider.social_login(BasePrefs.getString(SOCIAL_LOGIN_MODE), BasePrefs.getString(USER_NAME), BasePrefs.getString(USER_FIRST_NAME),
            BasePrefs.getString(USER_LAST_NAME), BasePrefs.getString(USER_EMAIL)).then((value){
          if(value){
            printLog('getUser', value);
            changeScreenReplacement(context, MainPageScreen());
          }
        });
      }
    }

    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_login.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Scaffold(
            key: _key,
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomPadding: false,
            body: Column(
              children: <Widget>[
                MyAppBar(),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(left: 50.0, top: 0, right:50.0, bottom: 20.0),
                      child: Center(
                          child: SingleChildScrollView(
                              child:  Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  _tvCreate(),
                                  _tvYourAccount(),
                                  _sizeBox(),
                                  Container(
                                    height: 60.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.black38,
                                          borderRadius: BorderRadius.all(Radius.circular(5.0))
                                      ),
                                      child: new Padding(
                                        padding: EdgeInsets.only(
                                            top: 5,
                                            left: 10,
                                            bottom: 2,
                                            right: 10
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Expanded(
                                              child: new Text("Name",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 10.0,
                                                      fontWeight: FontWeight.w400,
                                                      color: Colors.white)),
                                            ),
                                            Expanded(
                                                child: new TextFormField(
                                                  // validator: (name){
                                                  //  Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                                  //  RegExp regex = new RegExp(pattern);
                                                  //  if (!regex.hasMatch(name))
                                                  //    return '';
                                                  //  else
                                                  //    return null;
                                                  // },
                                                  focusNode: _nameFocusNode,
                                                  controller: authProvider.name,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                  textInputAction: TextInputAction.next,
                                                  keyboardType: TextInputType.text,
                                                  style: new TextStyle(
                                                      fontFamily: "Poppins",
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 18
                                                  ),
                                                  onFieldSubmitted: (_){
                                                    fieldFocusChange(context, _nameFocusNode, _emailFocusNode);
                                                  },
                                                )
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 10),
                                    child: Container(
                                      height: 60.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black38,
                                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                                        ),
                                        child: new Padding(
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              left: 10,
                                              bottom: 2,
                                              right: 10
                                          ),
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
                                                    autofocus: true,
                                                    controller: authProvider.email,
                                                    keyboardType: TextInputType.emailAddress,
                                                    textInputAction: TextInputAction.next,
                                                    style: new TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 18
                                                    ),
                                                    onFieldSubmitted: (_){
                                                      fieldFocusChange(context, _emailFocusNode, _passwordFocusNode);
                                                    },
                                                  )
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),),
                                  Padding(padding: EdgeInsets.only(top: 10),
                                    child: Container(
                                      height: 60.0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.black38,
                                            borderRadius: BorderRadius.all(Radius.circular(5.0))
                                        ),
                                        child: new Padding(padding: EdgeInsets.only(top: 5, left:10, bottom: 2, right: 10),
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
                                                    controller: authProvider.password,
                                                    // validator: (password){
                                                    //   Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                                                    //   RegExp regex = new RegExp(pattern);
                                                    //   if (!regex.hasMatch(password))
                                                    //     return '';
                                                    //   else
                                                    //     return null;
                                                    // },
                                                    textInputAction: TextInputAction.done,
                                                    keyboardType: TextInputType.text,
                                                    obscureText: true,
                                                    style: new TextStyle(
                                                        fontFamily: "Poppins",
                                                        fontWeight: FontWeight.w400,
                                                        fontSize: 18
                                                    ),
                                                  )
                                              ),
                                            ],
                                          ),),
                                      ),
                                    ),
                                  ),
                                  _cbRememberMe(),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 40.0
                                      ),
                                      child: GestureDetector(onTap: ()async {
                                          if (cb_remember) {
                                            _saveUser();
                                          }else{
                                            _key.currentState.showSnackBar(
                                                SnackBar(content: Text("Please check Remember me to keep login"))
                                            );
                                          }
                                      },
                                        child: Container(
                                          height: 50.0,
                                          color: Colors.transparent,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.all(Radius.circular(5.0))
                                            ),
                                            child: new Center(
                                              child: new Text("SIGN UP",
                                                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                                                textAlign: TextAlign.center,),
                                            ),
                                          ),
                                        ),
                                      )
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10.0
                                      ),
                                      child: GestureDetector(
                                        onTap: (){
                                          social_login.FBLogin().signInFB().then((value) {
                                            if(value){
                                              printLog('fblogin', value);
                                              _getUser();
                                            }
                                          });
                                        },
                                        child: Container(
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
                                                  onTap: (){},
                                                  child: SvgPicture.asset(
                                                    ic_facebook, color: Colors.white,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                GestureDetector(
                                                  onTap: (){},
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
                                      )
                                  )
                                ],
                              )
                          )
                      )
                  ),
                )],
            ),
          ) ,
        )
    );
  }
  Widget _sizeBox(){
    return Padding(
      padding: EdgeInsets.only(
          top: 30.0,
          bottom: 30.0
      ),
      child: Container(
        height: 0.9,
        color: Colors.white70,
      ),
    );
  }
  Widget _cbRememberMe(){
    return Padding(
      padding: const EdgeInsets.only(top:10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 24.0,
            width: 24.0,
            child: GestureDetector(
              child:Theme(
                data: ThemeData(unselectedWidgetColor: Colors.white),
                child: Checkbox(
                  value: cb_remember,
                  checkColor: Colors.black,
                  activeColor: Colors.white,
                  onChanged: (bool value){
                    setState(() {
                      cb_remember = value;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(width: 3.0),
          Expanded(child: Text("By Signing up you will agree to our Privacy Policy and Terms"))
        ],),
    );
  }
  Widget _tvCreate(){
    return Padding(padding: EdgeInsets.only(top: 50 ),
        child: Text("Create",
          style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
              color: Colors.white
          ),)
    );
  }
  Widget _tvYourAccount(){
    return Text("Your Account",
      style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 35.0,
          fontWeight: FontWeight.w500,
          color: Colors.white
      ),);
  }

  Widget _btSignUp(BuildContext context){
    return Padding(
        padding: const EdgeInsets.only(
            top: 40.0
        ),
        child: GestureDetector(onTap: () {
          setState(() async{
            if (cb_remember) {


              // Navigator.of(context).pushNamed(routes.MainPage_Route);
            }
          });
        },
          child: Container(
            height: 50.0,
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5.0))
              ),
              child: new Center(
                child: new Text("SIGN UP",
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,),
              ),
            ),
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
          padding: const EdgeInsets.only(left: 10.0, top: 0, right:10.0, bottom: 20.0),
          child:
          new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: new Icon(Icons.keyboard_arrow_left, color: Colors.white),
              )
            ],
          ),
        )
    );
  }
}