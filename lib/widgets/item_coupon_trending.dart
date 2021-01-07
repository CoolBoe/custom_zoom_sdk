import 'package:flutter/cupertino.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/coupons.dart';

class Item_Coupon_Trending extends StatelessWidget{
  Coupons coupon;
  Item_Coupon_Trending({Key key, this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Container(
     width: 200,
     decoration: BoxDecoration(
         color: pink_10,
         border: Border.all(
             color: grey_200, width: 1.0),
         borderRadius:
         BorderRadius.all(Radius.circular(dp10))),
     child: Padding(
       padding: const EdgeInsets.all(30.0),
       child: Column(
        children: [
          RichText(
            text: TextSpan(
                text:"₹ "+coupon.amount+" Off ",
                style: TextStyle(
                    color: orange,
                    fontSize: dp20,
                    fontFamily: fontName,
                    fontWeight: bold),
                children: <TextSpan>[
                  TextSpan(text: '\n Check the best deals for today',
                      style: TextStyle(
                          color: orange_300,
                          fontSize: dp15,
                          fontWeight:regular,
                          ),
                  ),
                ]
            ),
          )
        ],
   ),
     ),
   );
  }
}

