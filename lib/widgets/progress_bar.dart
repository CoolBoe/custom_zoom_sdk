
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget progressBar(BuildContext context) {
  return Center(child: Column(
    children: <Widget>[
      CircularProgressIndicator(),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("Loading", style: TextStyle( color: Colors.black,  fontFamily: 'Poppins', fontSize: 14.0,
          fontWeight: FontWeight.w300,),),
      )
    ],
  ));


}