import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/screens/updatePassword.dart';
import 'package:wooapp/validator/validate.dart';
import 'package:wooapp/widgets/loading.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return ForgotPassScreenState();
  }
}

class ForgotPassScreenState extends State<ForgotPassScreen> {
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context, listen: false);
    void _updatePassword() {
      if (!Validate().isValidString(authProvider.password.text.trim())) {
        snackBar("Please Enter Email ID");
      } else {
        authProvider.forget_password(authProvider.email.text).then((value) {
          if (value) {
            authProvider.clearController();
            changeScreenReplacement(context, UpdatePasswordScreen());
          }
        });
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          MyAppBar(),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 50.0, top: 0, right: 50.0, bottom: 20.0),
                child: Center(
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 150),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    child: Text(
                                      "Forgot",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    )),
                                Text(
                                  "Password?",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Please enter your email address and we will send your password by email immediately.",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 30.0, bottom: 30.0),
                                  child: Container(
                                    height: 0.5,
                                    color: Colors.black54,
                                  ),
                                ),
                                Container(
                                  height: 60.0,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(4.0))),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                            color: Colors.black12, width: 0.5),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0))),
                                    child: new Padding(
                                      padding: EdgeInsets.only(
                                          top: 5,
                                          left: 10,
                                          bottom: 2,
                                          right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            child: new Text("Email",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black)),
                                          ),
                                          Expanded(
                                            child: new TextFormField(
                                              // validator: (val){
                                              //   if (val.length==0){
                                              //     return "Email cannot be empty";
                                              //   }else{
                                              //     return null;
                                              //   }
                                              // },
                                              controller: authProvider.password,
                                              decoration: InputDecoration(
                                                  border: InputBorder.none),
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              style: new TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10.0)),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[]),
                                Padding(
                                    padding: const EdgeInsets.only(top: 40.0),
                                    child: GestureDetector(
                                      onTap: () async {
                                        _updatePassword();
                                      },
                                      child: Container(
                                        height: 50.0,
                                        color: Colors.transparent,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0))),
                                          child: new Center(
                                            child: new Text(
                                              "SEND",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                              ],
                            ))))),
          )
        ],
      ),
    );
  }
}

class MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding:
          const EdgeInsets.only(left: 10.0, top: 10, right: 10.0, bottom: 20.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: new Icon(Icons.keyboard_arrow_left,
                color: Colors.black, size: 30),
          )
        ],
      ),
    ));
  }
}
