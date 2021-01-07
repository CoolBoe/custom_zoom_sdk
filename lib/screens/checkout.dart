import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/helper/screen_navigator.dart';
import 'package:wooapp/helper/shared_perference.dart';
import 'package:wooapp/screens/cart.dart';

class CheckOutScreen extends StatefulWidget {
  final String totalAmount;

  CheckOutScreen(
      {@required this.totalAmount,
      });
  @override
  _CheckOutScreenrState createState() => _CheckOutScreenrState();
}

class _CheckOutScreenrState extends State<CheckOutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: UiBuilder(),
      bottomNavigationBar: bottomBar(),
    );
  }

  Widget bottomBar(){
   return Padding(
      padding: EdgeInsets.all(0),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0)
            ]),
        child: Padding(
          padding: const EdgeInsets.only(
              top: 10.0, left: 20, bottom: 10, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("₹ ${widget.totalAmount}",
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 24)),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: GestureDetector(
                      onTap: () {
                        // changeScreen(context, CheckOutScreen(totalAmount: total));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 5, bottom: 5, right: 15),
                          child: Text('PLACE ORDER',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12)),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Widget _appBar(){
    return AppBar(
      backgroundColor: white,
      flexibleSpace: FlexibleSpaceBar(
        title: Text("Check Out",
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16.0,
                fontWeight: medium,
                color: black)),
        centerTitle: true,
      ),
      leading: GestureDetector(
          onTap: () {
            // Navigator.of(context).pushNamed(routes.MainPage_Route);
          },
          child: Icon(
            Icons.arrow_back,
            color: black,
          )),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SvgPicture.asset(ic_search),
        )
      ],
    );
  }
  Widget _promocode() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, left: 30, right: 30),
      child: GestureDetector(
        onTap: () {
          changeScreen(context, CartScreen());
        },
        child: Card(
          elevation: 2,
          color: Colors.transparent,
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: SvgPicture.asset(
                          'assets/icons/ic_coupon.svg',
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Apply Promo Code/Voucher",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
  Widget UiBuilder() {
    return Column(
      children: <Widget>[
        addressBuilder(),
      ],
    );
  }
  Widget addressBuilder(){
    BasePrefs.init();
    return  Padding(
      padding: const EdgeInsets.only( top:10, left: 20.0, right: 15),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: grey_200,
            borderRadius: BorderRadius.all(
                Radius.circular(4)),
            ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                elevation: 10,
                shape: CircleBorder(side: BorderSide.none),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(
                        'https://images.unsplash.com/photo-1529626455594-4ff0802cfb7e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1534&q=80'),
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              Container(
                width: 200,
                child: RichText(
                  text: TextSpan(
                      text: "${BasePrefs.getString(USER_NAME)}\n",
                      style: TextStyle(
                          color: Colors.black, fontSize: 14, fontFamily: fontName, fontWeight: medium),
                      children: <TextSpan>[
                        TextSpan(text: BasePrefs.getString(USER_ADDRESS)!=null ? BasePrefs.getString(USER_ADDRESS) : "",
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 10),
                        )
                      ]
                  ),
                ),
              ),
              Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 15,
            )
            ],
          ),
        ),
      ),
    );
  }
}
