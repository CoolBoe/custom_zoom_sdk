import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key key}) : super(key: key);
  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(context, "Chat Support", suffixIcon: Container()),
        body: Container(

        ),
        bottomNavigationBar: customButton(title : "Exit",onPressed: (){
          Navigator.pop(context);
        },));
  }
}
