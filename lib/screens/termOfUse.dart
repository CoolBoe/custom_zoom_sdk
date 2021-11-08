import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/screens/mainpage.dart';
import 'package:wooapp/widgets/app_bar.dart';

class TermsOfUseScreen extends StatefulWidget {
  const TermsOfUseScreen({Key key}) : super(key: key);
  @override
  TermsOfUseScreenState createState() => TermsOfUseScreenState();
}

class TermsOfUseScreenState extends State<TermsOfUseScreen> {
  Widget _CustomScrollView() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(color: Theme.of(context).canvasColor,),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Icon(Icons.circle,
                      size: 10,color: Theme.of(context).accentColor),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'On our app "user" means end user/customer accessing the app, its content and services.',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Icon(Icons.circle,
                      size: 10, color: Theme.of(context).accentColor),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'This is app is operated by Phoeniixx Designs Private Limited, a creative agency which provides IT services. Its registered office at A-253, second floor, Okhla Phase 1, Okhla Industrial Area, New Delhi - 110020.',
                      style: TextStyle(

                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Icon(Icons.circle,
                      size: 10, color: Theme.of(context).accentColor),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Anyone can use the app and its products either by registering on the site or without registering.',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Icon(Icons.circle,
                      size: 10, color: Theme.of(context).accentColor),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Prices of the products can be changed without prior notice to the user/customer.',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(top: 15, bottom: 30, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4, left: 8),
                  child: Icon(Icons.circle,
                      size: 10, color: Theme.of(context).accentColor),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      'Through, Google analytics admin can make a report of the number of users visiting the app.',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(context, "Terms of Service", suffixIcon: Container()),
      body: Container(
        color: Theme.of(context).backgroundColor,
        height: MediaQuery.of(context).size.height,
        child:  SingleChildScrollView(
          child: _CustomScrollView(),
        ),
      ),
    );
  }
}