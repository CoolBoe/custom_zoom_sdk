
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/screens/mainpage.dart';

class ChatScreen extends StatefulWidget {

  const ChatScreen({Key key}) : super(key: key);
  @override
  ChatScreenState createState()=>ChatScreenState();
}
class ChatScreenState extends State<ChatScreen>{

  Widget _CustomScrollView() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          expandedHeight: 50,
          flexibleSpace: FlexibleSpaceBar(
            title: Text("Chat Support",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
            centerTitle: true,
          ),
          floating: true,
          leading: GestureDetector(
              onTap: (){
                changeScreenReplacement(context, MainPageScreen());
              },
              child: Icon(
                Icons.arrow_back, color: Colors.black,
              )
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset('assets/icons/ic_search.svg'),
            )
          ],
        ),
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: RefreshIndicator(
              onRefresh: () async {
                await Future.value({});
              },
              child:  Center(child: _CustomScrollView())),
        ),
        bottomNavigationBar:  GestureDetector(onTap: (){
         changeScreenReplacement(context, MainPageScreen());
        },
        child:  Container(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color:  Colors.orange,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Text('Exit', style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 14)),
                ),
              ),
            )
        ),)
    );
  }
}

