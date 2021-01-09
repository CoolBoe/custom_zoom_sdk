import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/models/mockdata/item_categories.dart';
import 'package:wooapp/screens/delivery.dart';
import 'package:wooapp/screens/editAccount.dart';
import 'package:wooapp/screens/language.dart';
import 'package:wooapp/screens/offer.dart';
import 'package:wooapp/screens/order.dart';
import 'package:wooapp/screens/paymet.dart';
import 'package:wooapp/screens/privacy.dart';
import 'package:wooapp/screens/settings.dart';
import 'package:wooapp/screens/termOfUse.dart';
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
      ByCatgories("Account Details", 0, ic_home),
      ByCatgories("Offers", 1, ic_shop),
      ByCatgories("Notifications", 2,ic_categories),
      ByCatgories("Delivery information", 3, ic_chat),
      ByCatgories("Payment Information", 4, ic_call),
      ByCatgories("Language", 5, ic_support),
      ByCatgories("Privacy Settings", 6, ic_rating),
    ];
    return Column(
      children: <Widget>[

        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            circularImageView(imageUrl:  'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80',
            onCallback: (value){

            }),
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(),
                  child: Text(BasePrefs.getString(USER_NAME).toString(),
                      style: styleProvider(fontWeight: semiBold, size: 18, color: black)),
                ),
                Padding(
                  padding: EdgeInsets.only(),
                  child: Text("Member since 2019",
                      style: styleProvider(fontWeight: regular, size: 10, color: black)),
                ),
                Container(
                    width: 150,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: Colors.orange,
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
                    ))
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(onTap: (){
                changeScreen(context, OrderScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SvgPicture.asset('assets/icons/ic_order.svg'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 20),
                      child: Text(
                        'Orders',
                        style: styleProvider(fontWeight: medium, size: 10, color: black),
                      ),
                    ),
                    Container(
                      height: 20,
                      child: VerticalDivider(
                        color: Colors.black,
                        width: 2,
                      ),
                    )
                  ],
                ),
              ),),
              GestureDetector(onTap: (){
                changeScreen(context, DeliveryScreen());
              },
              child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Padding(
                   padding: const EdgeInsets.only(left: 20.0),
                   child: SvgPicture.asset(ic_location),
                 ),
                 Padding(
                   padding: const EdgeInsets.only(left: 8.0, right: 20),
                   child: Text(
                       'My Address',
                       style: styleProvider(fontWeight: medium, size: 10, color: black)),
                 ),
                 Container(
                   height: 20,
                   child: VerticalDivider(
                     color: Colors.black,
                     width: 2,
                   ),
                 )
               ],
             ),),
              GestureDetector(onTap: (){
                changeScreen(context, SettingScreen());
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SvgPicture.asset(
                        'assets/icons/ic_support.svg',
                        height: 15,
                        width: 15,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 20),
                      child: Text(
                        'Settings',
                        style: styleProvider(fontWeight: medium, size: 10, color: black),
                      ),
                    ),
                  ],
                ),
              ),),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 30, right: 20),
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
                          printLog("buttonClicked", "Account Details");
                          changeScreen(context, EditAccountScreen());
                          break;
                        case 1:
                          printLog("buttonClicked", "Offers");
                          changeScreen(context, OfferScreen());
                          break;
                        case 2:
                          printLog("buttonClicked", "Notifications");
                          changeScreen(context, NotificationScreen());
                          break;
                        case 3:
                          printLog("buttonClicked", "Delivery information");
                          changeScreen(context, DeliveryScreen());
                          break;
                        case 4:
                          printLog("buttonClicked", "Payment Information");
                          changeScreen(context, PaymentScreen());
                          break;
                        case 5:
                          printLog("buttonClicked", "Language");
                          changeScreen(context, LanguageScreen());
                          break;
                        case 6:
                          printLog("buttonClicked", "Privacy Settings");
                          changeScreen(context, PrivacyScreen());
                          break;
                      }
                    },
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 25.0),
                            child: Text(
                              sortBy[index].name,
                                style: styleProvider(fontWeight: semiBold, size: 16, color: black),
                            ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(context, "Account",suffixIcon: Container()),
      body: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: _CustomScrollView(),
      ),
    );
  }
}
