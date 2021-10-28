import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wooapp/helper/color.dart';
import 'package:wooapp/helper/constants.dart';
import 'package:wooapp/models/cart.dart';
import 'package:wooapp/models/coupons.dart';

class Item_Coupon_Trending extends StatelessWidget{
  int checkedIndex = 0;

  Coupons coupon;
  Item_Coupon_Trending({Key key, this.coupon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool checked = coupon == checkedIndex;
   return Stack(
     children: [
       Container(
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
                         color: accent_color,
                         fontSize: dp20,
                         fontFamily: fontName,
                         fontWeight: bold),
                     children: <TextSpan>[
                       TextSpan(text: '\n Check the best deals for today',
                         style: TextStyle(
                           color: accent_color_300,
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
       ),
       Positioned(
         top: 12,
         right: 12,
         child: Offstage(
           offstage: !checked,
           child: Container(
             decoration: BoxDecoration(
                 color: white,
                 border: Border.all(width: 2),
                 shape: BoxShape.circle),
             child: Icon(
               Icons.check,
               color: Colors.green,
             ),
           ),
         ),
       ),
     ],
   );
  }
}

