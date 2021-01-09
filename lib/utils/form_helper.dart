import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/utils/widget_helper.dart';

class FormHelper {
  static Widget textInput(
      BuildContext context,
      Object initialValue,
      Function onChanged, {
        Color focusColor,
        Color borderColor,
        double size,
        FontWeight fontWeight,
        Color textColor,
        bool isTextArea = false,
        bool isNumberInput = false,
        obscureText: false,
        Function onValidate,
        Widget prefixIcon,
        Widget suffixIcon,
      }) {
    return Container(
      height: 60,
      child: TextFormField(

        initialValue: initialValue != null ? initialValue.toString() : "",
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 0.0),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: borderColor!=null ? borderColor: grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: focusColor!=null ? focusColor: orange),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: orange),
            ),
          suffix: suffixIcon,
          hintText: initialValue,
          hintStyle: styleProvider(fontWeight: regular, size: dp15, color: grey)
        ),
        style: styleProvider(fontWeight: fontWeight, size: size, color: textColor),
        obscureText: obscureText,
        maxLines: !isTextArea ? 1 : 3,
        keyboardType: isNumberInput ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          return onChanged(value);
        },
        validator: (value) {
          return onValidate(value);
        },
      ),
    );
  }

  static InputDecoration fieldDecoration(
    BuildContext context,
    String hintText,
    String helperText, {
    Widget prefixIcon,
    Widget suffixIcon,
  }) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(6),
      hintText: hintText,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
    );
  }

  static Widget fieldLabel(String labelName, FontWeight fontWeight, double size,{Widget suffixIcon, Widget prefixIcon, Color color}) {
    return new Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: suffixIcon,
          ),
          Text(
            labelName,
            style: new TextStyle(
                fontWeight: fontWeight,
                fontSize: size,
                color: color!=null ? color: null
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:3.0, bottom: 7),
            child: prefixIcon,
          ),
        ],
      ),
    );
  }

  static Widget saveButton(String buttonText, Function onTap,
      {String color, String textColor, bool fullWidth}) {
    return Container(
      height: 50.0,
      width: 150,
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.redAccent,
              style: BorderStyle.solid,
              width: 1.0,
            ),
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void showMessage(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(title),
          content: new Text(message),
          actions: [
            new FlatButton(
              onPressed: () {
                return onPressed();
              },
              child: new Text(buttonText),
            )
          ],
        );
      },
    );
  }

  static Widget field(
    double Cont_height,
    double Box_Radius,
    Color Box_Color,
    double topPadding,
    double bottomPadding,
    double leftPadding,
    double rightPadding,
    String textLabel,
    String fontFamily,
    double lableFontSize,
    FontWeight lableFontWeight,
    Color lableFontColor,
    TextInputType inputType,
    String textfontFamily,
    double textlableFontSize,
    FontWeight textlableFontWeight,
    Color textlableFontColor,
  ) {
    return Container(
      height: Cont_height,
      child: Container(
        decoration: BoxDecoration(
            color: Box_Color,
            borderRadius: BorderRadius.all(Radius.circular(Box_Radius))),
        child: new Padding(
          padding: EdgeInsets.only(
              top: topPadding,
              left: leftPadding,
              bottom: bottomPadding,
              right: rightPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: new Text(textLabel,
                    style: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: lableFontSize,
                        fontWeight: lableFontWeight,
                        color: lableFontColor)),
              ),
              Expanded(
                  child: new TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.next,
                keyboardType: inputType,
                style: new TextStyle(
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              )),
            ],
          ),
        ),
      ),
    );
  }
}


Widget circularImageView ({String imageUrl, Function onCallback}){
  return Padding(
    padding: const EdgeInsets.only(left: 20.0, right: 15),
    child: Card(
      elevation: 10,
      shape: CircleBorder(side: BorderSide.none),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: CircleAvatar(
          radius: 50.0,
          backgroundImage: NetworkImage(imageUrl),
          backgroundColor: Colors.black,
        ),
      ),
    ),
  );
}

class customButton extends StatelessWidget{
  final GestureTapCallback onPressed;
  String title;
  customButton({@required this.onPressed, this.title});
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        child:  Padding(
          padding:
          EdgeInsets.only(left: 20, top: 10, right: 20),
          child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius:
                    BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(title,
                        style: styleProvider(fontWeight: regular, size: 14, color: white)),
                  ),
                ),
              )),

        ),
        onPressed: onPressed);
  }
}


