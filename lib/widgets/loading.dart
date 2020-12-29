import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: AlertDialog(
          content: CircularProgressIndicator(),
        ));
  }
}

void loading(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: CircularProgressIndicator(),
      );
    },
  );
}

void toast(Object msg) {
  Fluttertoast.showToast(
    msg: msg.toString(),
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    // timeInSecForIosWeb: 2
  );
}

void printLog(String tag, Object msg) {
  if (msg != null) {
    if (tag != null || tag.trim().isEmpty) {
      print(tag + " => " + msg.toString());
    }
  }
}

void snackBar(String msg) {
  SnackBar(
      content: Text(
    msg,
    style: TextStyle(color: Colors.white, fontSize: 20),
  ));
}

void fieldFocusChange(
    BuildContext context, FocusNode currentfocus, FocusNode nextfocus) {
  currentfocus.unfocus();
  FocusScope.of(context).requestFocus(nextfocus);
}
