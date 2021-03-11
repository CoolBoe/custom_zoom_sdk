import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/screens/mainpage.dart';

class PasswordResetScreen extends StatefulWidget {
  const PasswordResetScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return PasswordResetScreenState();
  }
}

class PasswordResetScreenState extends State<PasswordResetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  width: 100.00,
                                  height: 100.00,
                                  decoration: BoxDecoration(
                                      image: new DecorationImage(
                                          image: AssetImage(
                                              "assets/images/bg_lock.png"),
                                          fit: BoxFit.fill)),
                                ),
                                Padding(
                                    padding: EdgeInsets.only(top: 0),
                                    child: Text(
                                      "Hello Phoeniixx",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 24.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    )),
                                Text(
                                  "Your Password has been reset",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10.0)),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[]),
                                Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        changeScreenReplacement(
                                            context, MainPageScreen());
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
                                              "START SHOPPING",
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
