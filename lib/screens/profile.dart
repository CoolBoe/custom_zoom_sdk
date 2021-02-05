import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/mockdata/item_categories.dart';
import 'package:wooapp/models/user.dart';
import 'package:wooapp/providers/user.dart';
import 'package:wooapp/screens/delivery.dart';
import 'package:wooapp/screens/editAccount.dart';
import 'package:wooapp/screens/offer.dart';
import 'package:wooapp/screens/order.dart';
import 'package:wooapp/screens/orderInfo.dart';
import 'package:wooapp/screens/payment.dart';
import 'package:wooapp/screens/privacy.dart';
import 'package:wooapp/screens/settings.dart';
import 'package:wooapp/utils/form_helper.dart';
import 'package:wooapp/utils/widget_helper.dart';
import 'package:wooapp/widgets/app_bar.dart';
import 'package:wooapp/widgets/loading.dart';

import 'notification.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key key}) : super(key: key);
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfileView> {
  Widget _CustomScrollView() {
    List<ByCatgories> sortBy = [
      ByCatgories("Orders", 0, ic_order),
      ByCatgories("Offers", 1, ic_shop),
      ByCatgories("Shipping Address", 2, ic_chat),
      ByCatgories("Billing Address", 3, ic_chat),
      // ByCatgories("Account Details", 0, ic_home),
      // ByCatgories("Notifications", 2,ic_categories),
      // ByCatgories("Payment Information", 4, ic_call),
      // ByCatgories("Language", 5, ic_support),
      // ByCatgories("Privacy Settings", 6, ic_rating),
    ];
    BasePrefs.init();
    Details model;
    if( BasePrefs.getString(USER_MODEL)!=null){
      var value= BasePrefs.getString(USER_MODEL);
      model = Details.fromJson(jsonDecode(value));
    }
    String date;
    if(model!=null && model.dateCreated!=null){
      DateTime tempDate =  DateTime.parse(model.dateCreated);
      date = DateFormat("MM/yyyy").format(tempDate);
    }

    var user= Provider.of<UserProvider>(context, listen: false);
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            circularImageView(imageUrl: user.getProfileImage(),
            onCallback: (value){
            }),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(),
                  child: Text(
                      model==null ? "Hi User":
                      model.firstName!=null && model.firstName!=""?
                      model.billing.firstName!=null && model.billing.firstName!="" ?
                  "Dear ${model.billing.firstName..toUpperCase()}" : "Dear ${model.firstName.toUpperCase()}" :
                  "Hi User",
                      style: styleProvider(fontWeight: semiBold, size: 18, color: black)),
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: Text(model!=null ? "Member Since: $date" : "",
                      style: styleProvider(fontWeight: regular, size: 10, color: black)),
                ),
                GestureDetector(onTap: (){
                  changeScreen(context, EditAccountScreen());
                  // toast("Restricted  Access");
                },
                child: Container(
                    width: 150,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color:accent_color,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 30, top: 5, bottom: 5),
                          child: Center(
                            child: Text('EDIT ACCOUNT',
                                style: styleProvider(fontWeight: regular, size: 8, color: white)),
                          ),
                        ),
                      ),
                    )),)
              ],
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 30, right: 20),
          child: Container(
            child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: sortBy.length,
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      switch(index){
                        case 0:
                          changeScreen(context, OrderHistory());
                          break;
                        case 1:
                          changeScreen(context, OfferScreen());
                          break;
                        case 2:
                          changeScreen(context, DeliveryScreen());
                          break;
                        case 3:
                          changeScreen(context, DeliveryScreen(total: "",));
                          break;
                        case 4:
                          changeScreen(context, PaymentScreen());
                          break;
                        case 5:
                          languageDialog();
                          break;
                        case 6:
                          changeScreen(context, PrivacyScreen());
                          break;
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            sortBy[index].name,
                            style: styleProvider(fontWeight: semiBold, size: 16, color: black),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        )
      ],
    );
  }
  void languageDialog() {
    showGeneralDialog(
        barrierLabel: "label",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        transitionDuration: Duration(milliseconds: 700),
        context: context,
        pageBuilder: (context, anim1, anim2) {
          return Material(
            type: MaterialType.transparency,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(3))),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text("Choose Your Preferred Language",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 30),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                    height: 35,
                                    margin: EdgeInsets.zero,
                                    child: Icon(
                                      Icons.close,
                                      color: Colors.black,
                                      size: 25,
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding:
                              EdgeInsets.only(left: 00, top: 10, right: 00),
                              child: Container(
                                  width: 150,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color:accent_color,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 35.0,
                                            right: 35,
                                            top: 5,
                                            bottom: 5),
                                        child: Center(
                                          child: Text('Hindi',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ))),
                          Padding(
                              padding:
                              EdgeInsets.only(left: 00, top: 10, right: 00),
                              child: Container(
                                  width: 150,
                                  color: Colors.transparent,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0,
                                            right: 20,
                                            top: 5,
                                            bottom: 5),
                                        child: Center(
                                          child: Text('English',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                  ))),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        transitionBuilder: (context, anim1, anim2, child) {
          return SlideTransition(
            position:
            Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
            child: child,
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(context, "Account",suffixIcon: Container(), prefixIcon: Container()),
      body: Container(
        child: _CustomScrollView(),
      ),
    );
  }
}
