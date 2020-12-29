import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/screens/passwordreset.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return UpdatePasswordScreenState();
  }
}

class UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
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
                                      "Update Your",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black),
                                    )),
                                Text(
                                  "Password",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Please enter your new Password.",
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
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0))),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: Colors.black12,
                                              width: 0.5),
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
                                              child: new Text("Password",
                                                  style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontSize: 10.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.black)),
                                            ),
                                            Expanded(
                                              child: new TextFormField(
                                                validator: (val) {
                                                  if (val.length == 0) {
                                                    return "Password cannot be empty";
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                keyboardType: TextInputType
                                                    .visiblePassword,
                                                obscureText: true,
                                                style: new TextStyle(
                                                    fontFamily: "Poppins",
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50.0,
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
                                            child: new Text("Confirm Password",
                                                style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: 10.0,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.black)),
                                          ),
                                          Expanded(
                                            child: new TextFormField(
                                              validator: (val) {
                                                if (val.length == 0) {
                                                  return "Password cannot be empty";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.visiblePassword,
                                              obscureText: true,
                                              style: new TextStyle(
                                                  fontFamily: "Poppins",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: Colors.black),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.only(top: 10.0)),
                                Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        changeScreenReplacement(
                                            context, PasswordResetScreen());
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
                                              "UPDATE PASSWORD",
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
